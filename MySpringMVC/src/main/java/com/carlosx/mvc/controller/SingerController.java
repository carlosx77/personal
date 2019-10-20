package com.carlosx.mvc.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.carlosx.mvc.entites.Singer;
import com.carlosx.mvc.services.SingerService;

@Controller
@RequestMapping("/singers")
public class SingerController {
	
	private final Logger logger = LoggerFactory.getLogger(SingerController.class);
	@Autowired
	private SingerService singerService;
	//private MessageSource messageSource;

	@RequestMapping(method = RequestMethod.GET)
	public String list(Model uiModel) {
		logger.info("Listing singers");
		List<Singer> singers = singerService.findAll();
		uiModel.addAttribute("singers", singers);
		logger.info("No. of singers: " + singers.size());
		return "singers/list";
	}
}
