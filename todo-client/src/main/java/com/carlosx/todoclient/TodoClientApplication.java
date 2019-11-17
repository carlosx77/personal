package com.carlosx.todoclient;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.WebApplicationType;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import com.carlosx.todoclient.client.ToDoRestClient;
import com.carlosx.todoclient.domain.ToDo;

@SpringBootApplication
public class TodoClientApplication {
	
	private Logger log = LoggerFactory.getLogger(TodoClientApplication.class);

	public static void main(String[] args) {
		//SpringApplication.run(TodoClientApplication.class, args);
		SpringApplication app = new SpringApplication(TodoClientApplication.class);
		app.setWebApplicationType(WebApplicationType.NONE);
		app.run(args);
	}
	
	@Bean
	public CommandLineRunner process (ToDoRestClient client) {
		return args -> {
			Iterable<ToDo> toDos = client.findAll();
			assert toDos != null;
			toDos.forEach( toDo -> log.info(toDo.toString()));
			ToDo newToDo = client.upsert(new ToDo ("Drink plenty of water!!!"));
			assert newToDo != null;
            log.info(newToDo.toString());
            ToDo toDo = client.findById(newToDo.getId());
            assert toDos != null;
            log.info(toDo.toString());
            ToDo completed = client.setCompleted(newToDo.getId());
            assert completed.isCompleted();
            log.info(completed.toString());
            client.delete(newToDo.getId());
            assert client.findById(newToDo.getId()) == null;
		};
	}

}
