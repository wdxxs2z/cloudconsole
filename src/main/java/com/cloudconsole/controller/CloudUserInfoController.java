package com.cloudconsole.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CloudUserInfoController {
	
	@RequestMapping(value="/userinfo",method=RequestMethod.GET)
	public ModelAndView cloudUserInfo(HttpServletRequest request, HttpServletResponse response){
		ModelAndView view = new ModelAndView("userinfo");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		if (client != null) {
			return view;
		}
		return new ModelAndView("home");
	}
	
	@RequestMapping(value="changeCloudUserPSW",method=RequestMethod.POST)
	public ModelAndView changeCloudUserPSW (HttpServletRequest request, HttpServletResponse response) {
		String cloudUserName = request.getParameter("cloudUserName");
		String oldCloudUserPSW = request.getParameter("oldCloudUserPSW");
		String changePassword = request.getParameter("changePassword");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		if (client != null && StringUtils.isNotBlank(oldCloudUserPSW) && StringUtils.isNotBlank(cloudUserName) && StringUtils.isNotBlank(changePassword)) {
			client.updatePassword(changePassword);
		}		
		return new ModelAndView("login");
	}

}
