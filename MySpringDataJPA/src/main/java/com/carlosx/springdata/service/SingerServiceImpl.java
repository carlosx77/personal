package com.carlosx.springdata.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.carlosx.springdata.entities.Singer;
import com.carlosx.springdata.repository.ISingerRepository;
import com.google.common.collect.Lists;

@Service("singerSpringDataService")
@Transactional
public class SingerServiceImpl implements ISingerService {

	@Autowired
	private ISingerRepository iSingerRepository;

	@Transactional(readOnly = true)
	@Override
	public List<Singer> findAll() {
		return Lists.newArrayList(iSingerRepository.findAll());
	}

	@Transactional(readOnly = true)
	@Override
	public List<Singer> findByFirstName(String firstName) {
		return iSingerRepository.findByFirstName(firstName);
	}

	@Transactional(readOnly = true)
	@Override
	public List<Singer> findByFirstNameAndLastName(String firstName, String lastName) {
		return iSingerRepository.findByFirstNameAndLastName(firstName, lastName);
	}

}
