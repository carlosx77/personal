package com.carlosx.simpleApp;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.core.annotation.Order;

@SpringBootApplication
public class SimpleApplicationWithMethodOrder {
	private static final Logger log = LoggerFactory.getLogger(SimpleApplicationWithMethodOrder.class);
	public static void main (String... args) {
		SpringApplication.run(SimpleApplicationWithMethodOrder.class, args);
	}
	
	// this is supposed to respect the calling order indicated but its not doing it 
	@Bean
	@Order (2)
	CommandLineRunner aMethod2 () {
		return args -> {
			log.info ("### Command line runner implementation 2");
			for(String arg:args) {
				log.info(arg);
			}
		};
	}
	
	@Bean
	@Order (1)
	CommandLineRunner aMethod1 () {
		return args -> {
			log.info ("### Command line runner implementation 1");
			for(String arg:args) {
				log.info(arg);
			}
		};
	}
	
	///////////////////////////// MORE ABOUT PROPERTIES  ////////////////////////////
	
	/* PROPERTIES ORDER:
		Command-line arguments
		SPRING_APPLICATION_JSON		
		JNDI (java:comp/env)
		System.getProperties()
		OS Environment variables
		RandomValuePropertySource (random.*)
		Profile-specific (application-{profile}.jar) outside of the package jar.		
		Profile-specific (application-{profile}.jar) inside of the package jar.		
		Application properties (application.properties) outside of the package jar.		
		Application properties (application.properties) inside of the package jar.		
		@PropertySource		
		SpringApplication.setDefaultProperties
		
		Example of command line properties:
		$ java -jar target/spring-boot-config-0.0.1-SNAPSHOT.jar --server.ip=192.168.12.1
		Or
		$ ./mvnw spring-boot:run -Dserver.ip=192.168.12.1
	 * 
	 */

}
