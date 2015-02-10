package com.cloudconsole.common;

import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.util.Map;

import org.cloudfoundry.client.lib.CloudCredentials;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.springframework.security.oauth2.common.OAuth2AccessToken;

public class Oauth2Util {
	
	public static OAuth2AccessToken getToken(){
		String domain = ConfigUtil.getConfigInstance().getDomain();
		Map<String, String> oAuthProxy = ConfigUtil.getConfigInstance().OAuthProxy();
		String proxyUsername = oAuthProxy.get("username");
		String proxyUserpass = oAuthProxy.get("password");
		URL cloudUrl = null;
		try {
			cloudUrl = URI.create(domain).toURL();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}		
		CloudCredentials credentials = new CloudCredentials(proxyUsername, proxyUserpass);
		CloudFoundryClient client = new CloudFoundryClient(credentials, cloudUrl, true);
		return client.login();
	}

}
