package com.carlosx.bootMVC;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ToDoInMemoryBootMvcApplication {

	public static void main(String[] args) {
		SpringApplication.run(ToDoInMemoryBootMvcApplication.class, args);
	}
	
	// Things you can change:
	/*
	 * IP Address: (if you want to use an specific ip address
	 * server.address=10.0.0.7
	 * 
	 * Server context:
	 * server.servlet.context-path:/myAppContext
	 * 
	 * Tomcat properties:
	 * server.port=8443
	 * server.ssl.key-store=classpath:keystore.jks
	 * server.ssl.key-store-password:secret
	 * server.ssl.key-password:secrete
	 * 
	 * server.servlet.session.store-dir=/tmp
	 * server.servlet.session.persistent=true
	 * server.servlet.session.timeout=15
	 * server.servlet.session.cookie.name=todo-cookie.dat
	 * server.servlet.session.cookie.path=/tmp/cookies
	 * 
	 * server.http2.enabled=true
	 * 
	 * 
	 * Jackson DATE FORMAT:
	 * spring.jackson.date-format=yyyy-MM-dd HH:mm:ss
	 * spring.jackson.time-zone=MST7MDT
	 * 
	 * 
	 * JSON is default but if we want both XML and JSON?
	 * To response in XML Format we need:
	 * Add XML jackson formatter to classpath or dependencies in build.gradle
	 * compile('com.fasterxml.jackson.dataformat:jackson-dataformat-xml')
	 * Add property:
	 * spring.mvc.contentnegotiation.favor-parameter=true
	 * If we consult the service we get:
	 * curl -s http://localhost:8080/api/todo?format=xml
	 * <ArrayList><item><id>b3281340-b1aa-4104-b3d2-77a96a0e41b8</id><description>Read the Pro Spring Boot 2nd Edition Book</description><created>2018-05-03T19:18:30.260+0000</created><modified>2018-05-03T19:18:30.260+0000</modified><completed>false</completed></item></ArrayList>
	 * Or if we change for JSON
	 * curl -s http://localhost:8080/api/todo?format=json | jq
		[
		  {
		    "id": "b3281340-b1aa-4104-b3d2-77a96a0e41b8",
		    "description": "Read the Pro Spring Boot 2nd Edition Book",
		    "created": "2018-05-03T19:18:30.260+0000",
		    "modified": "2018-05-03T19:18:30.260+0000",
		    "completed": false
		  }
		]
	 * 
	 * 
	 * You can Change other defaults;.
	 * spring.mvc.view.prefix=/WEB-INF/my-views/
	 * spring.mvc.view.suffix=.jsp
	 * 
	 * Use Jetty instead Tomcat: just add the dependency to classpath:
	 * dependencies {
	 * 		compile("org.springframework.boot:spring-boot-starter-web")
	 * 		compile("org.springframework.boot:spring-boot-starter-jetty")
	 * 		// ...
	 * }
	 * 
	 */

}
