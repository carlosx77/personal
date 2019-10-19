package com.carlosx.mvc.services;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.carlosx.mvc.entites.Singer;

public interface SingerService {
	public List<Singer> findAll ();
	public List<Singer> findByFirstName (String firstName);
	public Singer findById (Long id);
	public Singer save (Singer singer);
	public void delete (Singer singer);
	Page<Singer> findAllByPage(Pageable pageable);
}
