package com.carlosx.transactional.base.repos;

import org.springframework.data.jpa.repository.JpaRepository;

import com.carlosx.transactional.base.entities.Album;
import com.carlosx.transactional.base.entities.Singer;

import java.util.List;

/**
 * Created by iuliana.cosmina on 5/7/17.
 */
public interface AlbumRepository /*extends JpaRepository<Album, Long>*/ {
	List<Album> findBySinger(Singer singer);
}
