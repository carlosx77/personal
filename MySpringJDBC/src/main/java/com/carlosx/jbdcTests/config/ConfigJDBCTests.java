package com.carlosx.jbdcTests.config;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import com.carlosx.jbdcTests.dao.ISingerDao;
import com.carlosx.jbdcTests.dao.DaoSingerImpl;

@Configuration
@PropertySource("classpath:db/database.properties")
@ComponentScan(basePackages = "com.carlosx")
public class ConfigJDBCTests {
	private static Logger logger = LoggerFactory.getLogger(ConfigJDBCTests.class);
	
	@Value("${database.driverClassName}")
	private String driverClassName;
	@Value("${database.url}")
	private String url;
	@Value("${database.username}")
	private String username;
	@Value("${database.password}")
	private String pwd;
	
	@Bean
	public ISingerDao singerDao () {
		DaoSingerImpl singerDao = new DaoSingerImpl();
		singerDao.setDataSource(dataSource());
		return singerDao;
	}
	
	@Bean
	public DataSource dataSource() {
		try {
			BasicDataSource ds = new BasicDataSource();
			ds.setDriverClassName(driverClassName);
			ds.setUrl(url);
			ds.setUsername(username);
			ds.setPassword(pwd);
			return ds;
		} catch (Exception e) {
			logger.error("BCP error ", e);
			return null;
		}
	}
	
}
