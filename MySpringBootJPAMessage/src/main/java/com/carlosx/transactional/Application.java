package com.carlosx.transactional;

import java.io.IOException;
import java.util.Date;
import java.util.GregorianCalendar;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;

import com.carlosx.transactional.entities.Singer;
import com.carlosx.transactional.service.SingerService;

@SpringBootApplication (scanBasePackages="com.carlosx.transactional")
public class Application implements CommandLineRunner {
	
	private static Logger logger = LoggerFactory.getLogger(Application.class);
	@Autowired
	SingerService singerService;
	
	public static void main (String[] args) throws IOException {
		ConfigurableApplicationContext ctx = SpringApplication.run(Application.class, args);
		System.in.read();
		ctx.close();
	}

	@Override
	public void run(String... args) throws Exception {
		Singer singer = new Singer();
		singer.setFirstName("John");
		singer.setLastName("Mayer");
		singer.setBirthDate(new Date((new GregorianCalendar(1977,9,16)).getTime().getTime()));
		singerService.save(singer);
		
		long count = singerService.countAll();
		if ( count == 1) {
			logger.info("--> Singer saved succesfully!!!");
		} else {
			logger.error("--> Singer was not saved, check the config!!!");
		}
		
		try {
			singerService.save(null);
		} catch (Exception ex) {
			logger.error(ex.getMessage() + " Final count: " + singerService.countAll());
		}
	}
}
