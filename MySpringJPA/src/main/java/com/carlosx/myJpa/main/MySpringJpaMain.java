package com.carlosx.myJpa.main;

//import java.util.Date;
//import java.util.GregorianCalendar;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.carlosx.myJpa.config.JpaConfig;
import com.carlosx.myJpa.entities.Album;
import com.carlosx.myJpa.entities.Instrument;
import com.carlosx.myJpa.entities.Singer;
import com.carlosx.myJpa.service.SingerJpaService;
import com.carlosx.myJpa.service.SingerService;
import com.carlosx.myJpa.view.SingerSummary;

public class MySpringJpaMain {
	
	private static Logger logger = LoggerFactory.getLogger(SingerJpaService.class);
	
	public static void main (String...args) {
		ConfigurableApplicationContext ctx = new AnnotationConfigApplicationContext(JpaConfig.class);
		SingerService service = (SingerService) ctx.getBean("singerJpaService");
		List<Singer> singers = service.findAll();
		printOnlySingers(singers);
		printSingers (service.findAllWithAlbum());
		
		Singer single = service.findById(4l);
		logger.info("Single Singer: " + single.toString());
		List<Object[]> summary = service.displayAllSingerSummary();
		for ( Object[] row : summary ) {
			logger.info("Summary Row: " + row[0] + ", " + row[1] + ", " + row[2]);
		}
		List<SingerSummary> viewSummary = service.displayAllSingerSummaryUsingView();
		for ( SingerSummary singer : viewSummary ) {
			logger.info("Summary view: " + singer.toString());
		}
		
		/*Singer newSinger = new Singer();
		newSinger.setFirstName("Carlosx");
		newSinger.setLastName("Perez");
		newSinger.setBirthDate(new Date(
		        (new GregorianCalendar(1940, 8, 16)).getTime().getTime()));
        Album  album = new Album();
        album.setTitle("My Kind of Blues");
        album.setReleaseDate(new java.sql.Date(
        (new GregorianCalendar(1961, 7, 18)).getTime().getTime()));
        newSinger.addAlbum(album);
        album = new Album();
        album.setTitle("A Heart Full of Blues");
        album.setReleaseDate(new java.sql.Date(
        (new GregorianCalendar(1962, 3, 20)).getTime().getTime()));
        newSinger.addAlbum(album);
        service.save(newSinger);*/
		
		// service.delete(single);
        
        printSingers (service.findAllWithAlbum());
        logger.info("All by Native Query");
        printOnlySingers (service.findAllByNativeQuery());
        
		ctx.close();
	}
	
	private static void printOnlySingers(List<Singer> singers) {
		logger.info("Printing only singers");
		for (Singer singer: singers) {
			logger.info("Singer: " + singer.toString());
			//logger.info("Albums " + singer.getAlbums()); //throws LazyInitializationException as we did not query for albums
		}
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
