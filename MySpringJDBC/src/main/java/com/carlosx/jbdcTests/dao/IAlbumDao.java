package com.carlosx.jbdcTests.dao;

import java.util.List;

import com.carlosx.jbdcTests.entities.Album;

public interface IAlbumDao {

	List<Album> findAll();

	List<Album> findByFirstName(String firstName);

	String findNameById(Long id);

	String findLastNameById(Long id);

	String findFirstNameById(Long id);

	void insert(Album album);

	void update(Album album);

	void delete(Long albumId);

	void insertWithAlbum(Album album);
}
