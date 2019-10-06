package com.carlosx.springdata.repository;

import org.springframework.data.repository.CrudRepository;

import com.carlosx.springdata.entities.SingerAudit;

public interface ISingerAuditRepository extends CrudRepository<SingerAudit, Long> {

}
