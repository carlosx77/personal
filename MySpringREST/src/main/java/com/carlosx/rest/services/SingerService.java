package com.carlosx.rest.services;

import java.util.List;

import com.carlosx.rest.entities.Singer;

public interface SingerService {
	public List<Singer> findAll ();
	public List<Singer> findByFirstName (String firstName);
	public Singer findById (Long id);
	public Singer save (Singer singer);
	public void delete (Singer singer);
}
