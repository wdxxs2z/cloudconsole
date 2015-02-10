package com.cloudconsole.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.CloudFoundryException;
import org.cloudfoundry.client.lib.domain.CloudEntity.Meta;
import org.cloudfoundry.client.lib.domain.CloudOrganization;
import org.cloudfoundry.client.lib.domain.CloudSpace;
import org.cloudfoundry.client.lib.domain.CloudSpaceQuota;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class QuotaController {
	
	@RequestMapping(value="quotaManager")
	public ModelAndView quotaManager(HttpServletRequest request, HttpServletResponse response){
		
		
		return new ModelAndView("quotaManager");
	}
	
	@RequestMapping(value="doAddSpaceQuota",method=RequestMethod.POST)
	public ModelAndView doAddSpaceQuota(
			@RequestParam(value="quotaName",required=true) String quotaName,
			@RequestParam(value="total_services",required=true) String total_services,
			@RequestParam(value="total_routes",required=true) String total_routes,
			@RequestParam(value="memory_limit",required=true) String memory_limit,
			@RequestParam(value="orgSelect",required=true) String orgSelect,
			HttpServletRequest request, HttpServletResponse response){
		
		quotaName = request.getParameter("quotaName");
		total_services = request.getParameter("total_services");
		total_routes = request.getParameter("total_routes");
		memory_limit = request.getParameter("memory_limit");
		orgSelect = request.getParameter("orgSelect");
		
		CloudFoundryClient client = (CloudFoundryClient) request.getSession()
				.getAttribute("client");
		
		if(client!=null && StringUtils.isNotBlank(orgSelect) && StringUtils.isNotBlank(memory_limit) &&
				StringUtils.isNotBlank(total_routes) && StringUtils.isNotBlank(total_services) && StringUtils.isNotBlank(quotaName)){
			
			CloudOrganization organization = client.getOrgByName(orgSelect, true);
			Meta meta = new Meta(UUID.randomUUID(), new Date(), null);
			CloudSpaceQuota spaceQuota = new CloudSpaceQuota(meta, quotaName, 
					true, Integer.parseInt(total_services), Integer.parseInt(total_routes), 
					Integer.parseInt(memory_limit), organization.getMeta().getGuid().toString());
			
			client.createSpaceQuota(spaceQuota);
		}
		
		return new ModelAndView("organization");
	}
	
	@RequestMapping(value="doAssociateSpaceQuota",method=RequestMethod.POST)
	public ModelAndView doAssociateSpaceQuota(
			@RequestParam(value="associateQuota2Space",required=true) String associateQuota2Space,
			@RequestParam(value="associateQuota",required=true) String associateQuota,
			HttpServletRequest request, HttpServletResponse response){
		
		CloudFoundryClient client = (CloudFoundryClient) request.getSession()
				.getAttribute("client");
		String orgName = request.getParameter("orgName");
		if(client != null){
			client.associateSpaceWithSpaceQuota(associateQuota, associateQuota2Space, orgName);			
		}
		
		return new ModelAndView("organization"); 
	}
	
	@RequestMapping(value="spaceQuotaOperation")
	public ModelAndView spaceQuotaOperation(HttpServletRequest request, HttpServletResponse response) throws IOException{
		
		boolean success = true;
		String errMsg= "";
		
		String spaceQuotaName = request.getParameter("spaceQuotaName");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession()
				.getAttribute("client");
		if(StringUtils.isNotBlank(spaceQuotaName) && client!= null){
			try {
				client.deleteSpaceQuota(spaceQuotaName);
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
	
	@RequestMapping(value="/spaceQuotaInfo",method=RequestMethod.GET)
	@ResponseBody
	public String domainInfo(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException{
		
		Object clientObj = request.getSession().getAttribute("client");
		String spaceQuota = request.getParameter("name");
		
		StringBuffer sb = new StringBuffer();
		sb.append("<div class=" + "\"spaceQuotaTable\"" + ">");
		sb.append("<table class=" + "\"table table-bordered table-striped autoTable\"" + ">");
		sb.append("<thead><tr><td><strong>" + "配额名" + "</strong></td><td><strong>" + "分配空间名" + "</strong></td><td><strong>配额所属组织</strong></td></tr></thead>");
		sb.append("<tbody>");
		if(StringUtils.isNotBlank(spaceQuota) && clientObj != null){
			CloudFoundryClient client = (CloudFoundryClient)clientObj;
			List<CloudSpace> spaces = client.getSpacesWithSpaceQuota(spaceQuota);
			for(CloudSpace space : spaces){
				sb.append("<tr>");
				sb.append("<td>"+ spaceQuota + "</td>");
				sb.append("<td>"+ space.getName() + "</td>");
				sb.append("<td>"+ space.getOrganization().getName() + "</td>");
				sb.append("</tr>");			
			}			
		}
		sb.append("</tbody>");
		sb.append("</table>");
		sb.append("</div>");
		
		String load = sb.toString();
		String utf8 = new String(load.getBytes("UTF-8"),"ISO-8859-1");
		return utf8;
	}

}
