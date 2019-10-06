package com.carlosx.springdata.service;

import java.util.List;

import com.carlosx.springdata.entities.SingerAudit;

public interface ISingerAuditService {
	public List<SingerAudit> findAll();
	public SingerAudit findById(long id);
	public SingerAudit save (SingerAudit singer);
}
