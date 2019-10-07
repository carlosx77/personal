package com.carlosx.remoting.main;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.GenericApplicationContext;

import com.carlosx.remoting.entities.Singer;
import com.carlosx.remoting.services.SingerService;

public class SpringHttpClientMain {
	
	private static Logger logger = LoggerFactory.getLogger(SpringHttpClientMain.class);
	private static SingerService singerService;
	
	public static void main (String... args) {
		
		GenericApplicationContext ctx = new AnnotationConfigApplicationContext(RmiClientConfig.class);
		singerService = (SingerService) ctx.getBean("singerService");
		List<Singer> singers = singerService.findAll();
		listSingers(singers);
	}
	
	private static void listSingers(List<Singer> singers){
        singers.forEach(s -> logger.info(s.toString()));
    }
}
