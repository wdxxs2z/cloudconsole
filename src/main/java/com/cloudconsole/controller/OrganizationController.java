package com.cloudconsole.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.CloudFoundryException;
import org.cloudfoundry.client.lib.domain.CloudEntity.Meta;
import org.cloudfoundry.client.lib.domain.CloudQuota;
import org.cloudfoundry.client.lib.domain.CloudUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class OrganizationController {
	
	@RequestMapping(value = "/organization", method = RequestMethod.GET)
	public ModelAndView organization(HttpServletRequest request, HttpServletResponse response){
		
		CloudFoundryClient client = (CloudFoundryClient)request.getSession().getAttribute("client");
		if(client != null){
			List<CloudUser> allUsers = client.getAllUsers();
			List<CloudUser> notRegisterUsers = new ArrayList<CloudUser>();
			for(CloudUser user : allUsers){
				if(user.getOrganizations().size()==0 ){
					notRegisterUsers.add(user);
				}
			}
			request.getSession().setAttribute("notRegisterUsers", notRegisterUsers);
		}		
		ModelAndView orgModel = new ModelAndView("organization");		
		return orgModel;
	}
	
	@RequestMapping(value="/orgManager", method=RequestMethod.GET)
	public ModelAndView orgManager(HttpServletRequest request, HttpServletResponse response){
		ModelAndView view = new ModelAndView("organization");
		String orgName = request.getParameter("orgName");
		CloudFoundryClient client = (CloudFoundryClient)request.getSession().getAttribute("client");
		if(StringUtils.isNotBlank(orgName) && client!=null){
			if(client.getOrgByName(orgName, true)!=null){
				view.setViewName("orgManager");
			}
		}		
		return view;
	}
	
	@RequestMapping(value="/doAddOrganization", method=RequestMethod.POST)
	public ModelAndView doAddOrganization(HttpServletRequest request, HttpServletResponse response){
		String orgName = request.getParameter("orgName");
		String orgQuota = request.getParameter("orgQuota");
		CloudFoundryClient client = (CloudFoundryClient)request.getSession().getAttribute("client");
		if(client != null && StringUtils.isNotBlank(orgName)){
			if (StringUtils.isNotBlank(orgQuota)) {
				client.createOrganization(orgName, orgQuota);
			} else {
				client.createOrganization(orgName, null);
			}			
		}
		return new ModelAndView("organization");
	}
	
	@RequestMapping(value="doCreateOrgQuota",method=RequestMethod.POST)
	public ModelAndView doCreateOrgQuota(
			@RequestParam(value="orgQuotaName",required=true) String orgQuotaName,
			@RequestParam(value="total_services",required=true) String total_services,
			@RequestParam(value="total_routes",required=true) String total_routes,
			@RequestParam(value="memory_limit",required=true) String memory_limit,
			HttpServletRequest request, HttpServletResponse response){
		
		orgQuotaName = request.getParameter("orgQuotaName");
		total_services = request.getParameter("total_services");
		total_routes = request.getParameter("total_routes");
		memory_limit = request.getParameter("memory_limit");
		
		CloudFoundryClient client = (CloudFoundryClient)request.getSession().getAttribute("client");
		if (client != null) {
			Meta meta = new Meta(UUID.randomUUID(), new Date(), null);
			CloudQuota quota = new CloudQuota(meta, orgQuotaName, true, Integer.parseInt(total_services), Integer.parseInt(total_routes), Integer.parseInt(memory_limit));
			client.createQuota(quota);
		}		
		return new ModelAndView("organization");
	}
	
	@RequestMapping(value="doAssociateOrgQuota",method=RequestMethod.POST)
	public ModelAndView doAssociateOrgQuota(HttpServletRequest request, HttpServletResponse response) {
		
		String associateOrgQuota = request.getParameter("associateOrgQuota");
		String orgSelect = request.getParameter("orgSelect");
		
		CloudFoundryClient client = (CloudFoundryClient)request.getSession().getAttribute("client");
		if (client != null) {
			client.setQuotaToOrg(orgSelect, associateOrgQuota);
		}		
		return new ModelAndView("organization");
	}
	
	@RequestMapping(value="orgQuotaOperation",method=RequestMethod.GET)
	public ModelAndView orgQuotaOperation(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		boolean success = true;
		String errMsg= "";
		
		String orgQuotaName = request.getParameter("orgQuotaName");
		CloudFoundryClient client = (CloudFoundryClient)request.getSession().getAttribute("client");
		if (client != null && StringUtils.isNotBlank(orgQuotaName)) {
			try {
				client.deleteQuota(orgQuotaName);
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
