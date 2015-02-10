package com.cloudconsole.monit.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloudconsole.model.SystemBean;
import com.cloudconsole.monit.dao.MonitSystemDao;
import com.cloudconsole.monit.service.MonitSystemService;

@Service
public class MonitSystemServiceImpl implements MonitSystemService {

	@Autowired
	private MonitSystemDao monitSystemDao;
	
	@Override
	public List<SystemBean> getMonitSystemByMonitId(String monitId) {
		return monitSystemDao.getMonitSystemByMonitId(monitId);
	}

}
