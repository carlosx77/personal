package com.carlosx.simpleApp;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class SimpleGetProperties {
	
	private static Logger log = LoggerFactory.getLogger(SimpleGetProperties.class);

	@Value("${carlosx.ip}")
	String ip;
	@Value("${carlosx.database}")
	String database;
	@Autowired
	MyCarlosxProperties props;
	
	public static void main(String[] args) {
		
		//SpringApplication.run(SimpleAppApplication.class, args);
		SpringApplication app = new SpringApplication(SimpleGetProperties.class);
		// Spring looks for application.properties or Yaml file IN:
		/*
		 * 1.- /config subdir located in current dir
		 * 2.- current dir
		 * 3.- classpath/config package
		 * 4-- Classpath root
		 */
		app.run(args);
		/*
		 * In this example we have 2 properties, in this case the /config takes precedence BUT also reads the other
		 * properties that are in curren directory (database prop is not on porperties on /config.
		 * As mentioned Spring respects the order defined, in this case ip from /config takes precedence
		 */
		
		/** Also properties file name can be change by command line
		 * $ java -jar target/spring-boot-config-0.0.1-SNAPSHOT.jar --spring.config.name=mycfg
		 * in previous case .properties extension is assumed, no need to specify it
		 * Also location can be changed, lets assume .properties is on /app
		 * $ java -jar target/spring-boot-config-0.0.1-SNAPSHOT.jar --spring.config.location=file:app/ --spring.config.name=mycfg
		 */
		
		/**
		 * To test profiles uncomment property on application-prod.properties
		 * If you use profiles, then the profiled property takes precedence!! 
		 */
	}
	
	@Bean
	CommandLineRunner values() {
		return (args) -> {
			log.info (" Server IP: " + ip);
			log.info (" Server Database: " + database);
			log.info (" By Carlosx database: " + props.getIp() );
			log.info (" By Carlosx database: " + props.getDatabase() );
		};
	}

}
