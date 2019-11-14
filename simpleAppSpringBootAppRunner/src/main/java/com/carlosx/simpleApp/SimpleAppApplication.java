package com.carlosx.simpleApp;

import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

//@SpringBootApplication

// #################THERE IS NO NEED TO IMPLEMENT BOTH INTERFACES!!!!!!!!!!!!!!!!!!!
public class SimpleAppApplication /*implements CommandLineRunner, ApplicationRunner*/{
	
	private static final Logger log = LoggerFactory.getLogger(SimpleAppApplication.class);
	@Bean
	String info () {
		return "Just a simple String bean";
	}
	
	@Autowired
	String info;

	public static void main (String[] args) throws IOException {
		SpringApplication.run(SimpleAppApplication.class, args);
	}
	
	//@Override
	public void run(ApplicationArguments args) throws Exception {
		log.info("#### ApplicationRunner Implementation.... ####");
		log.info("Accesssing the Info bean " + info);
		args.getNonOptionArgs().forEach(file -> log.info(file));
	}

	//@Override
	
	public void run(String... args) throws Exception {
		log.info("### CommandLineRunner implmementation....####");
		log.info("Accesing the Info bean: " + info);
		for(String arg:args) {
			log.info(arg);
		}
	}
	
}
