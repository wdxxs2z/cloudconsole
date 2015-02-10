package com.cloudconsole.controller;

import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudCredentials;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cloudconsole.common.ConfigUtil;
import com.cloudconsole.common.Oauth2Util;

@Controller
public class RegisterPostController {
	
//	@Autowired
//	private RegisterUserService userService;

	@RequestMapping(value="register_post",method=RequestMethod.POST)
	public ModelAndView registerPost(
			@RequestParam(value="registername",required=true) String registername,
			@RequestParam(value="registeremail",required=true) String registeremail,
			@RequestParam(value="registerpasswd",required=true) String registerpasswd,
			@RequestParam(value="registerpasswd",required=false) String familyname,
			@RequestParam(value="registerpasswd",required=false) String givenname,
			@RequestParam(value="registerpasswd",required=true) String phonenumber,
			HttpServletRequest request,
			HttpServletResponse response){
		
		String errMessage = "";
				
		registername = request.getParameter("registername");
		registeremail = request.getParameter("registeremail");
		registerpasswd = request.getParameter("registerpasswd");
		familyname = request.getParameter("familyname");
		givenname = request.getParameter("givenname");
		registername = request.getParameter("registername");
		phonenumber = request.getParameter("phonenumber");
		
		if(StringUtils.isNotBlank(registername) && StringUtils.isNotBlank(registeremail)
				&& StringUtils.isNotBlank(registerpasswd) && StringUtils.isNotBlank(phonenumber)){
			
			String domain = ConfigUtil.getConfigInstance().getDomain();
			URL cloudUrl = null;
			try {
				cloudUrl = URI.create(domain).toURL();
			} catch (MalformedURLException e) {
				e.printStackTrace();
			}
			OAuth2AccessToken token = Oauth2Util.getToken();
			CloudCredentials registerCred = new CloudCredentials(token);
			CloudFoundryClient registerClient = new CloudFoundryClient(registerCred, cloudUrl, true);

			if(registerClient.findUserByUsername(registername) == null){
				registerClient.createUser(registername, registerpasswd, familyname, givenname, phonenumber);
				registerClient.logout();
			}else{
				errMessage = "用户已经存在，请重新注册!";
			}
						
		}else {
			errMessage = "请保证所有字段都以填写正确，或发现用户名已被注册";
		}
		
		if(StringUtils.isNotBlank(errMessage)){
			ModelAndView modelLogin =new ModelAndView("register");
			modelLogin.addObject("err", errMessage);
			return modelLogin;			
		}else{
			return new ModelAndView("login");
		}
	}
}
