package com.carlosx.jbdcTests.dao;

import java.util.List;

import com.carlosx.jbdcTests.entities.Singer;

public interface ISingerDao {
	
	List<Singer> findAllUsingMappingSqlQuery ();
	
	List<Singer> findByIdWithAlbums (Long id);
	
	List<Singer> findAll();

	List<Singer> findByFirstNameUsingMappingSqlQuery(String firstName);

	String findById(Long id);
	
	String findByIdUsingNamedParameters (Long id);

	void insert(Singer singer);

	void update(Singer singer);

	void delete(Long singerId);

	void insertWithAlbum(Singer singer);
}
