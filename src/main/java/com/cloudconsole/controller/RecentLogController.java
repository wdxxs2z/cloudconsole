package com.cloudconsole.controller;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.domain.ApplicationLog;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class RecentLogController {
	
//	private static final String DEALOG = "DEA";
//	private static final String APPLOG = "APP";
//	private static final String APILOG = "API";
//	private static final String RTRLOG = "RTR";
	
	@RequestMapping(value="/recentLog",method=RequestMethod.GET)
	@ResponseBody
	public String recentLog(HttpServletRequest request,HttpServletResponse response){
		
		Object clientObj = request.getSession().getAttribute("client");
		String appName= request.getParameter("name");
		
		StringBuffer sb = new StringBuffer();
		sb.append("<div class=" + "\"runlog\"" + ">");
		
		String logHeader = "<strong>========================================================================\n"+
				  		   appName+"'s Logs -prower by Cloud Foundry Console\n"+
				           "========================================================================</strong>\n";
		sb.append(logHeader);
		
		if(StringUtils.isNotBlank(appName) && clientObj != null){
			CloudFoundryClient client = (CloudFoundryClient)clientObj;
			
			List<ApplicationLog> recentLogs = client.getRecentLogs(appName);
			
			for(ApplicationLog applicationLog : recentLogs){
				sb.append("\n<hr style=\"border-top:2px solid #000000;\">\n");
				sb.append("<strong>").append(applicationLog.getTimestamp()).append("</strong>").append("--");
				if (applicationLog.getSourceName().equalsIgnoreCase("DEA")) {
					sb.append("<strong><font color=\"blue\">").append(applicationLog.getSourceName()).append("</font></strong>");
					sb.append("<br>");
					if (applicationLog.getMessageType().name().equalsIgnoreCase("STDERR")) {
						sb.append("<font color=\"red\">").append(applicationLog.getMessage()).append("</font>").append("\n");
					}else{
						sb.append(applicationLog.getMessage()).append("\n");
					}
				}else if (applicationLog.getSourceName().equalsIgnoreCase("API")) {
					sb.append("<strong><font color=\"green\">").append(applicationLog.getSourceName()).append("</font></strong>");
					sb.append("<br>");
					sb.append(applicationLog.getMessage()).append("\n");
				}else if (applicationLog.getSourceName().equalsIgnoreCase("APP")) {
					sb.append("<strong><font color=\"purple\">").append(applicationLog.getSourceName()).append("</font></strong>");
					sb.append("<br>");
					if (applicationLog.getMessageType().name().equalsIgnoreCase("STDERR")) {
						sb.append("<font color=\"red\">").append(applicationLog.getMessage()).append("</font>").append("\n");
					}else{
						sb.append(applicationLog.getMessage()).append("\n");
					}
				}else{
					sb.append("<strong>").append(applicationLog.getSourceName()).append("</strong>");
					sb.append("<br>");
					if (applicationLog.getMessageType().name().equalsIgnoreCase("STDERR")) {
						sb.append("<font color=\"red\">").append(applicationLog.getMessage()).append("</font>").append("\n");
					}else{
						sb.append(applicationLog.getMessage()).append("\n");
					}
				}
			}
			
			
		}
		sb.append("</div>");
		
		return sb.toString();
		
	}
	
	@RequestMapping(value="/log",method=RequestMethod.GET)
	@ResponseBody
	public String handleRequest(HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		Object clientObj = request.getSession().getAttribute("client");
		String appName= request.getParameter("name");

		StringBuffer sb = new StringBuffer();
		sb.append("<div class=" + "\"te\"" + ">");
		String logHeader =   "<strong>========================================================================\n"+
						     appName+"'s Logs -prower by Cloud Foundry Console\n"+
							 "========================================================================</strong>\n";
		sb.append(logHeader);
		
		if (StringUtils.isNotBlank(appName) && clientObj!=null) {
			CloudFoundryClient client = (CloudFoundryClient)clientObj;
			//2013-12-23
			@SuppressWarnings("deprecation")
			Map<String, String> logs= client.getLogs(appName);
			Iterator<Entry<String, String>> iterator = logs.entrySet().iterator();
			while(iterator.hasNext()){
				Entry<String, String> entry = iterator.next();
				sb.append("\n<hr style=\"border-top:2px solid #000000;\">\n<b>========================="+entry.getKey()+"=========================</b>\n");
				sb.append(entry.getValue()).append("\n");
			}
			
		}
		sb.append("</div>");
		
		return sb.toString();
	}
}
