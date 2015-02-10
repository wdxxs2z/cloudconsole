package com.cloudconsole.monit.service;

import java.util.List;

import com.cloudconsole.model.MonitEvent;

public interface MonitEventService {

	List<MonitEvent> getMonitEvents();
	
	List<MonitEvent> getMonitEventByMonitId(String monitId);
	
	List<MonitEvent> getMonitEventByMonitIdAndType(String monitId, Integer server_type);
}
