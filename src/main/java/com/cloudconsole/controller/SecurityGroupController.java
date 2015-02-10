package com.cloudconsole.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.CloudFoundryException;
import org.cloudfoundry.client.lib.domain.CloudOrganization;
import org.cloudfoundry.client.lib.domain.CloudSecurityGroup;
import org.cloudfoundry.client.lib.domain.CloudSecurityRules;
import org.cloudfoundry.client.lib.domain.CloudSpace;
import org.cloudfoundry.client.lib.util.JsonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cloudconsole.common.Json2Util;
import com.cloudconsole.common.JsonValidator;

@Controller
public class SecurityGroupController {

	@RequestMapping(value="securityView")
	public ModelAndView securityView(HttpServletRequest request,HttpServletResponse response){		
		return new ModelAndView("securityView");
	}
	
	@RequestMapping(value="securityGroupInfo")
	public ModelAndView securityGroupInfo(HttpServletRequest request,HttpServletResponse response){
		
		ModelAndView view = new ModelAndView("securityView");
		String securityGroupName = request.getParameter("name");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession()
				.getAttribute("client");
		if (client != null && StringUtils.isNotBlank(securityGroupName)) {
			List<CloudSecurityGroup> securityGroups = client.getSecurityGroups();
			for(CloudSecurityGroup securityGroup : securityGroups){
				if (securityGroup.getName().equals(securityGroupName)) {
					view.setViewName("editSecurityGroup");
				}
			}
		}		
		return view;
	}
	
	@RequestMapping(value="doAddSecurityGroup",method=RequestMethod.POST)
	public ModelAndView doAddSecurityGroup(HttpServletRequest request,HttpServletResponse response){
		
		String securityGroupName = request.getParameter("securityGroupName");
		String jsonSecurityGroupRules =request.getParameter("securityGroupRules");
		jsonSecurityGroupRules = jsonSecurityGroupRules.trim();
		jsonSecurityGroupRules = JsonUtil.convertToJson(jsonSecurityGroupRules);
		Pattern p_space = Pattern.compile("\\s*|\t|\r|\n", Pattern.CASE_INSENSITIVE);  
        Matcher m_space = p_space.matcher(jsonSecurityGroupRules);  
        jsonSecurityGroupRules = m_space.replaceAll(""); // 过滤空格回车标签
        
        jsonSecurityGroupRules = jsonSecurityGroupRules.replace("\\r\\n", "");
        jsonSecurityGroupRules = jsonSecurityGroupRules.replace("\\", "").trim();
        if (jsonSecurityGroupRules.startsWith("\"")) {
        	jsonSecurityGroupRules = jsonSecurityGroupRules.substring(1, jsonSecurityGroupRules.length()-1);       	
        }
        
		CloudFoundryClient client = (CloudFoundryClient) request.getSession()
				.getAttribute("client");
		
		if (StringUtils.isNotBlank(securityGroupName) && StringUtils.isNotBlank(jsonSecurityGroupRules) && client != null) {
			boolean isJson = JsonValidator.validate(jsonSecurityGroupRules);
			if (isJson) {
				//List<Map<String, Object>> rules = new ArrayList<Map<String,Object>>();
				List<Map<String, Object>> rules = Json2Util.jsonObjList(jsonSecurityGroupRules);
				List<CloudSecurityRules> cloudSecurityRules = new ArrayList<CloudSecurityRules>();
				if (rules.size() != 0) {
					for (Map<String, Object> rule : rules) {
						if (rule.get("protocol").equals("icmp")) {
							String protocol = (String)rule.get("protocol");
							String destination = (String)rule.get("destination");
							Double doubleType = (Double)rule.get("type");
							int type = doubleType.intValue();
							Double doubleCode = (Double)rule.get("code");
							int code  = doubleCode.intValue();
							CloudSecurityRules securityRule = new CloudSecurityRules(protocol, destination, type, code);
							cloudSecurityRules.add(securityRule);
						}				
						if (rule.get("protocol").equals("tcp")) {
							String protocol = (String)rule.get("protocol");
							String destination = (String)rule.get("destination");
							String ports = (String)rule.get("ports");
							Boolean log = (Boolean) rule.get("log");
							CloudSecurityRules securityRule = new CloudSecurityRules(protocol, destination, ports, log);
							cloudSecurityRules.add(securityRule);
						}
						if (rule.get("protocol").equals("udp")) {
							String protocol = (String)rule.get("protocol");
							String destination = (String)rule.get("destination");
							String ports = (String)rule.get("ports");
							CloudSecurityRules securityRule = new CloudSecurityRules(protocol, destination, ports);
							cloudSecurityRules.add(securityRule);
						}
						if (rule.get("protocol").equals("all")) {
							String protocol = (String)rule.get("protocol");
							String destination = (String)rule.get("destination");
							CloudSecurityRules securityRule = new CloudSecurityRules(protocol, destination);
							cloudSecurityRules.add(securityRule);
						}
					}
				}
				client.createSecurityGroup(securityGroupName, cloudSecurityRules, null, null);
			}
		}
		return new ModelAndView("securityView");
	}
	
