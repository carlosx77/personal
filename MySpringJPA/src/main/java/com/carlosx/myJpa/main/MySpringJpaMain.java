package com.carlosx.myJpa.main;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.carlosx.myJpa.config.JpaConfig;
import com.carlosx.myJpa.entities.Singer;
import com.carlosx.myJpa.service.SingerJpaService;
import com.carlosx.myJpa.service.SingerService;

public class MySpringJpaMain {
	private static Logger logger = LoggerFactory.getLogger(SingerJpaService.class);
	public static void main (String...args) {
		ConfigurableApplicationContext ctx = new AnnotationConfigApplicationContext(JpaConfig.class);
		SingerService service = (SingerService) ctx.getBean("singerJpaService");
		List<Singer> singers = service.findAll();
		for (Singer temp: singers) {
			logger.info("Singer: " + temp.toString());
		}
		ctx.close();
	}
}
