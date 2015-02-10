package com.cloudconsole.monit.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloudconsole.model.MonitProcess;
import com.cloudconsole.monit.dao.MonitProcessDao;
import com.cloudconsole.monit.service.MonitProcessService;

@Service
public class MonitProcessServiceImpl implements MonitProcessService {

	@Autowired
	private MonitProcessDao monitProcessDao;
	
	@Override
	public List<MonitProcess> getMonitProcessByMonitId(String monitId) {
		
		return monitProcessDao.getMonitProcessByMonitId(monitId);
	}

	@Override
	public MonitProcess getMonitProcessByName(String monitId, String processName) {
		return monitProcessDao.getMonitProcessByName(monitId,processName);
	}

}
