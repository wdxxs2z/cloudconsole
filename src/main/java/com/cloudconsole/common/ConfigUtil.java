package com.cloudconsole.common;

import java.io.InputStream;
import java.util.Properties;

public class ConfigUtil {
	
	private static Properties properties = new Properties();
	private static ConfigUtil instance = new ConfigUtil();
	
	private ConfigUtil(){	
		loadProperties(); 
	}
	
	public static ConfigUtil getConfigInstance(){
		return instance;
	}

	private void loadProperties() {
		try {
			ClassLoader loader = Thread.currentThread().getContextClassLoader();
			InputStream resourceAsStream = loader.getResourceAsStream("cloudconfig.properties");
			properties.load(resourceAsStream);
		} catch (Exception e) {
			
		}
		
	}
	
	public String getDomain(){
		String DOMAIN = properties.getProperty("domain");
		return DOMAIN;
	}
	
	public static void main(String[] args) {
		
		System.out.println(System.currentTimeMillis());
	}

}
