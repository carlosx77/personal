package com.carlosx.springdata.config;

import java.util.Properties;

import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
@ComponentScan(basePackages = {"com.carlosx.springdata"})
@EnableJpaRepositories(basePackages = {"com.carlosx.springdata"})
@PropertySource("classpath:db/database.properties")  //change the path & name to obtain properties as needed
@EnableJpaAuditing(auditorAwareRef = "auditorAwareBean")
public class SpringDataJPAConfig {
	
	//Database properties
	@Value("${database.url}")
	private String url;
	@Value("${database.driverClassName}")
	private String driverName;
	@Value("${database.username}")
	private String user;
	@Value("${database.password}")
	private String pwd;
	
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
	
	@Bean
	public DataSource dataSource () {
		BasicDataSource ds = new BasicDataSource ();
		ds.setUrl(this.url);
		ds.setDriverClassName(this.driverName);
		ds.setUsername(this.user);
		ds.setPassword(this.pwd);
		return ds;
	}
	
	@Bean
	public Properties hibernateProperties () {
		Properties prop = new Properties();
		prop.put("hibernate.dialect", this.dialect);
		prop.put("hibernate.format_sql", this.formatSql);
		prop.put("hubernate.use_sql_comments", this.useSqlComments);
		prop.put("hibernate.show_sql", this.showSql);
		prop.put("hibernate.max_fetch_depth", this.maxFetchDept);
		prop.put("hibernate.jdbc.batch_size", this.batchSize);
		prop.put("hibernate.jdbc.fetch_size", this.fetchSize);
		return prop;
	}

	@Bean
	public EntityManagerFactory entityManagerFactory() {
		LocalContainerEntityManagerFactoryBean factoryBean = new LocalContainerEntityManagerFactoryBean();
		//TO-DO change package as needed
		factoryBean.setPackagesToScan("com.carlosx.springdata.entities");
		factoryBean.setDataSource(this.dataSource());
		factoryBean.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
		factoryBean.setJpaProperties(this.hibernateProperties());
		factoryBean.afterPropertiesSet();
		return factoryBean.getNativeEntityManagerFactory();
	}

	@Bean
	public PlatformTransactionManager transactionManager () {
		return new JpaTransactionManager(this.entityManagerFactory());
	}
	
}
