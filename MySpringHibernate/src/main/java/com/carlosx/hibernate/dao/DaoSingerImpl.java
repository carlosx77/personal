package com.carlosx.hibernate.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.carlosx.hibernate.entities.Singer;

@Transactional
@Repository("daoSingerImpl")
@SuppressWarnings("unchecked")
public class DaoSingerImpl implements ISingerDao {
	
	private SessionFactory session;

	public SessionFactory getSession() {
		return session;
	}

	@Resource(name = "sessionFactory")
	public void setSession(SessionFactory session) {
		this.session = session;
	}

	@Override
	@Transactional(readOnly = true)
	public List<Singer> findAllWithAlbums() {
		return session.getCurrentSession().getNamedQuery("Singer.findAllWithAlbum").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Singer> findAll() {
		return session.getCurrentSession().createQuery("from Singer s").list();
	}

	@Override
	public Singer findById(Long id) {
		return (Singer) session.getCurrentSession().getNamedQuery("Singer.findById").setParameter("id", id.longValue()).uniqueResult();
	}

	@Override
	public Singer save(Singer singer) {
		session.getCurrentSession().saveOrUpdate(singer);
		return null;
	}

	@Override
	public void delete(Singer singer) {
		session.getCurrentSession().delete(singer);
		
	}

}
