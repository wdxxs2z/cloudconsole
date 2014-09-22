package com.cloudconsole.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class OrganizationController {
	private static final Logger logger = LoggerFactory.getLogger(OrganizationController.class);
	
	@RequestMapping(value = "/organization", method = RequestMethod.GET)
	public String organization(Locale locale, Model model){
		logger.info("CloudFoundry Organizations.", locale);
		
		return "organization";
	}

}
