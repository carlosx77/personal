package com.carlosx.hellorest;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

//@RestController
@SpringBootApplication
public class HelloWorldRestApplication {

	public static void main(String[] args) {
		SpringApplication.run(HelloWorldRestApplication.class, args);
	}
	
	/*@RequestMapping("/greet")
	public String helloGreeting() {
		return "Hello Rest";
	}*/
	
	//@Autowired ("")

}
