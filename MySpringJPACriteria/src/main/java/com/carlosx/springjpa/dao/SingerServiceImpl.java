package com.carlosx.springjpa.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.carlosx.springjpa.entities.Singer;

@Service
@Repository
@Transactional
public class SingerServiceImpl implements SingerService {
	
	public static final String ALL_SINGER_NATIVE_QUERY = "Select id, first_name, last_name, version from singer";
	private static Logger logger = LoggerFactory.getLogger(SingerServiceImpl.class);
	@PersistenceContext
	private EntityManager em;
	
	public List<Singer> findAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Singer> findAllWithAlbum() {
		// TODO Auto-generated method stub
		return null;
	}

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

	@Override
	public List<Singer> findAllByNativeQuery() {
		// TODO Auto-generated method stub
		return null;
	}

	@Transactional (readOnly=true)
	@Override
	public List<Singer> findByCriteriaQuery(String firstName, String lastName) {
		/*CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Singer> criteriaQuery = cb.createQuery(Singer.class);
		Root<Singer> singerRoot = criteriaQuery.from(Singer.class);
		singerRoot.fetch(Singer_.albums)*/
		return null;
	}

}
