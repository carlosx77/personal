package com.carlosx.transactional.service;

import java.util.List;

import org.springframework.jms.core.JmsTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.carlosx.transactional.entities.Singer;
import com.carlosx.transactional.ex.AsyncXAResourcesException;
import com.carlosx.transactional.repos.SingerRepository;

@Service ("singerService")
@Transactional
public class SingerServiceImpl implements SingerService {

	//No Autowired as we are using Spring Boot "magic", Boot injects them if they are the only ones declared
	private SingerRepository singerRepository;
	private JmsTemplate jmsTemplate;
	
	public SingerServiceImpl (SingerRepository singerRepository, JmsTemplate jmsTemplate) {
		this.singerRepository = singerRepository;
		this.jmsTemplate = jmsTemplate;
	}
	
	@Override
	public List<Singer> findAll() {
		
		return null;
	}

	@Override
	public Singer findById(Long id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Singer save(Singer singer) {
		jmsTemplate.convertAndSend("singers", "just saved: " + singer);
		if (singer == null) {
			throw new AsyncXAResourcesException("Simulation of something wrong"); 
		}
		singerRepository.save(singer);
		return singer;
	}

	@Override
	public long countAll() {
		return singerRepository.count();
	}

}
