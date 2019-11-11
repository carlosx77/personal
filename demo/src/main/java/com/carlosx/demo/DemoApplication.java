package com.carlosx.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.jms.activemq.ActiveMQAutoConfiguration;

@SpringBootApplication (exclude={ActiveMQAutoConfiguration.class,DataSourceAutoConfiguration.class})
public class DemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

}
