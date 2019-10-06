package com.carlosx.springdata.main;

import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.carlosx.springdata.config.SpringDataJPAConfig;
import com.carlosx.springdata.entities.Album;
import com.carlosx.springdata.entities.Instrument;
import com.carlosx.springdata.entities.Singer;
import com.carlosx.springdata.entities.SingerAudit;
//import com.carlosx.springdata.repository.IAlbumRepository;
import com.carlosx.springdata.service.IAlbumService;
import com.carlosx.springdata.service.ISingerAuditService;
import com.carlosx.springdata.service.ISingerService;

public class MainSpringDataJPA {
	
	private static Logger logger = LoggerFactory.getLogger(MainSpringDataJPA.class);
	
	public static void main (String[] args) {
		ConfigurableApplicationContext ctx = new AnnotationConfigApplicationContext(SpringDataJPAConfig.class);
		ISingerService service = (ISingerService) ctx.getBean("singerSpringDataService");
		
		List<Singer> singers = service.findAll();
		printOnlySingers(singers);
		
		printOnlySingers(service.findByFirstName("John"));
		
		printOnlySingers(service.findByFirstNameAndLastName("John", "Mayer"));
		
		IAlbumService service2 = (IAlbumService) ctx.getBean("springJpaAlbumService");
		
		service2.findByTitle("The").forEach(a-> logger.info(a.toString() + " Singer: " + a.getSinger().getFirstName() + " " + a.getSinger().getLastName()));;
		
		ISingerAuditService auditRepo = (ISingerAuditService) ctx.getBean("singerAuditService");
		
		logger.info("Consultando tabla audit");
		List<SingerAudit> singerAudits = auditRepo.findAll();
		logger.info("Numero de audits encontrado: " + singerAudits.size());
		SingerAudit singerAudit = new SingerAudit();
		singerAudit.setFirstName("Carlosx4");
		singerAudit.setLastName("Perez4");
		singerAudit.setBirthDate(new Date(new GregorianCalendar(1940, 8, 16).getTime().getTime()));
		auditRepo.save(singerAudit);
		logger.info("Consultando tabla audit despues de guardar");
		singerAudits = auditRepo.findAll();
		logger.info("Numero de audits encontrado: " + singerAudits.size());
		for ( SingerAudit sa: singerAudits) {
			logger.info(sa.toString());
		}
		singerAudit.setFirstName("Carlosx5");
		auditRepo.save(singerAudit);
		logger.info("Consultando tabla audit despues de actualizar");
		singerAudits = auditRepo.findAll();
		logger.info("Numero de audits encontrado: " + singerAudits.size());
		for ( SingerAudit sa: singerAudits) {
			logger.info(sa.toString());
		}
		
		ctx.close();
	}
	
	private static void printOnlySingers(final List<Singer> singers) {
		logger.info("Printing only singers");
		for (Singer singer: singers) {
			logger.info("Singer: " + singer.toString());
			//logger.info("Albums " + singer.getAlbums()); //throws LazyInitializationException as we did not query for albums
		}
	}
	
	private static void printSingers(final List<Singer> singers) {
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
