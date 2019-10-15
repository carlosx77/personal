package com.carlosx.rest.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.carlosx.rest.entities.Singer;
import com.carlosx.rest.entities.Singers;
import com.carlosx.rest.services.SingerService;

@Controller
@RequestMapping(value = "/rest/singer")
public class SingerController {
	final Logger logger = LoggerFactory.getLogger(SingerController.class);

	@Autowired
	private SingerService singerService;

	@ResponseStatus(HttpStatus.OK)
	//@RequestMapping(value = "/listdata", method = RequestMethod.GET)
	@GetMapping(value = "/listdata")
	@ResponseBody
	public Singers listData() {
		logger.info("Service invoked");
		return new Singers(singerService.findAll());
	}

	//@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseBody
	@GetMapping(value = "/{id}")
	public Singer findSingerById(@PathVariable Long id) {
		return singerService.findById(id);
	}

	//@RequestMapping(value = "/", method = RequestMethod.POST)
	@ResponseBody
	@PostMapping(value="/")
	public Singer create(@RequestBody Singer singer) {
		logger.info("Creating singer: " + singer);
		singerService.save(singer);
		logger.info("Singer created successfully with info: " + singer);
		return singer;
	}

	//@RequestMapping(value="/{id}", method=RequestMethod.PUT)
	@ResponseBody
	@PutMapping(value="/{id}")
	public void update(@RequestBody Singer singer, @PathVariable Long id) {
		logger.info("Updating singer: " + singer);
		singerService.save(singer);
		logger.info("Singer updated successfully with info: " + singer);
	}

	//@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	@ResponseBody
	@DeleteMapping(value="/{id}")
	public void delete(@PathVariable Long id) {
		logger.info("Deleting singer with id: " + id);
		Singer singer = singerService.findById(id);
		singerService.delete(singer);
		logger.info("Singer delted successfully");
	}
}
