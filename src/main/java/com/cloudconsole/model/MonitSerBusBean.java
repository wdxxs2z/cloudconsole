package com.cloudconsole.model;

import java.io.Serializable;

public class MonitSerBusBean implements Serializable{

	private static final long serialVersionUID = 7575819197901147475L;
	
	/*service_id*/
	private int id;
	
	/*service_name*/
	private String service_name;
	
	/*service_type*/
	private int service_type;
	
	/*service_status*/
	private int service_status;
	
	/*service monit listen*/
	private int service_monit;
	
	/*service monitor IP*/
	private String monitor_host;
	
	/*monitId*/
	private String monitId;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getService_name() {
		return service_name;
	}

	public void setService_name(String service_name) {
		this.service_name = service_name;
	}

	public int getService_type() {
		return service_type;
	}

	public void setService_type(int service_type) {
		this.service_type = service_type;
	}

	public int getService_status() {
		return service_status;
	}

	public int getService_monit() {
		return service_monit;
	}

	public void setService_monit(int service_monit) {
		this.service_monit = service_monit;
	}

	public void setService_status(int service_status) {
		this.service_status = service_status;
	}

	public String getMonitor_host() {
		return monitor_host;
	}

	public void setMonitor_host(String monitor_host) {
		this.monitor_host = monitor_host;
	}

	public String getMonitId() {
		return monitId;
	}

	public void setMonitId(String monitId) {
		this.monitId = monitId;
	}
	
}
