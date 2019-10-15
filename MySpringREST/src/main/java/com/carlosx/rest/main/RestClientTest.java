package com.carlosx.rest.main;

import java.util.Date;
import java.util.GregorianCalendar;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.GenericApplicationContext;
import org.springframework.web.client.RestTemplate;

import com.carlosx.rest.client.RestClientConfig;
import com.carlosx.rest.entities.Singer;
import com.carlosx.rest.entities.Singers;

public class RestClientTest {

	public static final Logger logger = LoggerFactory.getLogger(RestClientTest.class);
	private static final String URL_GET_ALL_SINGERS = "http://localhost:8080/MySpringREST/rest/singer/listdata";
	private static final String URL_GET_SINGER_BY_ID = "http://localhost:8080/MySpringREST/rest/singer/{id}";
	private static final String URL_CREATE_SINGER = "http://localhost:8080/MySpringREST/rest/singer/";
	private static final String URL_UPDATE_SINGER = "http://localhost:8080/MySpringREST/rest/singer/{id}";
	private static final String URL_DELETE_SINGER = "http://localhost:8080/MySpringREST/rest/singer/{id}";

	@Autowired
	RestTemplate restTemplate;

	public static void main(String... args) {
		try {
		GenericApplicationContext ctx = new AnnotationConfigApplicationContext (RestClientConfig.class);
		RestClientTest test = (RestClientTest)ctx.getBean("restClientTest");
		test.testFindAll();
		test.testFindbyId();
		test.testUpdate();
		test.testDelete();
		} catch (Exception e ) {
			logger.error("Error " + e.getMessage(), e);
			e.printStackTrace();
		}
	}

	public void testFindAll() {
		logger.info("--> Testing retrieve all singers");
		Singers singers = restTemplate.getForObject(URL_GET_ALL_SINGERS, Singers.class);
		logger.info("Revisando numero de singers, debe ser igual a 3: " + (singers.getSingers().size() == 3));
		listSingers(singers);
	}

	public void testFindbyId() {
		logger.info("--> Testing retrieve a singer by id : 1");
		Singer singer = restTemplate.getForObject(URL_GET_SINGER_BY_ID, Singer.class, 1);
		logger.info("Singer should not be null: " + singer);
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
		Singers singers = restTemplate.getForObject(URL_GET_ALL_SINGERS, Singers.class);
		Boolean found = false;
		for(Singer s: singers.getSingers()) {
			if(s.getId() == 3) {
				found = true;
			}};
		logger.info("Borrado no debe ser encontrado, encontrado?: " + found);
		listSingers(singers);
	}
	
	public void testCreate() {
		logger.info("--> Testing create singer");
		Singer singerNew = new Singer();
		singerNew.setFirstName("BB");
		singerNew.setLastName("King");
		singerNew.setBirthDate(new Date((new GregorianCalendar(1940, 8, 16)).getTime().getTime()));
		singerNew = restTemplate.postForObject(URL_CREATE_SINGER, singerNew, Singer.class);
		logger.info("Singer created successfully: " + singerNew);
		logger.info("Singer created successfully: " + singerNew);
		Singers singers = restTemplate.getForObject(URL_GET_ALL_SINGERS, Singers.class);
		listSingers(singers);
	}

	private void listSingers(Singers singers) {
		singers.getSingers().forEach(s -> logger.info(s.toString()));
	}
}
