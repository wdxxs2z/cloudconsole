package com.cloudconsole.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CF_RegisterController {
	
	@RequestMapping(value="/register",method=RequestMethod.POST)
	public ModelAndView cf_Register(HttpServletRequest request,HttpServletResponse response){
		
		
		return new ModelAndView("login");
	}

}
