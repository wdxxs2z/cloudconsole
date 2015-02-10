package com.cloudconsole.model;

import java.io.Serializable;

public class MonitEvent implements Serializable{
	
	private static final long serialVersionUID = 5508206426832520416L;
	
	/*Event id*/
	private int event_id;
	
	/*MonitBean 一对多关联monit*/
	private MonitHost monithost;
	
	/*collected_sec*/
	private String collected_sec;
	
	/*collected_usec*/
	private String collected_usec;
	
	/*service event*/
	private String service;
	
	/*message*/
	private String message;
	
	/*Service Type*/
	private int type;
	
	/*server status*/
	private int serStatus;
	
	/*server action*/
	private int action;
	
	/*monit id*/
	private String monitId;
	
	public MonitEvent(){
		
	}

	public MonitEvent(int event_id, MonitHost monithost, String collected_sec,
			String collected_usec, String service, String message, int type,
			int serStatus, int action, String monitId) {
		super();
		this.event_id = event_id;
		this.monithost = monithost;
		this.collected_sec = collected_sec;
		this.collected_usec = collected_usec;
		this.service = service;
		this.message = message;
		this.type = type;
		this.serStatus = serStatus;
		this.action = action;
		this.monitId = monitId;
	}

	public int getEvent_id() {
		return event_id;
	}

	public void setEvent_id(int event_id) {
		this.event_id = event_id;
	}

	public MonitHost getMonithost() {
		return monithost;
	}

	public void setMonithost(MonitHost monithost) {
		this.monithost = monithost;
	}

	public String getCollected_sec() {
		return collected_sec;
	}

	public void setCollected_sec(String collected_sec) {
		this.collected_sec = collected_sec;
	}

	public String getCollected_usec() {
		return collected_usec;
	}

	public void setCollected_usec(String collected_usec) {
		this.collected_usec = collected_usec;
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getSerStatus() {
		return serStatus;
	}

	public void setSerStatus(int serStatus) {
		this.serStatus = serStatus;
	}

	public int getAction() {
		return action;
	}

	public void setAction(int action) {
		this.action = action;
	}

	public String getMonitId() {
		return monitId;
	}

	public void setMonitId(String monitId) {
		this.monitId = monitId;
	}
}
