package com.carlosx.springdata.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.carlosx.springdata.entities.Singer;

public interface ISingerRepository extends CrudRepository<Singer, Long> {
	public List<Singer> findByFirstName (String firstName);
	public List<Singer> findByFirstNameAndLastName (String firstName, String lastName);
}
