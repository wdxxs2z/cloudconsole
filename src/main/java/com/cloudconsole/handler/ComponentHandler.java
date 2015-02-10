package com.cloudconsole.handler;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.cloudfoundry.client.lib.util.JsonUtil;
import org.nats.Connection;
import org.nats.MsgHandler;
import org.springframework.security.crypto.codec.Base64;

import com.cloudconsole.model.CloudComponent;

public class ComponentHandler extends Thread{

	private Connection conn;
	private List<CloudComponent> components;
	
	public ComponentHandler() {
	}
	
	public ComponentHandler(Connection conn, List<CloudComponent> components) {
		this.conn = conn;
		this.components = components;
	}

	@Override
	public void run() {
		try {
			conn.request("vcap.component.discover", new MsgHandler() {
				public void execute(String msg) {
					components.add(getComponent(msg));
				}
			});
		} catch (IOException e) {
			e.printStackTrace();
		}
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
