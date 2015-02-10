package com.cloudconsole.monit.service;

import java.util.List;

import com.cloudconsole.model.MonitProcess;

public interface MonitProcessService {

	List<MonitProcess> getMonitProcessByMonitId(String monitId);
	
	MonitProcess getMonitProcessByName(String monitId, String processName);
}
