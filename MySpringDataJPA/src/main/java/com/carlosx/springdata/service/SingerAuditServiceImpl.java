package com.carlosx.springdata.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.carlosx.springdata.entities.SingerAudit;
import com.carlosx.springdata.repository.ISingerAuditRepository;
import com.google.common.collect.Lists;

@Service("singerAuditService")
@Transactional
public class SingerAuditServiceImpl implements ISingerAuditService {
	
	@Autowired
	private ISingerAuditRepository iSingerAuditRepository;

	@Transactional(readOnly=true)
	@Override
	public List<SingerAudit> findAll() {
		return Lists.newArrayList(iSingerAuditRepository.findAll());
	}
	@Transactional(readOnly=true)
	@Override
	public SingerAudit findById(long id) {
		return iSingerAuditRepository.findById(id).get();
	}
	@Transactional
	@Override
	public SingerAudit save(SingerAudit singer) {
		return iSingerAuditRepository.save(singer);
	}

}
