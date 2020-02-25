package com.carlosx.hellorest.controller;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.resource.HttpResource;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.carlosx.hellorest.domain.Poll;
import com.carlosx.hellorest.repository.PollRepository;

@RestController
public class PollController {
	@Autowired
	@Qualifier("pollRepository")
	private PollRepository pollRepository;
	
	//@RequestMapping(value = "/polls", method = RequestMethod.GET)
	@GetMapping (value = "/polls")
	public /*ResponseEntity<Iterable<Poll>>*/ ResponseEntity<Iterable<Poll>> getAllPolls (HttpSession session) {
		/*System.out.println("Seesion; " + session.isNew());
		Poll poll = new Poll();
		poll.setId(1l);
		poll.setOptions(null);
		poll.setQuestion("Question!");
		List<Poll> result = new ArrayList<Poll>();
		result.add(poll);
		return result;*/
		return new ResponseEntity<Iterable<Poll>>(pollRepository.findAll(), HttpStatus.OK);
	}
	
	/*
	@PostMapping (value = "/polls")
	public void addNewPoll (Poll poll) {
		this.pollRepository.save(poll);
	}*/ // if we implement this way we only get a 200, the correct response should be 201 (CREATED)
	// And also we don't know the URI of the new resource created, we should add
	// the URL in the response body
	@PostMapping ( value = "/polls" ) 
	public ResponseEntity<?> createPoll (@RequestBody Poll poll) {
		/* If on body the client sends a poll and I dont use RequestBody, Spring will never map
		 * the poll on request body to the poll pojo parameter
		 */
		poll = pollRepository.save(poll);
		URI newPollUri = ServletUriComponentsBuilder
				.fromCurrentRequest()
				.path("/{id}")
				.buildAndExpand(poll.getId())
				.toUri();
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setLocation(newPollUri);
		return new ResponseEntity<> (null, httpHeaders, HttpStatus.CREATED);
	}
	
	@GetMapping (value="/polls/{id}")
	public ResponseEntity<Poll> getPoll (@PathVariable Long id) {
		Optional<Poll> poll = pollRepository.findById(id);
		if ( poll.isPresent() )
			return new ResponseEntity<Poll> (poll.get(), HttpStatus.OK);
		else
			return new ResponseEntity<Poll> (null, null, HttpStatus.OK);
	}
	
	@DeleteMapping (value="/polls/{id}")
	public ResponseEntity<?> deletePoll (@PathVariable Long id) {
		pollRepository.deleteById(id);
		return new ResponseEntity<> (HttpStatus.OK);
	}
	
}
