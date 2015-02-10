package com.cloudconsole.common;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
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
	
	public String getNats_Servers(){
		String NATS_SERVERS = properties.getProperty("nats_servers");
		return NATS_SERVERS;
	}
	
	public Map<String,String> OAuthProxy(){
		Map<String,String> oauthMap = new HashMap<String, String>();
		String oauth_proxy = properties.getProperty("OAuth_proxy");
		String[] split = oauth_proxy.split(":");
		oauthMap.put("username", split[0]);
		oauthMap.put("password", split[1]);
		return oauthMap;
	}
	
	public static void main(String[] args) {
		
		System.out.println(System.currentTimeMillis());
	}

}
