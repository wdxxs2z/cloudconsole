package com.cloudconsole.monit.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloudconsole.model.MonitSerBusBean;
import com.cloudconsole.monit.dao.MonitSerBusDao;
import com.cloudconsole.monit.service.MonitSerBusService;

@Service
public class MonitSerBusServiceImpl implements MonitSerBusService {
	
	@Autowired
	private MonitSerBusDao monitSerBusDao;

	@Override
	public List<MonitSerBusBean> getServiceByIdAndType(String monitId,
			Integer service_type) {
		
		return monitSerBusDao.getServiceByIdAndType(monitId, service_type);
	}

	@Override
	public List<MonitSerBusBean> getServiceByNameAndType(String monitor_host,
			Integer service_type) {
		return monitSerBusDao.getServiceByNameAndType(monitor_host, service_type);
	}



}
