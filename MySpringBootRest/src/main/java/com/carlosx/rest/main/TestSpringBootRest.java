package com.carlosx.rest.main;

import java.util.Arrays;
import java.util.Date;
import java.util.GregorianCalendar;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.client.RestTemplate;

import com.carlosx.rest.entities.Singer;

public class TestSpringBootRest {
	final Logger logger = LoggerFactory.getLogger(TestSpringBootRest.class);
	RestTemplate restTemplate;
	private static final String URL_GET_ALL_SINGERS = "http://localhost:8080/singer/listdata";
	private static final String URL_GET_SINGER_BY_ID = "http://localhost:8080/singer/{id}";
	private static final String URL_CREATE_SINGER = "http://localhost:8080/singer/";
	private static final String URL_UPDATE_SINGER = "http://localhost:8080/singer/{id}";
	private static final String URL_DELETE_SINGER = "http://localhost:8080/singer/{id}";

	public void setUp() {
		restTemplate = new RestTemplate();
	}

	public void testFindAll() {
		logger.info("--> Testing retrieve all singers");
		Singer[] singers = restTemplate.getForObject(URL_GET_ALL_SINGERS, Singer[].class);
		logger.info("Debe ser true: " + (singers.length == 3));
		listSingers(singers);
	}

	public void testFindById() {
		logger.info("--> Testing retrieve a singer by id : 1");
		Singer singer = restTemplate.getForObject(URL_GET_SINGER_BY_ID, Singer.class, 1);
		logger.info("No debe ser nulo: " + singer);
		logger.info(singer.toString());
	}

	public void testUpdate() {
		logger.info("--> Testing update singer by id : 1");
		Singer singer = restTemplate.getForObject(URL_UPDATE_SINGER, Singer.class, 1);
		singer.setFirstName("John Clayton");
		restTemplate.put(URL_UPDATE_SINGER, singer, 1);
		logger.info("Singer update successfully: " + singer);
	}

	public void testDelete() {
		logger.info("--> Testing delete singer by id : 3");
		restTemplate.delete(URL_DELETE_SINGER, 3);
		Singer[] singers = restTemplate.getForObject(URL_GET_ALL_SINGERS, Singer[].class);
		Boolean found = false;
		for (Singer s : singers) {
			if (s.getId() == 3) {
				found = true;
			}
		}
		logger.info("Defe ser falso: " + found);
		listSingers(singers);
	}

	public void testCreate() {
		logger.info("--> Testing create singer");
		Singer singerNew = new Singer();
		singerNew.setFirstName("BB");
		singerNew.setLastName("King");
		singerNew.setBirthDate(new Date(
				(new GregorianCalendar(1940, 8, 16)).getTime().getTime()));
		singerNew = restTemplate.postForObject(URL_CREATE_SINGER, singerNew, Singer.class);
		logger.info("Singer created successfully: " + singerNew);
	}

	private void listSingers(Singer[] singers) {
		Arrays.stream(singers).forEach(s -> logger.info(s.toString()));
	}
	
	public static void main(String... strings) {
		TestSpringBootRest test = new TestSpringBootRest();
		test.setUp();
		test.testFindAll();
		test.testFindById();
		test.testUpdate();
		test.testCreate();
		test.testDelete();
	}
}
