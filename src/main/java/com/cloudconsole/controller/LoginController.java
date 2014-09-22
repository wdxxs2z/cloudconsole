package com.cloudconsole.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * CloudFoundry Console 登陆页面
 * yuanyuan
 * 2014.09.09
 * */

@Controller
public class LoginController {
	
	@RequestMapping(value = "/login")
	public ModelAndView login(HttpServletRequest request,
			HttpServletResponse response)throws Exception{
		
		request.getSession().removeAttribute("client");
		return new ModelAndView("login");		
	}
}
