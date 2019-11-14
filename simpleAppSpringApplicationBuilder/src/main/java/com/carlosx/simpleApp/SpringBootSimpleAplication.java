package com.carlosx.simpleApp;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.Banner;
import org.springframework.boot.WebApplicationType;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

@SpringBootApplication
public class SpringBootSimpleAplication {
	
	private static Logger log = LoggerFactory.getLogger(SpringBootSimpleAplication.class);

	public static void main(String[] args) {
		//SpringApplication.run(SimpleAppApplication.class, args);
		//SpringApplication app = new SpringApplication(SimpleAppApplication.class); 
		// Omitting SpringApplication as we are going to use SpringApplicationBuilder!!!!
		new SpringApplicationBuilder(SpringBootSimpleAplication.class)
		// you can disable the banner
		// .bannerMode (Banner.Mode.OFF)
		// .logStartupInfo(false) prevents startup logging messages
		// you can have a hierarchy 
		// .child(OtherConfig.class)
		// you can activate profiles
		// .profiles("prod", "cloud")
		// you can attach event listeners
		.listeners(new ApplicationListener<ApplicationEvent>() {

			@Override
			public void onApplicationEvent(ApplicationEvent event) {
				log.info("##### " + event.getClass().getName() + " ####");
				//EVENTS!!!!!!!
				/*
				 ApplicationStartedEvent (this is sent at the start)
				 ApplicationEnvironmentPreparedEvent (this is sent when the environment is known)
				 ApplicationPreparedEvent (this is sent after the bean definitions)
				 ApplicationReadyEvent (this is sent when the application is ready)
				 and ApplicationFailedEvent (this is sent in case of exception during the startup)
				 */
				
			}
		})
		// you can avoid loading an specific configuration, lets say that you neew a web lib but dont want to Spring
		// to think that you need a boot web auto config
		.web(WebApplicationType.NONE)
		.run(args);
		
		// we can also have a hierarchy
		/*
 		new SpringApplicationBuilder(SpringBootSimpleApplication.class)
            .child(OtherConfig.class)
            .run(args);
		 */
		// parent and child must SHARE the Environment Interface
		// if you have a web config set it as a child
		
		
	}
}


@Component
class MyComponent {
	private static final Logger log = LoggerFactory.getLogger(MyComponent.class);
	
	
	@Autowired
	private MyComponent (ApplicationArguments args) {
		log.info( "Argument: " + args.containsOption("enable"));
		// Program Arguments: --enable
		// when containsOption expects the argument to be --<arg>
		// to run this example with mvn the comand is: 
		//	$ ./mvnw spring-boot:run -Dspring-boot.run.arguments="--enable"
		// Or in eclipse: Open config/arguments and in Program Arguments set --enable 
		// other Arguments (not options can be retrieved using:
		// 	$ ./mvnw spring-boot:run -Dspring-boot.run.arguments="arg1,arg2"
		// to test other arguments: 
		for (String arg: args.getNonOptionArgs() ) {
			log.info("Arguments: " + arg);
		}
		
		// also using a jar:
		// 	$ java -jar spring-boot-simple-0.0.1-SNAPSHOT.jar --enable arg1 arg2
	}
}
