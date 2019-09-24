package com.carlosx.hibernate.config;

import java.io.IOException;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;


@Configuration
@ComponentScan(basePackages="com.carlosx.hibernate")
@PropertySource ("classpath:db/database.properties")
@EnableTransactionManagement
public class ProjectConfig {
	
	@Value ("${database.driverClassName}")
	private String driverName;
	@Value ("${database.url}")
	private String url;
	@Value ("${database.databaseName}")
	private String databaseName;
	@Value ("${database.username}")
	private String user;
	@Value ("${database.password}")
	private String password;
	
	
	//Hibernate properties
	@Value ("${hibernate.dialect}")
	private String dialect;
	@Value ("${hibernate.formatSql}")
	private Boolean formatSql;
	@Value ("${hibernate.useSqlComments}")
	private Boolean useSqlComments;
	@Value ("${hibernate.showSql}")
	private Boolean showSql;
	@Value ("${hibernate.batchSize}")
	private Integer batchSize;
	@Value ("${hibernate.fetchSize}")
	private Integer fetchSize;
	@Value ("${hibernate.maxFetchDept}")
	private Integer maxFetchDept;
	
	
	
	private static Logger logger = LoggerFactory.getLogger(ProjectConfig.class);
	
	@Bean
	public DataSource dataSource () {
		BasicDataSource ds = new BasicDataSource();
		ds.setDriverClassName(this.driverName);
		ds.setUrl(this.url);;
		ds.setUsername(this.user);
		ds.setPassword(this.password);
		return ds;
	}
	
	@Bean
	public SessionFactory sessionFactory () throws IOException {
		LocalSessionFactoryBean session = new LocalSessionFactoryBean();
		session.setDataSource(this.dataSource());
		session.setPackagesToScan("com.carlosx.hibernate.entities");
		session.setHibernateProperties(this.hibernateProperties());
		session.afterPropertiesSet();
		return session.getObject();
	}
	
	private Properties hibernateProperties() {
		Properties hibernateProp = new Properties();
	    hibernateProp.put("hibernate.dialect", this.dialect);
	    hibernateProp.put("hibernate.format_sql", this.formatSql);
	    hibernateProp.put("hibernate.use_sql_comments", this.showSql);
	    hibernateProp.put("hibernate.show_sql", this.showSql);
	    hibernateProp.put("hibernate.max_fetch_depth", this.maxFetchDept);
	    hibernateProp.put("hibernate.jdbc.batch_size", this.batchSize);
	    hibernateProp.put("hibernate.jdbc.fetch_size", this.fetchSize);
	    return hibernateProp;
	}
	
	// transactionManager is the default name that Spring looks for when it needs a transaction manager
	@Bean
	public PlatformTransactionManager transactionManager () throws IOException {
		return new HibernateTransactionManager(sessionFactory());
	}
	
	
}
