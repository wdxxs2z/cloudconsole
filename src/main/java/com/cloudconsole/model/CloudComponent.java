package com.cloudconsole.model;

import java.util.List;

public class CloudComponent {
	
	private String component;
	private int index;
	private String uuid;
	private String host;
	private List<String> credentials;
		
	public CloudComponent() {
	}
	
	public CloudComponent(String component, int index, String uuid,
			String host, List<String> credentials) {
		this.component = component;
		this.index = index;
		this.uuid = uuid;
		this.host = host;
		this.credentials = credentials;
	}

	public String getComponent() {
		return component;
	}
	public void setComponent(String component) {
		this.component = component;
	}
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getHost() {
		return host;
	}
	public void setHost(String host) {
		this.host = host;
	}
	public List<String> getCredentials() {
		return credentials;
	}
	public void setCredentials(List<String> credentials) {
		this.credentials = credentials;
	}
}
