package com.cloudconsole.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.cloudfoundry.client.lib.util.JsonUtil;
import org.nats.Connection;
import org.nats.MsgHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.codec.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cloudconsole.common.ConfigUtil;
import com.cloudconsole.model.CloudComponent;

@Controller
public class MonitController {
private static final Logger logger = LoggerFactory.getLogger(MonitController.class);
	
	@RequestMapping(value = "/monit", method = RequestMethod.GET)
	public ModelAndView monit(Locale locale, Model model,HttpServletRequest request,
			HttpServletResponse response) throws IOException, InterruptedException{
		final List<CloudComponent> components = new ArrayList<CloudComponent>();
		Properties properties = new Properties();
		String nats_Servers = ConfigUtil.getConfigInstance().getNats_Servers();
		properties.put("servers", nats_Servers);
		final Connection conn = Connection.connect(properties);
		if (conn.isConnected()) {
			conn.request("vcap.component.discover", new MsgHandler() {
				@Override
				public void execute(String msg) {
					components.add(getComponent(msg));
				}
			});
		}else{
			logger.error("Nats services can't connect", locale);
		}
		Thread.sleep(3500);
		request.getSession().setAttribute("components", components);
		return new ModelAndView("monit");
	}

	@SuppressWarnings("unchecked")
	protected CloudComponent getComponent(String msg) {
		Map<String, Object> msgMap = JsonUtil.convertJsonToMap(msg);
		String componentName = (String) msgMap.get("type");
		int index = (int) msgMap.get("index");
		String host = (String) msgMap.get("host");
		String uuid = (String) msgMap.get("uuid");
		List<String> credentials = (List<String>) msgMap.get("credentials");
		handlerHttpRequest(host, credentials);
		CloudComponent cloudComponent = new CloudComponent(componentName, index, uuid, host, credentials);
		return cloudComponent;
	}

	private void handlerHttpRequest(String host, List<String> credentials) {
		PostMethod postMethod = null;
		try {
			postMethod = new PostMethod("http://" + host + "/varz");
			String encode = new String(Base64.encode((new String(credentials.get(0) + ":" + credentials.get(1)).getBytes())));
			postMethod.setRequestHeader("Authorization", "Basic " + encode);
			HttpClient client = new HttpClient();
			int statusCode = client.executeMethod(postMethod);
			if (statusCode != HttpStatus.SC_OK) {
				System.out.println("Method failed code="+statusCode+": " + postMethod.getStatusLine());
			} else {
				System.out.println(new String(postMethod.getResponseBody(), "utf-8"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {  
			if (postMethod != null) {
				postMethod.releaseConnection();
			}			  
        }
		
	}

}
