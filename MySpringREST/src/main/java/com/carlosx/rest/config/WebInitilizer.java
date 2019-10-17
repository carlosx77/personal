package com.carlosx.rest.config;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebInitilizer extends AbstractAnnotationConfigDispatcherServletInitializer {

	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class<?>[]{
            DataServiceConfig.class, SecurityConfig.class
		};
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
        return new Class<?>[]{
            WebConfig.class
        };
	}

	@Override
	protected String[] getServletMappings() {
		return new String[]{"/*"};
	}

}