package com.carlosx.remoting.main;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.remoting.httpinvoker.HttpInvokerProxyFactoryBean;

import com.carlosx.remoting.services.SingerService;

@Configuration
public class RmiClientConfig {
	
	private static Logger logger = LoggerFactory.getLogger(SpringHttpClientMain.class);
	@Bean
	public SingerService singerService () {
		HttpInvokerProxyFactoryBean factoryBean = new HttpInvokerProxyFactoryBean();
		factoryBean.setServiceInterface(SingerService.class);
		logger.info("http://localhost:8080/invoker/httpInvoker/singerService");
		factoryBean.setServiceUrl("http://localhost:8080/invoker/httpInvoker/singerService");
		
		factoryBean.afterPropertiesSet();
		return (SingerService) factoryBean.getObject();
	}
}
