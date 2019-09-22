package com.carlosx.jbdcTests.dao.query;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.jdbc.object.MappingSqlQuery;

import com.carlosx.jbdcTests.dao.mapper.SqlToObjectMapperSinger;
import com.carlosx.jbdcTests.dao.mapper.IConvertToObject;
import com.carlosx.jbdcTests.entities.Singer;

public class FindAllSingersUsingMappingSqlQuery extends MappingSqlQuery<Singer> {
	
	private static final String SQL_SELECT_ALL_SINGERS = "select id, first_name, last_name, birth_date from singer";
	
	public FindAllSingersUsingMappingSqlQuery (DataSource ds) {
		super (ds, SQL_SELECT_ALL_SINGERS);
	}

	@Override
	protected Singer mapRow(ResultSet rs, int rowNum) throws SQLException {
		IConvertToObject mapper = new SqlToObjectMapperSinger();
		return (Singer)mapper.convertToObject(rs);
	}

}
