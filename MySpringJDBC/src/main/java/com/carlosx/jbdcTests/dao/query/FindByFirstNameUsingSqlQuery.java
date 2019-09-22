package com.carlosx.jbdcTests.dao.query;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import javax.sql.DataSource;

import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.object.MappingSqlQuery;

import com.carlosx.jbdcTests.dao.mapper.SqlToObjectMapperSinger;
import com.carlosx.jbdcTests.dao.mapper.IConvertToObject;
import com.carlosx.jbdcTests.entities.Singer;

public class FindByFirstNameUsingSqlQuery extends MappingSqlQuery<Singer> {
	
	private static final String SQL_FIND_BY_NAME = "Select id, first_name, last_name, birth_date from Singer where first_name = :first_name ";
	String firstName;
	
	public FindByFirstNameUsingSqlQuery (DataSource ds) {
		super (ds, SQL_FIND_BY_NAME);
		super.declareParameter(new SqlParameter("first_name", Types.VARCHAR));
	}

	@Override
	protected Singer mapRow(ResultSet rs, int rowNum) throws SQLException {
		IConvertToObject mapper = new SqlToObjectMapperSinger();
		return (Singer) mapper.convertToObject(rs);
	}


}
