package com.carlosx.jbdcTests.entities;

import java.io.Serializable;
import java.sql.Date;

public class Album implements Serializable{

	private static final long serialVersionUID = 1L;
	private Long id;
	private Long albumId;
	private String title;
	private Date releaseDate;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getAlbumId() {
		return albumId;
	}
	public void setSingerId(Long albumId) {
		this.albumId = albumId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getReleaseDate() {
		return releaseDate;
	}
	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
	}
	
}
