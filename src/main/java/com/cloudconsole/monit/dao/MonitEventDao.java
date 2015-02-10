package com.cloudconsole.monit.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cloudconsole.model.MonitEvent;

public interface MonitEventDao {

	List<MonitEvent> getMonitEvents();
	
	List<MonitEvent> getMonitEventByMonitIdAndType(@Param(value="monitId") String monitId, 
			@Param(value="server_type") Integer server_type);
	
	List<MonitEvent> getMonitEventByMonitId(String monitId);
	
}