	@RequestMapping(value="editSecurityGroup")
	public ModelAndView editSecurityGroup(HttpServletRequest request,HttpServletResponse response){		
		return new ModelAndView("editSecurityGroup");
	}
	
	@RequestMapping(value="editSpaceWithSecGroup")
	public ModelAndView editSpaceWithSecGroup(HttpServletRequest request,
			HttpServletResponse response){
		
		String securityGroupName = request.getParameter("name");

		CloudFoundryClient client = (CloudFoundryClient) request.getSession()
				.getAttribute("client");
		List<String> spaceSecuritySelected = new ArrayList<String>();
		
		if (client != null && StringUtils.isNotBlank(securityGroupName)) {
			List<CloudSecurityGroup> securityGroups = client.getSecurityGroups();
			CloudSecurityGroup securityGroup = null;
			for (CloudSecurityGroup secGroup : securityGroups) {
				if (secGroup.getName().equals(securityGroupName)) {
					securityGroup = secGroup;
				}				
			}
			if (securityGroup != null) {
				List<CloudSpace> cloudSpaces = securityGroup.getCloudSpaces();
				for (CloudSpace space : cloudSpaces) {
					String split = space.getOrganization().getName() + "--" +space.getName();
					spaceSecuritySelected.add(split);
				}
				request.getSession().setAttribute("spaceSecuritySelected", spaceSecuritySelected);
			}
		}
		return new ModelAndView("editSpaceWithSecGroup");
	}
	
	@RequestMapping(value="editSpacesFromSecurityGroup",method=RequestMethod.POST)
	public ModelAndView editSpacesFromSecurityGroup(HttpServletRequest request,
			HttpServletResponse response){
		String securityGroupName = request.getParameter("securityGroup");
		String[] orgspace = request.getParameterValues("orgspace");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession()
				.getAttribute("client");
		if (client != null && StringUtils.isNotBlank(securityGroupName) && orgspace != null) {
			List<CloudSecurityGroup> securityGroups = client.getSecurityGroups();
			CloudSecurityGroup securityGroup = null;
			for (CloudSecurityGroup secGroup : securityGroups) {
				if (secGroup.getName().equals(securityGroupName)) {
					securityGroup = secGroup;
				}				
			}
			if (securityGroup != null) {
				List<CloudSpace> securityCloudSpaces = securityGroup.getCloudSpaces();
				//移除
				for (CloudSpace securityCloudSpace : securityCloudSpaces) {
					String spaceGuid = securityCloudSpace.getMeta().getGuid().toString();
					CloudOrganization securityCloudOrganization = securityCloudSpace.getOrganization();
					String split = securityCloudOrganization.getName() + "--" + securityCloudSpace.getName();
					Boolean exitFlag = false;
					for(String s : orgspace){
						if (s.equals(split)) {
							exitFlag = true;
						}
					}
					if (exitFlag == false) {
						client.deleteSpaceFromSecurityGroup(securityGroupName, spaceGuid);
					}
				}
				//新增
				for (String newSplit : orgspace) {
					Boolean exitFlag = false;
					for (CloudSpace securityCloudSpace : securityCloudSpaces) {
						String existSplit = securityCloudSpace.getOrganization().getName() + "--" + securityCloudSpace.getName();
						if (existSplit.equals(newSplit)) {
							exitFlag = true;
						}
					}
					if (exitFlag == false) {
						String[] newOrgSpace = newSplit.split("--");
						client.setSpaceWithSecurityGroup(securityGroupName, newOrgSpace[1], newOrgSpace[0]);
					}
				}
			}			
		}	
		//为空则清除所有
		if (client != null && StringUtils.isNotBlank(securityGroupName) && orgspace == null) {
			List<CloudSecurityGroup> securityGroups = client.getSecurityGroups();
			CloudSecurityGroup securityGroup = null;
			for (CloudSecurityGroup secGroup : securityGroups) {
				if (secGroup.getName().equals(securityGroupName)) {
					securityGroup = secGroup;
				}				
			}
			if (securityGroup != null) {
				List<CloudSpace> securityCloudSpaces = securityGroup.getCloudSpaces();
				for (CloudSpace space : securityCloudSpaces) {
					client.deleteSpaceFromSecurityGroup(securityGroupName, space.getMeta().getGuid().toString());
				}
			}
		}
		return new ModelAndView("securityView");
	}
	
	@RequestMapping(value="bindSecurityGroup2Space",method=RequestMethod.POST)
	public ModelAndView bindSecurityGroup2Space(HttpServletRequest request,
			HttpServletResponse response){
		String securityGroupName = request.getParameter("selectSecurityGroup");
		String spaceGuid = request.getParameter("teamSelect");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession()
				.getAttribute("client");
		
		if (client != null && StringUtils.isNotBlank(securityGroupName) && StringUtils.isNotBlank(spaceGuid)) {
			client.setSpaceWithSecurityGroup(securityGroupName, spaceGuid);
		}		
		return new ModelAndView("securityView");
	}
	
