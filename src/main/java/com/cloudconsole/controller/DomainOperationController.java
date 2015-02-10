package com.cloudconsole.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.CloudFoundryException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DomainOperationController {
	
	@RequestMapping(value="domainOperation")
	public ModelAndView domainOperation(HttpServletRequest request,HttpServletResponse response)throws IOException{
		
		boolean success = true;
		String errMsg= "";
		
		String domainName = request.getParameter("domainName");
		
		Object clientObj = request.getSession().getAttribute("client");
		
		if (clientObj != null && StringUtils.isNotBlank(domainName)) {
			try {
				
				CloudFoundryClient client = (CloudFoundryClient)clientObj;
				if(domainName != null){
					String type = request.getParameter("type");
					if(StringUtils.isNotBlank(type)){
						if(type.equalsIgnoreCase("delete")){
							client.deleteDomain(domainName);
						}
					}
				}				
			} catch (Exception e) {
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

}
