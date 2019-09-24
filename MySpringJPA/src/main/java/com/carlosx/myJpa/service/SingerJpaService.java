package com.carlosx.myJpa.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.carlosx.myJpa.entities.Singer;

@Service
@Repository
@Transactional
public class SingerJpaService implements SingerService {
	
	private final static String ALL_SINGER_NATIVE_QUERY = "select id, first_name, last_name, birth_date, version from singer";
	
	@PersistenceContext
	private EntityManager em;
	
	private static Logger logger = LoggerFactory.getLogger(SingerJpaService.class);

	@Transactional(readOnly=true)
	@Override
	public List<Singer> findAll() {
		return em.createNamedQuery(Singer.FIND_ALL, Singer.class).getResultList();
	}

	@Transactional(readOnly=true)
	@Override
	public List<Singer> findaAllWithAlbum() {
		// TODO Auto-generated method stub
		return null;
	}

	@Transactional(readOnly=true)
	@Override
	public Singer findById(Long id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Singer save(Singer singer) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void delete(Singer singer) {
		// TODO Auto-generated method stub
		
	}

	@Transactional(readOnly=true)
	@Override
	public List<Singer> findAllByNativeQuery() {
		// TODO Auto-generated method stub
		return null;
	}



}
