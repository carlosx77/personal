package com.carlosx.hellorest.repository;

import org.springframework.data.repository.CrudRepository;

import com.carlosx.hellorest.domain.Option;

public interface OptionRepository extends CrudRepository<Option, Long> {

}
