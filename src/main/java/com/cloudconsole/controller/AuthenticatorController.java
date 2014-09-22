package com.cloudconsole.controller;

import java.net.URI;
import java.net.URL;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudCredentials;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.domain.CloudQuota;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

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
				System.out.println(cloudUrl.getHost().toString());
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
			return new ModelAndView("home");
		}
	}

}
