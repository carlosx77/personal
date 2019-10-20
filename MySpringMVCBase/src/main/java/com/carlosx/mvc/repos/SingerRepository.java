package com.carlosx.mvc.repos;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.carlosx.mvc.entities.Singer;

public interface SingerRepository extends PagingAndSortingRepository<Singer, Long> {
	public List<Singer> findByFirstName (String firstName);
}
