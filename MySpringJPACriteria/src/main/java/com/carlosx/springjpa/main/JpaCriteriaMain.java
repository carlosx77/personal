package com.carlosx.springjpa.main;

import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.carlosx.springjpa.config.JpaConfigCriteria;
import com.carlosx.springjpa.dao.SingerService;
import com.carlosx.springjpa.entities.Album;
import com.carlosx.springjpa.entities.Instrument;
import com.carlosx.springjpa.entities.Singer;

public class JpaCriteriaMain {
	private static Logger logger = LoggerFactory.getLogger(JpaCriteriaMain.class);
	
	public static void main (String... args) {
		ConfigurableApplicationContext ctx = new AnnotationConfigApplicationContext (JpaConfigCriteria.class);
		SingerService service = (SingerService) ctx.getBean("singerServiceImpl");
		List<Singer> singers = service.findByCriteriaQuery("John", "Mayer");
		printSingers(singers);
		ctx.close();
	}
	private static void printSingers(List<Singer> singers) {
		logger.info("Printing only singers & associated objects");
		for (Singer singer: singers) {
			logger.info("Singer: " + singer.toString());
			if ( singer.getAlbums() != null ) {
				printAlbums(singer.getAlbums());
			}
			if ( singer.getInstruments()!=null ) {
				printInstruments (singer.getInstruments());
			}
		}
	}
	
	private static void printInstruments(Set<Instrument> instruments) {
		for ( Instrument instrument: instruments ) {
			logger.info("\tIntrument: " + instrument.toString() );
		}
	}

	private static void printAlbums(Set<Album> albums) {
		for ( Album album: albums ) {
			logger.info("\tAlbum: " + album.toString());
		}
	}
}
