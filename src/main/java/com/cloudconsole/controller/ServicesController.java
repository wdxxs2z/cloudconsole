package com.cloudconsole.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.domain.CloudEntity.Meta;
import org.cloudfoundry.client.lib.domain.CloudService;
import org.cloudfoundry.client.lib.domain.CloudServiceOffering;
import org.cloudfoundry.client.lib.domain.CloudServicePlan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ServicesController {
private static final Logger logger = LoggerFactory.getLogger(ServicesController.class);
	
	@RequestMapping(value = "/services", method = RequestMethod.GET)
	public String services(Locale locale, Model model){
		logger.info("CloudFoundry DOMAIN.", locale);
		
		return "services";
	}	
	
	@RequestMapping(value="getServicePlan")
	public @ResponseBody Map<String,Object> getServicePlan(String serviceOffineName,HttpServletRequest request,
			HttpServletResponse response){
		Map<String,Object> offineJson = new HashMap<String, Object>();
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		List<CloudServiceOffering> serviceOfferings = client.getServiceOfferings();
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		for (CloudServiceOffering serviceOffine : serviceOfferings) {
			if (serviceOffine.getName().equals(serviceOffineName)) {
				List<CloudServicePlan> cloudServicePlans = serviceOffine.getCloudServicePlans();
				for (CloudServicePlan servicePlan : cloudServicePlans) {
					int index = 0;
					Map<String,Object> planMap = new HashMap<String, Object>();
					planMap.put("id", index);
					planMap.put("servicePlanName", servicePlan.getName());
					list.add(planMap);
					index++;
				}
			}
		}
		offineJson.put("servicePlans", list);
		return offineJson;
	}
	
	@RequestMapping(value="doCreateServiceInstance",method=RequestMethod.POST)
	public ModelAndView doCreateServiceInstance (HttpServletRequest request,
			HttpServletResponse response) {
		String serviceInstanceName = request.getParameter("serviceInstanceName");
		String serviceOffine = request.getParameter("serviceOffine");
		String servicePlan = request.getParameter("servicePlan");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		if (StringUtils.isNotBlank(serviceInstanceName) && StringUtils.isNotBlank(servicePlan) && StringUtils.isNotBlank(serviceOffine) 
				&& client != null) {
			Meta meta = new Meta(UUID.randomUUID(), new Date(), null);
			CloudService service = new CloudService(meta, serviceInstanceName);
			service.setPlan(servicePlan);
			service.setLabel(serviceOffine);
			client.createService(service);
		}
		return new ModelAndView("uploadApp");
	}
	

}
