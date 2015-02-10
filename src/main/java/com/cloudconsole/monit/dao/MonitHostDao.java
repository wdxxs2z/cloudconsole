package com.cloudconsole.monit.dao;

import java.util.List;

import com.cloudconsole.model.MonitHost;

public interface MonitHostDao {
	
	List<MonitHost> getMonitHosts();
	
	MonitHost getMonitHostByHostName(String monitHostName);
	
	MonitHost getMonitHostByMonitId(String monitId);

}
