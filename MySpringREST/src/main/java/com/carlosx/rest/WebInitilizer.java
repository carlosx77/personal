package com.carlosx.rest;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import com.carlosx.rest.config.DataServiceConfig;
import com.carlosx.rest.config.WebConfig;

public class WebInitilizer extends AbstractAnnotationConfigDispatcherServletInitializer {

	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class<?>[]{
            DataServiceConfig.class
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
		return new String[]{"/"};
	}

}
