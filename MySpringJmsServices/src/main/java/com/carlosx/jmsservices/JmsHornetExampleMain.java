package com.carlosx.jmsservices;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.GenericApplicationContext;

import com.carlosx.jmsservices.config.JmsAppConfig;

public class JmsHornetExampleMain {
	public static void main(String... args) throws Exception {
		GenericApplicationContext ctx = new AnnotationConfigApplicationContext(JmsAppConfig.class);
		MessageSender messageSender = ctx.getBean("messageSender", MessageSender.class);
		for (int i = 0; i < 10; ++i) {
			messageSender.sendMessage("Test message: " + i);
		}
		System.in.read();
		ctx.close();
	}
}
