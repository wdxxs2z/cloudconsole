package com.cloudconsole.controller;

import java.io.IOException;
import java.net.URI;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudCredentials;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cloudconsole.common.ConfigUtil;

@Controller
public class AuthenticatorController {
	
	@RequestMapping(value="/authenticator",method=RequestMethod.POST)
	public ModelAndView authenticator(@RequestParam(value="userName",required=false) String userName,
			@RequestParam(value="passWord",required=false) String passWord, HttpServletRequest request,
			HttpServletResponse response)throws Exception{
		
		userName = request.getParameter("login_username");
		passWord = request.getParameter("login_password");
	
		String errMessage = "";
		
		if(StringUtils.isNotBlank(userName) && StringUtils.isNotBlank(passWord)){
			try {
				CloudCredentials credentials = new CloudCredentials(userName, passWord);
				//必须是HTTPS
				String domain = ConfigUtil.getConfigInstance().getDomain();
				URL cloudUrl = URI.create(domain).toURL();				
//				CloudFoundryClient client = new CloudFoundryClient(credentials, cloudUrl, "DevBox", "mycloud", null, true);
				CloudFoundryClient client = new CloudFoundryClient(credentials, cloudUrl, true);
				client.login();
				/**
				 * 这地方需要增加一个功能点就是我们的监控机器的健康程度，比如罗列warden节点和其它组件的健康状况
				 * 还有用户数量
				 * */				
				request.getSession().setAttribute("cloudCredentialsUse", credentials);
				request.getSession().setAttribute("client", client);
			} catch (Exception e) {
				errMessage = e.getMessage();
			}
		}else {
			errMessage = "用户名密码不能为空";
		}
		
		if(StringUtils.isNotBlank(errMessage)){
			ModelAndView modelLogin =new ModelAndView("login");
			modelLogin.addObject("err", errMessage);
			return modelLogin;			
		}else{
			return new ModelAndView("loginorg");
		}
	}
	
	@RequestMapping(value="loginSwitchSpace")
	public ModelAndView loginSwitchSpace (HttpServletRequest request,HttpServletResponse response) throws IOException {
		String errMessage = "";
		String orgName = request.getParameter("orgName");
		String spaceName = request.getParameter("spaceName");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		CloudCredentials credentials = (CloudCredentials) request.getSession().getAttribute("cloudCredentialsUse");
		String domain = ConfigUtil.getConfigInstance().getDomain();
		URL cloudUrl = URI.create(domain).toURL();
		if (client != null && StringUtils.isNotBlank(spaceName) && StringUtils.isNotBlank(orgName)) {			
			try {
				client = new CloudFoundryClient(credentials, cloudUrl, orgName, spaceName, null, true);
				client.login();
				request.getSession().setAttribute("cloudCredentialsUse", credentials);
				request.getSession().setAttribute("client", client);
			} catch (Exception e) {
				errMessage = e.getMessage();
			}			
		}
		if(StringUtils.isNotBlank(errMessage)){
			ModelAndView original =new ModelAndView("login");
			original.addObject("err", errMessage);
			return original;			
		}else{
			return new ModelAndView(new RedirectView("home"));
		}
	}

}
