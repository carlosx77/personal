package com.carlosx.transactional.repos;

import org.springframework.data.repository.CrudRepository;

import com.carlosx.transactional.entities.Singer;

public interface SingerRepository extends CrudRepository<Singer, Long> {

}
