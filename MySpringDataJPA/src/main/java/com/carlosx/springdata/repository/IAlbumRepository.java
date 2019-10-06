package com.carlosx.springdata.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.carlosx.springdata.entities.Album;
import com.carlosx.springdata.entities.Singer;

public interface IAlbumRepository extends JpaRepository<Album, Long> {
	
	public List<Album> findBySinger (Singer singer);
	@Query("select a from Album a where a.title like %:title%")
	public List<Album> findByTitle(@Param("title") String t); //if the parameter name matches the column name then @Param is not needed
		//in this case I set the parameter name as t, so i need to use @Param
}