	@RequestMapping(value="securityGroupOperation")
	public ModelAndView securityGroupOperation(HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		
		boolean success = true;
		String errMsg= "";
		
		String securityGroupName = request.getParameter("pk");
		if (StringUtils.isBlank(securityGroupName)) {
			securityGroupName = request.getParameter("securityGroupName");
		}

		Object clientObj = request.getSession().getAttribute("client");
		if (clientObj != null && StringUtils.isNotBlank(securityGroupName)) {
			try {
				CloudFoundryClient client = (CloudFoundryClient)clientObj;
				List<CloudSecurityGroup> securityGroups = client.getSecurityGroups();
				CloudSecurityGroup securityGroup = null;
				for (CloudSecurityGroup secGroup : securityGroups) {
					if (secGroup.getName().equals(securityGroupName)) {
						securityGroup = secGroup;
					}				
				}
				if (securityGroup != null) {
					String type = request.getParameter("type");
					if (StringUtils.isNotBlank(type)) {
						if ("delete".equalsIgnoreCase(type)) {
							client.deleteSecurityGroup(securityGroupName);
						}
					}					
					String name = request.getParameter("name");
					String value = request.getParameter("value");
					if (StringUtils.isNotBlank(name) && StringUtils.isNotBlank(value)) {
						if ("name".equalsIgnoreCase(name)) {
							securityGroup.setName(value);
							client.updateSecurityGroup(securityGroup);
						}else if ("staging".equalsIgnoreCase(name)) {
							Boolean isStaging = Boolean.parseBoolean(value);
							if (isStaging) {
								client.setSecurityGroupForStaging(securityGroup);
							} else {
								client.deleteSecurityForStaging(securityGroup);
							}
						}else if ("running".equalsIgnoreCase(name)) {
							Boolean isRunning = Boolean.parseBoolean(value);
							if (isRunning) {
								client.setSecurityGroupForRunningApps(securityGroup);
							} else {
								client.deleteSecurityGroupForRunningApps(securityGroup);
							}
						}else if ("rules".equalsIgnoreCase(name)) {
							String jsonSecurityGroupRules = value;
							jsonSecurityGroupRules = jsonSecurityGroupRules.trim();
							jsonSecurityGroupRules = JsonUtil.convertToJson(jsonSecurityGroupRules);
							Pattern p_space = Pattern.compile("\\s*|\t|\r|\n", Pattern.CASE_INSENSITIVE);  
					        Matcher m_space = p_space.matcher(jsonSecurityGroupRules);  
					        jsonSecurityGroupRules = m_space.replaceAll(""); // 过滤空格回车标签					        
					        jsonSecurityGroupRules = jsonSecurityGroupRules.replace("\\r\\n", "");
					        jsonSecurityGroupRules = jsonSecurityGroupRules.replace("\\", "").trim();
					        if (jsonSecurityGroupRules.startsWith("\"")) {
					        	jsonSecurityGroupRules = jsonSecurityGroupRules.substring(1, jsonSecurityGroupRules.length()-1);       	
					        }
					        boolean isJson = JsonValidator.validate(jsonSecurityGroupRules);
							if (isJson) {
								//List<Map<String, Object>> rules = new ArrayList<Map<String,Object>>();
								List<Map<String, Object>> rules = Json2Util.jsonObjList(jsonSecurityGroupRules);
								List<CloudSecurityRules> cloudSecurityRules = new ArrayList<CloudSecurityRules>();
								if (rules.size() != 0) {
									for (Map<String, Object> rule : rules) {
										if (rule.get("protocol").equals("icmp")) {
											String protocol = (String)rule.get("protocol");
											String destination = (String)rule.get("destination");
											Double doubleType = (Double)rule.get("type");
											int icmp_type = doubleType.intValue();
											Double doubleCode = (Double)rule.get("code");
											int icmp_code  = doubleCode.intValue();
											CloudSecurityRules securityRule = new CloudSecurityRules(protocol, destination, icmp_type, icmp_code);
											cloudSecurityRules.add(securityRule);
										}				
										if (rule.get("protocol").equals("tcp")) {
											String protocol = (String)rule.get("protocol");
											String destination = (String)rule.get("destination");
											String ports = (String)rule.get("ports");
											Boolean log = null;
											if (rule.get("log") != null) {
												log = (Boolean) rule.get("log");
											}else {
												log = null;
											}
											CloudSecurityRules securityRule = new CloudSecurityRules(protocol, destination, ports, log);
											cloudSecurityRules.add(securityRule);
										}
										if (rule.get("protocol").equals("udp")) {
											String protocol = (String)rule.get("protocol");
											String destination = (String)rule.get("destination");
											String ports = (String)rule.get("ports");
											CloudSecurityRules securityRule = new CloudSecurityRules(protocol, destination, ports);
											cloudSecurityRules.add(securityRule);
										}
										if (rule.get("protocol").equals("all")) {
											String protocol = (String)rule.get("protocol");
											String destination = (String)rule.get("destination");
											CloudSecurityRules securityRule = new CloudSecurityRules(protocol, destination);
											cloudSecurityRules.add(securityRule);
										}
									}
									securityGroup.setRules(cloudSecurityRules);
									client.updateSecurityGroup(securityGroup);
								}
							}
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