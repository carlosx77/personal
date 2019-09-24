package com.carlosx.myJpa.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.carlosx.myJpa.entities.Singer;
import com.carlosx.myJpa.view.SingerSummary;

@Service
@Repository
@Transactional
public class SingerJpaService implements SingerService {

	private final static String ALL_SINGER_NATIVE_QUERY = "select id, first_name, last_name, birth_date, version from singer";

	@PersistenceContext
	private EntityManager em;

	private static Logger logger = LoggerFactory.getLogger(SingerJpaService.class);

	@Transactional(readOnly = true)
	@Override
	public List<Singer> findAll() {
		return em.createNamedQuery(Singer.FIND_ALL, Singer.class).getResultList();
	}

	@Transactional(readOnly = true)
	@Override
	public List<Singer> findAllWithAlbum() {
		return em.createNamedQuery(Singer.FIND_ALL_WITH_ALBUM, Singer.class).getResultList();
	}

	@Transactional(readOnly = true)
	@Override
	public Singer findById(Long id) {
		TypedQuery<Singer> query = em.createNamedQuery(Singer.FIND_SINGER_BY_ID, Singer.class);
		query.setParameter("id", id);
		return query.getSingleResult();
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

	@Transactional(readOnly = true)
	@Override
	public List<Singer> findAllByNativeQuery() {
		// TODO Auto-generated method stub
		return null;
	}

	@Transactional(readOnly = true)
	@Override
	public List<Object[]> displayAllSingerSummary() {
		List<Object[]> result = em.createQuery("select s.firstName, s.lastName, a.title from Singer s "
				+ "left join s.albums a " + "where a.releaseDate=(select max(a2.releaseDate) "
				+ "from Album a2 where a2.singer.id = s.id)", Object[].class).getResultList();
		return result;
	}

	@Transactional(readOnly=true)
	@Override
	public List<SingerSummary> displayAllSingerSummaryUsingView() {
		List<SingerSummary> result = em.createQuery(
				"select new com.carlosx.myJpa.view.SingerSummary("
						+ "s.firstName, s.lastName, a.title) from Singer s "
						+ "left join s.albums a "
						+ "where a.releaseDate=(select max(a2.releaseDate) from Album a2 where a2.singer.id = s.id)", SingerSummary.class).getResultList();
		return result;
	}
}
