package com.cloudconsole.controller;

import java.io.IOException;
import java.net.URI;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudCredentials;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cloudconsole.common.ConfigUtil;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView home(HttpServletRequest request,
			HttpServletResponse response) {
		return new ModelAndView("home");
	}
	
	@RequestMapping(value="switchOrgSpace")
	public ModelAndView switchOrgSpace (HttpServletRequest request,HttpServletResponse response) throws IOException {
		String errMessage = "";
		String orgName = request.getParameter("orgName");
		String spaceName = request.getParameter("spaceName");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		CloudCredentials credentials = (CloudCredentials) request.getSession().getAttribute("cloudCredentialsUse");
		String domain = ConfigUtil.getConfigInstance().getDomain();
		URL cloudUrl = URI.create(domain).toURL();
		if (client != null && StringUtils.isNotBlank(spaceName) && StringUtils.isNotBlank(orgName)) {			
			try {
				client = new CloudFoundryClient(credentials, cloudUrl, orgName, spaceName, null, true);
				client.login();
				request.getSession().setAttribute("cloudCredentialsUse", credentials);
				request.getSession().setAttribute("client", client);
			} catch (Exception e) {
				errMessage = e.getMessage();
			}			
		}
		if(StringUtils.isNotBlank(errMessage)){
			ModelAndView original =new ModelAndView("home");
			original.addObject("err", errMessage);
			return original;			
		}else{
			return new ModelAndView(new RedirectView("home"));
		}
	}
	
}
