package com.carlosx.springdata.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.carlosx.springdata.entities.Album;
import com.carlosx.springdata.entities.Singer;
import com.carlosx.springdata.repository.IAlbumRepository;

@Service("springJpaAlbumService")
@Transactional
public class AlbumServiceImpl implements IAlbumService {
	
	@Autowired
	private IAlbumRepository iAlbumRepository;

	@Override
	public List<Album> findBySinger(Singer singer) {
		return iAlbumRepository.findBySinger(singer);
	}

	@Override
	public List<Album> findByTitle(String title) {
		return iAlbumRepository.findByTitle(title);
	}

}
