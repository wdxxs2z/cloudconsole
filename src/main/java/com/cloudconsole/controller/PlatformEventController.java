package com.cloudconsole.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.domain.CloudEvent;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PlatformEventController {
	
	@RequestMapping(value="eventView")
	public ModelAndView eventView(HttpServletRequest request, HttpServletResponse response){		
		return new ModelAndView("eventView");
	}
	
	@RequestMapping(value="getEventSchedule")
	public @ResponseBody String getEventSchedule(HttpServletRequest request, HttpServletResponse response) {
		StringBuilder sb = new StringBuilder();
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		if (client != null) {
			List<CloudEvent> events = client.getAllEvents();
			sb.append("[");
			for (CloudEvent event : events) {
				sb.append("{\"id\":\"" + event.getMeta().getGuid().toString() + "\"");
				sb.append(",\"title\":\"" + event.getType() + "\"");
				String timestamp = event.getTimestamp();
				String[] split = timestamp.split("\\+");
				sb.append(",\"start\":"  + "\"" + split[0] +"\"");
				sb.append(",\"allDay\":" + "false");
				sb.append(",\"description\":" + "\"" + event.getDescription() + "\"");
				if (event.getType().equalsIgnoreCase("app.crash")) {
					sb.append(",\"color\":" + "\"#d64f44\"");
				}
				sb.append("},");
			}
			sb.setLength(sb.length()-1);
		    sb.append("]");
		}
		return sb.toString();
	}
	
	@RequestMapping(value="getEventSchedules")
	public @ResponseBody String getEventSchedules(HttpServletRequest request, HttpServletResponse response) {
		String s = "[{'title': 'Start a project', start: new Date(y, m, 1)},{title: 'interview and data collection',start: new Date(y, m, 3),end: new Date(y, m, 7)}";
		return s;
	}

}
