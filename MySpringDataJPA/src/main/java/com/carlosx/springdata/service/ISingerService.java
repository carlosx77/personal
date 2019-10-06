package com.carlosx.springdata.service;

import java.util.List;

import com.carlosx.springdata.entities.Singer;

public interface ISingerService {
	public List<Singer> findAll ();
	public List<Singer> findByFirstName (String firstName);
	public List<Singer> findByFirstNameAndLastName (String firstName, String lastName);
}
