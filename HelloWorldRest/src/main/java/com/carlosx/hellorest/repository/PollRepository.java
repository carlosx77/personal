package com.carlosx.hellorest.repository;

import org.springframework.data.repository.CrudRepository;

import com.carlosx.hellorest.domain.Poll;

public interface PollRepository extends CrudRepository<Poll, Long> {

}
