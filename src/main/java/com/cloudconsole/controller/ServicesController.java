package com.cloudconsole.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ServicesController {
private static final Logger logger = LoggerFactory.getLogger(ServicesController.class);
	
	@RequestMapping(value = "/services", method = RequestMethod.GET)
	public String services(Locale locale, Model model){
		logger.info("CloudFoundry DOMAIN.", locale);
		
		return "services";
	}	
	

}
