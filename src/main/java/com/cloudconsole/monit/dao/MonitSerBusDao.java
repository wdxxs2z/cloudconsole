package com.cloudconsole.monit.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cloudconsole.model.MonitSerBusBean;

public interface MonitSerBusDao {
	
	List<MonitSerBusBean> getServiceByIdAndType(
			@Param(value="monitId") String monitId,
			@Param(value="service_type") Integer service_type
			);
	
	List<MonitSerBusBean> getServiceByNameAndType(
			@Param(value="monitor_host") String monitor_host,
			@Param(value="service_type") Integer service_type
			);
}
