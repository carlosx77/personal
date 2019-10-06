package com.carlosx.springdata.service;

import java.util.List;

import com.carlosx.springdata.entities.Album;
import com.carlosx.springdata.entities.Singer;

public interface IAlbumService {
	public List<Album> findBySinger(Singer singer);
	public List<Album> findByTitle (String title);
}
