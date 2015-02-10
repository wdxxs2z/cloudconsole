package com.cloudconsole.monit.service;

import java.util.List;

import com.cloudconsole.model.MonitSerBusBean;

public interface MonitSerBusService {

	List<MonitSerBusBean> getServiceByIdAndType(String monitId, Integer service_type);
	
	List<MonitSerBusBean> getServiceByNameAndType(String monitor_host, Integer service_type);

}
