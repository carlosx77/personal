package com.carlosx.remoting.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.carlosx.remoting.entities.Singer;

public interface SingerRepository extends CrudRepository<Singer, Long> {
	public List<Singer> findByFirstName (String firstName);
}
