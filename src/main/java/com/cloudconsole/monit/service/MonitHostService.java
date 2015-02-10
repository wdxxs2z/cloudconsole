package com.cloudconsole.monit.service;

import java.util.List;

import com.cloudconsole.model.MonitHost;

public interface MonitHostService {
	
	List<MonitHost> getMonitHosts();
	
	MonitHost getMonitHostByHostName(String hostname);
	
	MonitHost getMonitHostByMonitId(String monitId);
}
