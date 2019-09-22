package com.carlosx.hibernate.main;

import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.GenericApplicationContext;

import com.carlosx.hibernate.config.ProjectConfig;
import com.carlosx.hibernate.dao.ISingerDao;
import com.carlosx.hibernate.entities.Album;
import com.carlosx.hibernate.entities.Instrument;
import com.carlosx.hibernate.entities.Singer;

public class TestHibernateProject {
	private static Logger logger = LoggerFactory.getLogger(TestHibernateProject.class);
	private static GenericApplicationContext ctx;

	public static void main(String[] args) {
		ctx = new AnnotationConfigApplicationContext(ProjectConfig.class);
		ISingerDao dao = (ISingerDao) ctx.getBean("daoSingerImpl");
		List<Singer> singers = dao.findAll();
		// printSingersAndAssociatedObjects(singers); commented, works only if fetch configurations are set to EAGER
		printSingers(singers);
		printSingersAndAssociatedObjects(dao.findAllWithAlbums());
		
		Singer singer = dao.findById(1l);
		logger.info("Find by id: " + singer.toString());
		
		Singer newSinger = new Singer();
		newSinger.setFirstName("Carlos4");
		newSinger.setLastName("Perez4");
		newSinger.setBirthDate(new Date(new GregorianCalendar(1940, 8, 16).getTime().getTime()));
		
		Album newAlbum = new Album();
		newAlbum.setReleaseDate(new Date(new GregorianCalendar(1940, 8, 16).getTime().getTime()));
		newAlbum.setTitle("MiTitlulo2");
		
		newSinger.addAlbum(newAlbum);
		dao.save(newSinger); // commented as we need to change first name each time we run the program unless we delete it
		singers = dao.findAllWithAlbums();
		
		
		logger.info("Added Singer and Album!!!!!!!!!!!!!!!!!!!!!!");
		printSingersAndAssociatedObjects(singers);
		
		logger.info("Deleting Carlos4!!!!!!!!!!!!");
		dao.delete(newSinger);
		singers = dao.findAllWithAlbums();
		printSingersAndAssociatedObjects(singers);

		
	}
	
	private static void printSingers(List<Singer> singers) {
		for (Singer singer : singers) {
			logger.info(singer.toString());
		}
	}

	private static void printSingersAndAssociatedObjects(List<Singer> singers) {
		for (Singer singer : singers) {
			logger.info(singer.toString());
			if (singer.getAlbums() != null) {
				for (Album album : singer.getAlbums()) {
					logger.info("\tAlbum: " + album.toString());
					// throws error if fetch type not set to EAGER:
					// org.hibernate.LazyInitializationException: failed to lazily initialize a
					// collection of role: com.carlosx.hibernate.entities.Singer.albums, could not
					// initialize proxy - no Session
					// this means that the session is not open to fetch the associated objects because
					// the fetching is set to lazy, this is to not to have performance problems
					// as retrieving a full list of associated objects can seriously affect performance
					
					/*
					 * Other way to get or force to get the associated objects is using a Criteria and
					 * call Criteria.setFetchMode() to force eager asociation
					 */
				}
			}
			if (singer.getInstruments() != null ) { 
				for (Instrument instrument: singer.getInstruments()) {
					logger.info(instrument.toString());
				}
			}
		}
	}
}
