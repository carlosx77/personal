package com.carlosx.bootMVC.controller;

import java.net.URI;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
//import org.springframework.dao.DataAccessException;

import com.carlosx.bootMVC.domain.ToDo;
import com.carlosx.bootMVC.domain.ToDoBuilder;
import com.carlosx.bootMVC.repository.CommonRepository;
import com.carlosx.bootMVC.validation.ToDoValidationError;
import com.carlosx.bootMVC.validation.ToDoValidationErrorBuilder;

@RestController
@RequestMapping ("/api")
public class ToDoController {
	private CommonRepository<ToDo> repository;

	@Autowired
	public ToDoController(CommonRepository<ToDo> repository) {
		this.repository = repository;
	}
	
	@RequestMapping ("/")
	public String hello () {
		return "Hello!";
	}

	@GetMapping("/todo")
	public ResponseEntity<Iterable<ToDo>> getToDos() {
		return ResponseEntity.ok(repository.findAll());
	}

	@GetMapping("/todo/{id}")
	public ResponseEntity<ToDo> getToDoById(@PathVariable String id) {
		return ResponseEntity.ok(repository.findById(id));
	}

	@PatchMapping("/todo/{id}")
	public ResponseEntity<ToDo> setCompleted(@PathVariable String id) {
		ToDo result = repository.findById(id);
		result.setCompleted(true);
		repository.save(result);
		URI location = ServletUriComponentsBuilder.fromCurrentRequest().buildAndExpand(result.getId()).toUri();
		return ResponseEntity.ok().header("Location", location.toString()).build();
	}

	@RequestMapping(value = "/todo{id}", name = "/todo{id}", method= {RequestMethod.POST, RequestMethod.PUT})
	//@PostMapping(value = "/todo{id}", name = "/todo{id}")
	//@PutMapping ("/todo/{id}")
	public ResponseEntity<?> createToDo(@Valid @RequestBody (required = false) ToDo toDo, Errors errors) {
		if (errors.hasErrors()) {
			return ResponseEntity.badRequest().body(ToDoValidationErrorBuilder.fromBindingErrors(errors));
		}
		ToDo result = repository.save(toDo);
		URI location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(result.getId())
				.toUri();
		return ResponseEntity.created(location).build();
	}
	
	//@PutMapping(value = "/todo/{id}")
	//@PutMapping ("/todo/{id}")
	public ResponseEntity<?> createToDo2(@Valid @RequestBody (required = false) ToDo toDo, Errors errors) {
		if (errors.hasErrors()) {
			return ResponseEntity.badRequest().body(ToDoValidationErrorBuilder.fromBindingErrors(errors));
		}
		ToDo result = repository.save(toDo);
		URI location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(result.getId())
				.toUri();
		return ResponseEntity.created(location).build();
	}

	@DeleteMapping("/todo/{id}")
	public ResponseEntity<ToDo> deleteToDo(@PathVariable String id) {
		repository.delete(ToDoBuilder.create().withId(id).build());
		return ResponseEntity.noContent().build();
	}

	@DeleteMapping("/todo")
	public ResponseEntity<ToDo> deleteToDo(@RequestBody ToDo toDo) {
		repository.delete(toDo);
		return ResponseEntity.noContent().build();
	}

	@ExceptionHandler
	@ResponseStatus(value = HttpStatus.BAD_REQUEST)
	public ToDoValidationError handleException(Exception exception) {
		return new ToDoValidationError(exception.getMessage());
	}

	/*
	 // If I want to have a handler for DataExceptions we can use a method like this
	@ExceptionHandler
	@ResponseStatus(value = HttpStatus.BAD_REQUEST)
	public ToDoValidationError handleException(DataAccessException exception) {
		return new ToDoValidationError(exception.getMessage());
	}*/
}
