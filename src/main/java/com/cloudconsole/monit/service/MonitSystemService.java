package com.cloudconsole.monit.service;

import java.util.List;

import com.cloudconsole.model.SystemBean;

public interface MonitSystemService {
	List<SystemBean> getMonitSystemByMonitId(String monitId);
}
