package com.cloudconsole.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class DeaController {
private static final Logger logger = LoggerFactory.getLogger(DeaController.class);
	
	@RequestMapping(value = "/dea", method = RequestMethod.GET)
	public String dea(Locale locale, Model model){
		logger.info("CloudFoundry DEA Intance.", locale);
		
		return "dea";
	}

}
