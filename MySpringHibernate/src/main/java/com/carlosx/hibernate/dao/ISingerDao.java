package com.carlosx.hibernate.dao;

import java.util.List;

import com.carlosx.hibernate.entities.Singer;

public interface ISingerDao {

	List<Singer> findAllWithAlbums();

	List<Singer> findAll();

	Singer findById(Long id);

	Singer save(Singer singer);

	void delete(Singer singer);
}
