package com.carlosx.jbdcTests.dao.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.carlosx.jbdcTests.entities.Singer;

public class SqlToObjectMapperSinger implements IConvertToObject {
	@SuppressWarnings("unchecked")
	@Override
	public Singer convertToObject (ResultSet rs) throws SQLException {
		Singer singer = new Singer();
		singer.setId(rs.getLong("id"));
		singer.setFirstName(rs.getString("first_name"));
		singer.setLastName(rs.getString("last_name"));
		singer.setBirthDate(rs.getDate("birth_date"));
		return singer;
	}
	
	public static Map<String, Object> mapToMap (Singer singer) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("first_name", singer.getFirstName());
		params.put("last_name", singer.getLastName());
		params.put("birth_date", singer.getBirthDate());
		params.put("id", singer.getId());
		return params;
	}
	
	public static Map<String, Object> mapToMapForInsert (Singer singer) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("first_name", singer.getFirstName());
		params.put("last_name", singer.getLastName());
		params.put("birth_date", singer.getBirthDate());
		return params;
	}
}
