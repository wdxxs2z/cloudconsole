package com.cloudconsole.monit.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloudconsole.model.MonitEvent;
import com.cloudconsole.monit.dao.MonitEventDao;
import com.cloudconsole.monit.service.MonitEventService;

@Service
public class MonitEventServiceImpl implements MonitEventService {

	@Autowired
	private MonitEventDao monitEventDao;
	
	@Override
	public List<MonitEvent> getMonitEvents() {
		return monitEventDao.getMonitEvents();
	}

	@Override
	public List<MonitEvent> getMonitEventByMonitId(String monitId) {
		return monitEventDao.getMonitEventByMonitId(monitId);
	}

	@Override
	public List<MonitEvent> getMonitEventByMonitIdAndType(String monitId,
			Integer server_type) {
		return monitEventDao.getMonitEventByMonitIdAndType(monitId, server_type);
	}


}
