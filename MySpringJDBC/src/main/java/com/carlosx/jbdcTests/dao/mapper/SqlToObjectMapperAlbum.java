package com.carlosx.jbdcTests.dao.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.carlosx.jbdcTests.entities.Album;

public class SqlToObjectMapperAlbum implements IConvertToObject {

	@SuppressWarnings("unchecked")
	@Override
	public Album convertToObject(ResultSet rs) throws SQLException {
		Album album = new Album();
		album.setId(rs.getLong("album_id"));
		album.setTitle(rs.getString("title"));
		album.setSingerId(rs.getLong("id"));
		album.setReleaseDate(rs.getDate("release_date"));
		return album;
	}

}
