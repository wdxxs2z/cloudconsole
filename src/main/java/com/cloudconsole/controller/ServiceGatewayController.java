package com.cloudconsole.controller;

import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.domain.CloudEntity.Meta;
import org.cloudfoundry.client.lib.domain.CloudServiceBroker;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ServiceGatewayController {
	
	@RequestMapping(value = "/serviceGateway", method = RequestMethod.GET)
	public String serviceGateway(HttpServletRequest request, HttpServletResponse response){
		return "serviceGateway";
	}
	
	@RequestMapping(value="createServiceBroker",method=RequestMethod.POST)
	public ModelAndView createServiceBroker(HttpServletRequest request, HttpServletResponse response) {
		
		String brokerName = request.getParameter("brokerName");
		String brokerURL = request.getParameter("brokerURL");
		String auth_username = request.getParameter("auth_username");
		String auth_password = request.getParameter("auth_password");
		
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		
		if (StringUtils.isNotBlank(brokerName) && StringUtils.isNotBlank(brokerURL) && 
				StringUtils.isNotBlank(auth_username) && StringUtils.isNotBlank(auth_password) &&
				client != null) {
			Meta meta = new Meta(UUID.randomUUID(), new Date(), null);
			CloudServiceBroker serviceBroker = new CloudServiceBroker(meta, brokerName, brokerURL, auth_username, auth_password);
			client.createServiceBroker(serviceBroker);
		}		
		return new ModelAndView("serviceGateway");
	}
}
