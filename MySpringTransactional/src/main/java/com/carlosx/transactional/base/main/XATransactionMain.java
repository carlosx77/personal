package com.carlosx.transactional.base.main;

import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.GenericApplicationContext;

import com.carlosx.transactional.base.config.ServicesConfig;
import com.carlosx.transactional.base.config.XAJpaConfig;
import com.carlosx.transactional.base.entities.Singer;
import com.carlosx.transactional.base.services.SingerService;

public class XATransactionMain {

	private static Logger logger = LoggerFactory.getLogger(XATransactionMain.class);
	
	public static void main(String[] args) {
		GenericApplicationContext ctx = new AnnotationConfigApplicationContext(ServicesConfig.class, XAJpaConfig.class);
		SingerService service = (SingerService) ctx.getBean("singerService");
		Singer singer = new Singer();
		singer.setFirstName("John");
		singer.setLastName("Mayer");
		singer.setBirthDate(new Date((new GregorianCalendar(1977,9,16)).getTime().getTime()));
		try {
			
			service.save(singer);
			if ( singer.getId() != null) {
				logger.info("Singer saved successfully");
			} else {
				logger.info("Singer was not saved");
			}

		} catch (Exception e) {
			logger.error("---------------------------------------Exception catched");
		}
		
		List<Singer> singers = service.findAll();
		logger.error("--> Singers size: " + singers.size());
		if (singers.size()!= 0 /*2*/) {
			logger.error("--> Something went wrong. " + singers);
		} else {
			logger.info("--> Singers form both DBs: " + singers);
		}
		
		ctx.close();
	}
}
