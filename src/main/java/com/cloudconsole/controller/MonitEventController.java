package com.cloudconsole.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MonitEventController {
private static final Logger logger = LoggerFactory.getLogger(MonitEventController.class);
	
	@RequestMapping(value = "/monitEvent", method = RequestMethod.GET)
	public String monitEvent(Locale locale, Model model){
		logger.info("CloudFoundry MonitEvent.", locale);
		
		return "monitEvent";
	}

}
