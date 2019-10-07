package com.carlosx.remoting.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.remoting.httpinvoker.HttpInvokerServiceExporter;

import com.carlosx.remoting.services.SingerService;

@Configuration
public class HttpInvokerConfig {
	@Autowired
	SingerService singerService;
	
	@Bean (name="/httpInvoker/singerService")
	public HttpInvokerServiceExporter httpInvokerServiceExporter () {
		HttpInvokerServiceExporter invokerSerice = new HttpInvokerServiceExporter();
		invokerSerice.setService(singerService);
		invokerSerice.setServiceInterface(SingerService.class);
		return invokerSerice;
	}
}
