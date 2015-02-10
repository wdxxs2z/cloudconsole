package com.cloudconsole.model;

import java.io.Serializable;

public class MonitHost implements Serializable{

	private static final long serialVersionUID = -6158482535023558264L;
	
	/*monit id only one can read it*/
	private String monitId;
	
	/*remote host name*/
	private String monitHostName;
	
	/*remote host IP*/
	private String monitHostIp;
	
	/*remote host status*/
	private int monitHostStatus;
	
	/*User name*/
	private String username;
	
	/*User password*/
	private String password;
	
	/*system update time*/
	private String updateTime;
	
	/*platformCpu*/
	private int platformCpu;
	
	/*platformMem*/
	private int platformMem;
	
	/*platformSwap*/
	private int platformSwap;
	
	public MonitHost(){
		
	}

	public MonitHost(String monitId, String monitHostName, String monitHostIp,
			int monitHostStatus, String username, String password,
			String updateTime, int platformCpu, int platformMem,
			int platformSwap) {
		super();
		this.monitId = monitId;
		this.monitHostName = monitHostName;
		this.monitHostIp = monitHostIp;
		this.monitHostStatus = monitHostStatus;
		this.username = username;
		this.password = password;
		this.updateTime = updateTime;
		this.platformCpu = platformCpu;
		this.platformMem = platformMem;
		this.platformSwap = platformSwap;
	}

	public String getMonitId() {
		return monitId;
	}

	public void setMonitId(String monitId) {
		this.monitId = monitId;
	}

	public String getMonitHostName() {
		return monitHostName;
	}

	public void setMonitHostName(String monitHostName) {
		this.monitHostName = monitHostName;
	}

	public String getMonitHostIp() {
		return monitHostIp;
	}

	public void setMonitHostIp(String monitHostIp) {
		this.monitHostIp = monitHostIp;
	}

	public int getMonitHostStatus() {
		return monitHostStatus;
	}

	public void setMonitHostStatus(int monitHostStatus) {
		this.monitHostStatus = monitHostStatus;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public int getPlatformCpu() {
		return platformCpu;
	}

	public void setPlatformCpu(int platformCpu) {
		this.platformCpu = platformCpu;
	}

	public int getPlatformMem() {
		return platformMem;
	}

	public void setPlatformMem(int platformMem) {
		this.platformMem = platformMem;
	}

	public int getPlatformSwap() {
		return platformSwap;
	}

	public void setPlatformSwap(int platformSwap) {
		this.platformSwap = platformSwap;
	}
}
