package com.carlosx.mvc.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.carlosx.mvc.entites.Singer;
import com.carlosx.mvc.repos.SingerRepository;
import com.google.common.collect.Lists;

@Service ("singerService")
@Transactional
public class SingerServiceImpl implements SingerService {
	
	@Autowired
    private SingerRepository singerRepository;
    @Override
    @Transactional(readOnly = true)
    public List<Singer> findAll() {
        return Lists.newArrayList(singerRepository.findAll());
    }
    @Override
    @Transactional(readOnly = true)
    public List<Singer> findByFirstName(String firstName) {
        return singerRepository.findByFirstName(firstName);
    }
    @Override
    @Transactional(readOnly = true)
    public Singer findById(Long id) {
        return singerRepository.findById(id).get();
    }
    @Override
    public Singer save(Singer singer) {
        return singerRepository.save(singer);
    }
    @Override
    public void delete(Singer singer) {
        singerRepository.delete(singer);
    }
	@Override
	public Page<Singer> findAllByPage(Pageable pageable) {
		return singerRepository.findAll(pageable);
	}
}
