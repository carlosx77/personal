package com.carlosx.jbdcTests.dao.query;

import java.sql.Types;

import javax.sql.DataSource;

import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.object.SqlUpdate;

public class SingerInsert extends SqlUpdate {
	private static final String SQL_INSERT_SINGER = "INSERT INTO SINGER (first_name, last_name, birth_date) values (:first_name, :last_name, :birth_date)";

	public SingerInsert (DataSource ds) {
		super(ds, SQL_INSERT_SINGER);
		super.declareParameter(new SqlParameter("first_name", Types.VARCHAR));
		super.declareParameter(new SqlParameter("last_name", Types.VARCHAR));
		super.declareParameter(new SqlParameter("birth_date", Types.DATE));
		super.setGeneratedKeysColumnNames(new String[] {"id"});
		super.setReturnGeneratedKeys(true);
	}
}
