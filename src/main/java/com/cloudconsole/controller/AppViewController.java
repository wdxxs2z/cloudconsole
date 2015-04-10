package com.cloudconsole.controller;

import java.io.IOException;
import java.net.URI;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudCredentials;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.CloudFoundryException;
import org.cloudfoundry.client.lib.domain.ApplicationStats;
import org.cloudfoundry.client.lib.domain.CloudApplication;
import org.cloudfoundry.client.lib.domain.InstanceStats;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cloudconsole.common.ConfigUtil;

@Controller
public class AppViewController {
	
	@RequestMapping(value = "/appView", method = RequestMethod.GET)
	public ModelAndView appView(HttpServletRequest request, HttpServletResponse response){
		ModelAndView view = new ModelAndView("appView");
		String name = request.getParameter("name");
		if(StringUtils.isNotBlank(name)){
			CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
			CloudApplication application = client.getApplication(name);
			if(application != null){
				view.setViewName("appinfo");
			}
		}		
		return view;
	}
	
	@RequestMapping(value="deleteAppInstance")
	public ModelAndView deleteAppInstance (HttpServletRequest request, HttpServletResponse response) throws IOException {
		boolean success = true;
		String errMsg= "";
		String appName = request.getParameter("appname");
		String index = request.getParameter("index");
		String type = request.getParameter("type");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		if (client != null && StringUtils.isNotBlank(index) && StringUtils.isNotBlank(appName) && StringUtils.isNotBlank(type)) {
			try {
				if ("terminate".equalsIgnoreCase(type)) {
					client.deleteAppInstanceWithIndex(appName, Integer.parseInt(index));
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
	
	@RequestMapping(value="appSwitchSpace")
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
				request.getSession().setAttribute("client", client);
			} catch (Exception e) {
				errMessage = e.getMessage();
			}			
		}
		if(StringUtils.isNotBlank(errMessage)){
			ModelAndView original =new ModelAndView("appView");
			original.addObject("err", errMessage);
			return original;			
		}else{
			return new ModelAndView(new RedirectView("appView"));
		}
	}
	
	@RequestMapping(value="appCodeView")
	public ModelAndView appCodeView (HttpServletRequest request,HttpServletResponse response) {
		String appName = request.getParameter("name");
		String instance = request.getParameter("instance");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		getFiles(client, appName, Integer.parseInt(instance), "app/");
		return new ModelAndView("appCodeView");
	}

	private void getFiles(CloudFoundryClient client, String appName,int instance, String file) {
		Map<String, List<String>> dirs = getDir(client, appName, instance, file);
		Set<Map.Entry<String,List<String>>> entrySet = dirs.entrySet();
		for (Iterator<Map.Entry<String, List<String>>> it =entrySet.iterator();it.hasNext();) {
			Map.Entry<String, List<String>> next = (Map.Entry<String, List<String>>)it.next();
			List<String> files = next.getValue();
			if (files != null) {
				for (String f : files) {
					if (f.contains("/")) {
						getFiles(client, appName, instance, file + f);
					} else {
						
					}
				}				
			}
		}	
	}

	private Map<String,List<String>> getDir (CloudFoundryClient client, String appName, int instance, String dir) { 
		Map<String,List<String>> files = new HashMap<String, List<String>>();
		List<String> file = new ArrayList<String>();
		String stringLine = client.getFile(appName, instance, dir);
		if (stringLine != null) {
			String[] lines = stringLine.split("\\n");
			for (String line : lines) {
				String[] firstString = line.split(" ");
				String string = firstString[0];
				if (string.startsWith(".")) {			
				} else {
					file.add(string);
				}
			}
			files.put(dir, file);
		} else {
			files.put(dir, null);
		}		
		return files;
	}
	
	@RequestMapping(value="jqueryFileTree")
	public ModelAndView jqueryFileTree(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("jqueryFileTree");
	}
	
	@RequestMapping(value="appInstanceMemView")
	public @ResponseBody List<Map<String,Object>> appInstanceMemView(HttpServletRequest request,
			HttpServletResponse response) {
		String appName = request.getParameter("name");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		List<Map<String,Object>> mems = new ArrayList<Map<String,Object>>();
		if (client != null && StringUtils.isNotBlank(appName)) {
			ApplicationStats applicationStats = client.getApplicationStats(appName);
			List<InstanceStats> records = applicationStats.getRecords();
			for (InstanceStats stats : records) {
				if (stats.getState().name().equalsIgnoreCase("RUNNING")){
					Map<String,Object> instanceMap = new HashMap<String, Object>();
					List<Object> memInfo = new LinkedList<Object>();
					stats.getState().name();
					String name = stats.getId();
					Date time = stats.getUsage().getTime();
					int mem = stats.getUsage().getMem();
					memInfo.add(time);
					memInfo.add(mem / (1024 * 1024.0));
					instanceMap.put("name", name);
					List<List<Object>> datas = new ArrayList<List<Object>>();
					datas.add(memInfo);
					instanceMap.put("data", datas);
					mems.add(instanceMap);
				}				
			} 
		}
		return mems;
	}
	
	@RequestMapping(value="appInstanceCPUView")
	public @ResponseBody List<Map<String,Object>> appInstanceCPUView(HttpServletRequest request,
			HttpServletResponse response) {
		String appName = request.getParameter("name");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		List<Map<String,Object>> cpus = new ArrayList<Map<String,Object>>();
		if (client != null && StringUtils.isNotBlank(appName)) {
			ApplicationStats applicationStats = client.getApplicationStats(appName);
			List<InstanceStats> records = applicationStats.getRecords();
			for (InstanceStats stats : records) {
				if (stats.getState().name().equalsIgnoreCase("RUNNING")) {
					Map<String,Object> instanceMap = new HashMap<String, Object>();
					List<Object> cpuInfo = new LinkedList<Object>();
					String name = stats.getId();
					Date time = stats.getUsage().getTime();
					double cpu = stats.getUsage().getCpu();
					cpuInfo.add(time);
					cpuInfo.add(cpu / (1024 * 1024.0));
					instanceMap.put("name", name);
					List<List<Object>> datas = new ArrayList<List<Object>>();
					datas.add(cpuInfo);
					instanceMap.put("data", datas);
					cpus.add(instanceMap);
				}				
			} 
		}
		return cpus;
	} 
	
	@RequestMapping(value="spaceMemResourceView")
	public @ResponseBody List<Map<String,Object>> spaceMemResourceView(HttpServletRequest request,
			HttpServletResponse response){
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		List<Map<String,Object>> memResource = new ArrayList<Map<String,Object>>();
		if (client != null) {
			List<CloudApplication> applications = client.getApplications();
			//统计运行的应用占用资源
			int currentMem = 0;
			int totalMem = client.getCloudInfo().getLimits().getMaxTotalMemory()*1024*1024;
			int freeMem = 0;
			for (CloudApplication app : applications) {
				if (app.getRunningInstances()>0) {
					ApplicationStats applicationStats = client.getApplicationStats(app.getName());
					List<InstanceStats> records = applicationStats.getRecords();
					for (InstanceStats stats : records) {
						int mem = stats.getUsage().getMem();
						currentMem += mem;
					}
				}
			}
			freeMem = totalMem - currentMem;
			Map<String,Object> dataMap = new HashMap<String, Object>();
			List<List<Object>> datas = new LinkedList<List<Object>>();
			
			List<Object> freeMemList = new LinkedList<Object>();
			freeMemList.add("freeMem");
			freeMemList.add(freeMem);
			datas.add(freeMemList);
			
			List<Object> currentMemList = new LinkedList<Object>();
			currentMemList.add("currentMem");
			currentMemList.add(currentMem);
			datas.add(currentMemList);
			
			dataMap.put("data", datas);
			memResource.add(dataMap);
		}
		return memResource;
	}

}
