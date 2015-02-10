package com.cloudconsole.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.CloudFoundryException;
import org.cloudfoundry.client.lib.domain.CloudRoute;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
public class DomainController {
	
	@RequestMapping(value = "/domain", method = RequestMethod.GET)
	public ModelAndView domain(HttpServletRequest request, HttpServletResponse response){
		ModelAndView view = new ModelAndView("domain");
		String doaminName = request.getParameter("name");
		if(StringUtils.isNotBlank(doaminName)){
			CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
			List<CloudRoute> routes = client.getRoutes(doaminName);
			if(routes != null){
				view.setViewName("domaininfo");
			}
		}		
		return view;
	}
	
	@RequestMapping(value = "/addDomain",method = RequestMethod.GET)
	public ModelAndView addDomain(HttpServletRequest request, HttpServletResponse response){
		
		return new ModelAndView("addDomain");
	}
	
	@RequestMapping(value = "/newDomain",method = RequestMethod.POST)
	public ModelAndView newDomain(
			@RequestParam(value="domainname",required=false) String domainname,
			@RequestParam(value="orgName",required=false) String orgName,
			HttpServletRequest request, HttpServletResponse response) throws IOException{
		
		boolean success = true;
		String errMsg= "";
		try {
			CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");			
			domainname = request.getParameter("domainname");
			orgName = request.getParameter("orgName");
			
			if (StringUtils.isNotBlank(domainname) && client != null){
				client.addDomain(domainname);
			}
			
		} catch (Exception e) {
			success = false;
			errMsg = e.getMessage();
			if (e instanceof CloudFoundryException) {
				errMsg = errMsg+":"+((CloudFoundryException)e).getDescription();
			}
		}
		
		response.getWriter().write("{success: "+success+", msg: \""+errMsg+"\"}");
		return new ModelAndView(new RedirectView("domain"));
	}
	
	@RequestMapping(value="/domainInfo",method=RequestMethod.GET)
	@ResponseBody
	public String domainInfo(HttpServletRequest request, HttpServletResponse response){
		
		Object clientObj = request.getSession().getAttribute("client");
		String domainName = request.getParameter("name");
		
		StringBuffer sb = new StringBuffer();
		sb.append("<div class=" + "\"domaintable\"" + ">");
		
		String logHeader = "<strong>========================================================================\n"+
				domainName + "'s Routers -prower by Cloud Foundry Console\n"+
				           "========================================================================</strong>\n";
		sb.append(logHeader);
		sb.append("<table class=" + "\"table table-bordered table-striped autoTable\"" + ">");
		sb.append("<thead><tr><td>" + "Name" + "</td><td>" + "Host" + "</td><td>" + "UseNum" + "</td><td>" + "IsUse" + "</td><td>" + "Clear" +"</td></tr></thead>");
		sb.append("<tbody>");
		if(StringUtils.isNotBlank(domainName) && clientObj != null){
			CloudFoundryClient client = (CloudFoundryClient)clientObj;
			List<CloudRoute> routes = client.getRoutes(domainName);	
			for(CloudRoute route : routes){
				sb.append("<tr>");
				sb.append("<td>"+ route.getName() + "</td>");
				sb.append("<td>"+ route.getHost() + "</td>");
				sb.append("<td>"+ route.getAppsUsingRoute() + "</td>");
				sb.append("<td>"+ route.inUse() + "</td>");
				sb.append("<td>" + "</td>");
				sb.append("</tr>");			
			}			
		}
		sb.append("</tbody>");
		sb.append("</table>");
		sb.append("</div>");
		
		return sb.toString();
	}
	

}
