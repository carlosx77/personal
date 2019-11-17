package com.carlosx.todoclient.util;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@ConfigurationProperties (prefix="todo")
@Component
public class ToDoRestClientProperties {
	private String url;
	private String basePath;
}
