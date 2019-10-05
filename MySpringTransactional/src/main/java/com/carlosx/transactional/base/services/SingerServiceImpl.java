package com.carlosx.transactional.base.services;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;

import org.apache.commons.lang3.NotImplementedException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.orm.jpa.JpaSystemException;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.carlosx.transactional.base.entities.Singer;

/**
 * Clase que implementa el SingerService
 * @author peca7004
 *
 */
@Service("singerService")
@Repository
@Transactional
@SuppressWarnings("unchecked")
public class SingerServiceImpl implements SingerService {
	
	private static Logger logger = LoggerFactory.getLogger(SingerServiceImpl.class);
	
	@PersistenceContext (unitName = "emfA")
	private EntityManager ema;
	
	@PersistenceContext (unitName = "emfB")
	private EntityManager emb;
	
	private static final String FIND_ALL= "select s from Singer s";

	@Transactional (readOnly=true)
	@Override
	public List<Singer> findAll() throws AsyncXAResourcesException {
		List<Singer> singersA = findAllInA();
		List<Singer> singersB = findAllInB();
		logger.info ("---------- SingersA size" + singersA.size());
		logger.info ("---------- SingersB size" + singersB.size());
		if (singersA.size() != singersB.size()) {
			throw new AsyncXAResourcesException ("XA Resources do not contain the same expected data");
		}
		Singer sa = singersA.get(0);
		Singer sb = singersB.get(0);
		if (!sa.getFirstName().equals(sb.getFirstName())) {
			throw new AsyncXAResourcesException ("XA Resources do not contain the same expected data");
		}
		
		List<Singer> singersFromBoth = new ArrayList<>();
		singersFromBoth.add(sa);
		singersFromBoth.add(sb);
		return singersFromBoth;
	}
	
	private List<Singer> findAllInA() {
		return ema.createQuery(FIND_ALL).getResultList();
	}
	
	private List<Singer> findAllInB() {
		return emb.createQuery(FIND_ALL).getResultList();
	}

	@Override
	@Transactional (readOnly=true)
	public Singer findById(Long id) {
		//return singerRepository.findById(id).get();
		throw new NotImplementedException("findAll");
	}

	@Override
	@Transactional (isolation = Isolation.DEFAULT, propagation = Propagation.REQUIRED)
	public Singer save(Singer singer) {
		//return singerRepository.save(singer);
		Singer singerB = new Singer();
		singerB.setFirstName(singer.getFirstName());
		singerB.setLastName(singer.getLastName());
		if (singer.getId() == null) {
			ema.persist(singer);
			if (true)
				throw new JpaSystemException(new PersistenceException("Simulation of something going wrong."));
			emb.persist(singerB);
		} else {
			ema.merge(singer);
			emb.merge(singer);
		}
		return singer;
	}

	//@Transactional (propagation = Propagation.NEVER)
	@Override
	public long countAll() {
		//return singerRepository.countAllSingers();
		throw new NotImplementedException("findAll");
	}

}
