package com.carlosx.simpleApp;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;


@ConfigurationProperties(prefix="carlosx")
public class MyCarlosxProperties {
	private String ip;
	private String database;
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getDatabase() {
		return database;
	}
	public void setDatabase(String database) {
		this.database = database;
	}
	
}
