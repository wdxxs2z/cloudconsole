package com.cloudconsole.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MonitController {
private static final Logger logger = LoggerFactory.getLogger(MonitController.class);
	
	@RequestMapping(value = "/monit", method = RequestMethod.GET)
	public String monit(Locale locale, Model model){
		logger.info("CloudFoundry Com Monit.", locale);
		
		return "monit";
	}

}
