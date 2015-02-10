package com.cloudconsole.monit.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cloudconsole.model.MonitProcess;

public interface MonitProcessDao {
	
	List<MonitProcess> getMonitProcessByMonitId(String monitId);
	
	MonitProcess getMonitProcessByName(
			@Param(value="monitId") String monitId, 
			@Param(value="processName") String processName);
}
