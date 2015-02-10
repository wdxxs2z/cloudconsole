package com.cloudconsole.monit.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloudconsole.model.MonitHost;
import com.cloudconsole.monit.dao.MonitHostDao;
import com.cloudconsole.monit.service.MonitHostService;

@Service
public class MonitHostServiceImpl implements MonitHostService {

	@Autowired
	private MonitHostDao monitHostDao;
	
	@Override
	public List<MonitHost> getMonitHosts() {
		return monitHostDao.getMonitHosts();
	}

	@Override
	public MonitHost getMonitHostByHostName(String monitHostName) {
		return monitHostDao.getMonitHostByHostName(monitHostName);
	}

	@Override
	public MonitHost getMonitHostByMonitId(String monitId) {
		return monitHostDao.getMonitHostByMonitId(monitId);
	}

}
