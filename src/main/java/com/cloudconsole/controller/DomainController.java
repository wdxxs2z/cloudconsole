package com.cloudconsole.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class DomainController {
private static final Logger logger = LoggerFactory.getLogger(DomainController.class);
	
	@RequestMapping(value = "/domain", method = RequestMethod.GET)
	public String domain(Locale locale, Model model){
		logger.info("CloudFoundry DOMAIN.", locale);
		
		return "domain";
	}	
	

}
