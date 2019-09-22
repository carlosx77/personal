package com.carlos.main;

import java.sql.Date;
import java.util.GregorianCalendar;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.carlosx.jbdcTests.config.ConfigJDBCTests;
import com.carlosx.jbdcTests.dao.ISingerDao;
import com.carlosx.jbdcTests.entities.Album;
import com.carlosx.jbdcTests.entities.Singer;

public class TestDemo {
	private static Logger logger = LoggerFactory.getLogger(ConfigJDBCTests.class);

	public static void main (String... args) {
		AnnotationConfigApplicationContext ctx = new AnnotationConfigApplicationContext(ConfigJDBCTests.class);
		ISingerDao singerDao = (ISingerDao)ctx.getBean("singerDao");
		System.out.println ("Nombre: " + singerDao.findById(1l));
		System.out.println ("Success!!");
		System.out.println ("Nombre: " + singerDao.findByIdUsingNamedParameters(1l));
		
		for (Singer singer:singerDao.findAll()) {
			System.out.println ("SingerName: " + singer.getFirstName());
		}
		
		for (Singer singer:singerDao.findByIdWithAlbums(5l)) {
			System.out.println("Singer: " + singer.getFirstName() );
			for (Album album:singer.getAlbums()) {
				System.out.println ("\tAlbum: " + album.getTitle());
			}
		}
		
		Singer singerTemp = null;
		System.out.println ("Executing  All singers using MappingSQLQuery class: ");
		for (Singer singer:singerDao.findAllUsingMappingSqlQuery()) {
			System.out.println ("SingerName: " + singer.getFirstName());
			singerTemp=singer;
		}
		
		
		System.out.println ("Executing findByFirstNameUsingMappingSqlQuery: ");
		for (Singer singer:singerDao.findByFirstNameUsingMappingSqlQuery("Eric")) {
			System.out.println ("SingerName: " + singer.getFirstName());
			
		}
		
		System.out.println ("Excuting update");
		singerTemp.setFirstName("Carlos");
		singerDao.update(singerTemp);
		
		logger.info("insertando nuevo");
		Singer newSinger = new Singer();
		newSinger.setFirstName("First Name");
		newSinger.setLastName("last");
		newSinger.setBirthDate(new Date ( new GregorianCalendar(1991, 1, 17).getTime().getTime()) );
		singerDao.insert(newSinger);
		System.out.println ("Executing  All singers using MappingSQLQuery class: ");
		for (Singer singer:singerDao.findAllUsingMappingSqlQuery()) {
			System.out.println ("SingerName: " + singer.getFirstName());
		}

		ctx.close();
		
		
	}
}
