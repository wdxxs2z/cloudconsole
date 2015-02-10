package com.cloudconsole.model;

import java.io.Serializable;

public class SystemBean implements Serializable {

	/**
	 * monit system info , monit type:5
	 */
	private static final long serialVersionUID = 1L;
	
	/*systemid */
	private int system_id;

	/*system Name*/
	private String systemName;
	
	/*system collected_sec*/
	private String collected_sec;
	
	/*collected_usec*/
	private String collected_usec;
	
	/*system loadAvg01*/
	private float loadAvg01;
	
	/*system loadAvg05*/
	private float loadAvg05;
	
	/*system loadAvg15*/
	private float loadAvg15;
	
	/*system UserCpu*/
	private float systemUserCpu;
	
	/*system SysCpu*/
	private float systemSysCpu;
	
	/*system WaitCpu*/
	private float systemWaitCpu;
	
	/*system Memperc*/
	private float systemMemperc;
	
	/*system MemTot*/
	private int systemMemTot;
	
	/*system Swapperc*/
	private float systemSwapperc;
	
	/*system SwapTot*/
	private int systemSwapTot;
	
	/*system monitId*/
	private String monitId;

	public int getSystem_id() {
		return system_id;
	}

	public void setSystem_id(int system_id) {
		this.system_id = system_id;
	}

	public SystemBean() {
		super();
	}

	public String getSystemName() {
		return systemName;
	}

	public void setSystemName(String systemName) {
		this.systemName = systemName;
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

	public float getLoadAvg01() {
		return loadAvg01;
	}

	public void setLoadAvg01(float loadAvg01) {
		this.loadAvg01 = loadAvg01;
	}

	public float getLoadAvg05() {
		return loadAvg05;
	}

	public void setLoadAvg05(float loadAvg05) {
		this.loadAvg05 = loadAvg05;
	}

	public float getLoadAvg15() {
		return loadAvg15;
	}

	public void setLoadAvg15(float loadAvg15) {
		this.loadAvg15 = loadAvg15;
	}

	public float getSystemUserCpu() {
		return systemUserCpu;
	}

	public void setSystemUserCpu(float systemUserCpu) {
		this.systemUserCpu = systemUserCpu;
	}

	public float getSystemSysCpu() {
		return systemSysCpu;
	}

	public void setSystemSysCpu(float systemSysCpu) {
		this.systemSysCpu = systemSysCpu;
	}

	public float getSystemWaitCpu() {
		return systemWaitCpu;
	}

	public void setSystemWaitCpu(float systemWaitCpu) {
		this.systemWaitCpu = systemWaitCpu;
	}

	public float getSystemMemperc() {
		return systemMemperc;
	}

	public void setSystemMemperc(float systemMemperc) {
		this.systemMemperc = systemMemperc;
	}

	public int getSystemMemTot() {
		return systemMemTot;
	}

	public void setSystemMemTot(int systemMemTot) {
		this.systemMemTot = systemMemTot;
	}

	public float getSystemSwapperc() {
		return systemSwapperc;
	}

	public void setSystemSwapperc(float systemSwapperc) {
		this.systemSwapperc = systemSwapperc;
	}

	public int getSystemSwapTot() {
		return systemSwapTot;
	}

	public void setSystemSwapTot(int systemSwapTot) {
		this.systemSwapTot = systemSwapTot;
	}

	public String getMonitId() {
		return monitId;
	}

	public void setMonitId(String monitId) {
		this.monitId = monitId;
	}
}
