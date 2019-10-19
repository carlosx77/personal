package com.carlosx.rest.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.carlosx.rest.entities.Singer;

public interface SingerRepository extends CrudRepository<Singer, Long> {
	public List<Singer> findByFirstName (String firstName);
}
