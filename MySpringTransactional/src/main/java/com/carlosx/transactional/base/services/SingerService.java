package com.carlosx.transactional.base.services;

import java.util.List;

import com.carlosx.transactional.base.entities.Singer;

/**
 * SingerService de carlos
 * @author peca7004
 *
 */
public interface SingerService {

	List<Singer> findAll();

	Singer findById(Long id);

	Singer save(Singer singer);

	long countAll();
}
