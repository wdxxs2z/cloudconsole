package com.cloudconsole.monit.dao;

import java.util.List;

import com.cloudconsole.model.SystemBean;

public interface MonitSystemDao {

	List<SystemBean> getMonitSystemByMonitId(String monitId);
	
}
