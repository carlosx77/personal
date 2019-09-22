package com.carlosx.jbdcTests.dao.query;

import java.sql.Types;

import javax.sql.DataSource;

import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.object.SqlUpdate;

public class SingerUpdate extends SqlUpdate {
	
	public final static String SQL_UPDATE_SINGER = "UPDATE singer SET first_name =:first_name, last_name=:last_name, "
			+ "birth_date =:birth_date where id =:id";
	public SingerUpdate(DataSource ds) {
		super(ds, SQL_UPDATE_SINGER);
		super.declareParameter(new SqlParameter("id", Types.INTEGER));
		super.declareParameter(new SqlParameter("first_name", Types.VARCHAR));
		super.declareParameter(new SqlParameter("last_name", Types.VARCHAR));
		super.declareParameter(new SqlParameter("birth_date", Types.DATE));
	}
}
