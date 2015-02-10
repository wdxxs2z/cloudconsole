package com.cloudconsole.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.CloudFoundryException;
import org.cloudfoundry.client.lib.domain.CloudApplication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
public class AppOperationController {
	
	@RequestMapping(value="appOperation")
	public ModelAndView appOperation(HttpServletRequest request,HttpServletResponse response) throws IOException{
		boolean success = true;
		String errMsg= "";
		
		String appName = request.getParameter("appName");
		
		if (StringUtils.isBlank(appName)) {
			appName = request.getParameter("pk");
		}
		Object clientObj = request.getSession().getAttribute("client");
		if (clientObj != null && StringUtils.isNotBlank(appName)) {
			try{
				CloudFoundryClient client = (CloudFoundryClient)clientObj;
				CloudApplication app = client.getApplication(appName);
				if (app!=null) {
					//app restart,start,stop,delete
					String type = request.getParameter("type");
					if (StringUtils.isNotBlank(type)) {
						if ("restart".equalsIgnoreCase(type)) {
							client.restartApplication(appName);
						}else if ("start".equalsIgnoreCase(type)) {
							client.restartApplication(appName);
						}else if ("stop".equalsIgnoreCase(type)) {
							client.stopApplication(appName);
						}else if ("delete".equalsIgnoreCase(type)) {
							client.deleteApplication(appName);
						}
					}
					//update app attribute
					String name = request.getParameter("name");
					String value = request.getParameter("value");
					if (StringUtils.isNotBlank(name) && StringUtils.isNotBlank(value)) {
						if ("name".equalsIgnoreCase(name)) {
							client.rename(appName, value);
						}else	if ("memory".equalsIgnoreCase(name)) {
							client.updateApplicationMemory(appName, Integer.parseInt(value));
						}else if ("instances".equalsIgnoreCase(name)) {
							client.updateApplicationInstances(appName, Integer.parseInt(value));
						}
						
					}
				}
			}catch (Exception e) {
				success = false;
				errMsg = e.getMessage();
				if (e instanceof CloudFoundryException) {
					errMsg = errMsg+":"+((CloudFoundryException)e).getDescription();
				}
			}
		}
		response.getWriter().write("{success: "+success+", msg: \""+errMsg+"\"}");
		return null;
	}
	
	@RequestMapping(value="unbindAppUrl")
	public ModelAndView unbindAppUrl (HttpServletRequest request,HttpServletResponse response) {
		String appName = request.getParameter("name");
		String appUri = request.getParameter("uri");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		if (client != null && StringUtils.isNotBlank(appUri)) {
			List<String> uris = client.getApplication(appName).getUris();
			if (uris.contains(appUri)) {
				uris.remove(appUri);
				client.updateApplicationUris(appName, uris);
			}			
		}
		return new ModelAndView(new RedirectView("appView?name=" + appName));
	}
	
	@RequestMapping(value="bindAppUrl",method=RequestMethod.POST)
	public ModelAndView bindAppUrl (HttpServletRequest request,HttpServletResponse response) {
		String appName = request.getParameter("name");
		String[] uris = request.getParameterValues("uris");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		if (client != null && StringUtils.isNotBlank(appName)) {
			List<String> uriList = new ArrayList<String>();
			for (String uri : uris) {
				uriList.add(uri);
			}
			List<String> oldUris = client.getApplication(appName).getUris();
			uriList.addAll(oldUris);
			client.updateApplicationUris(appName, uriList);
		}				
		return new ModelAndView(new RedirectView("appView?name=" + appName));
	}
	
	@RequestMapping(value="addAppUrl",method=RequestMethod.POST)
	public ModelAndView addAppUrl (HttpServletRequest request,HttpServletResponse response) {
		String appName = request.getParameter("name");
		String host = request.getParameter("host");
		String subdomain = request.getParameter("subdomain");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		if (client != null && StringUtils.isNotBlank(appName) && StringUtils.isNotBlank(host) && StringUtils.isNotBlank(subdomain)) {
			List<String> uris = new ArrayList<String>();
			uris.add(host + "." +subdomain);
			List<String> oldUris = client.getApplication(appName).getUris();
			uris.addAll(oldUris);
			client.updateApplicationUris(appName, uris);
		}				
		return new ModelAndView(new RedirectView("appView?name=" + appName));
	}

}
