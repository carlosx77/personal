package com.carlosx.jbdcTests.dao.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public interface IConvertToObject {

	<T> T convertToObject(ResultSet rs) throws SQLException;

}