package com.carlosx.mvc.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages= {"com.carlosx.mvc"})
public class WebConfig implements WebMvcConfigurer {
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/").setCachePeriod(31556926);
	}

	/*
	 Resolves static views
	 */
	@Bean
	InternalResourceViewResolver viewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/views/");
		resolver.setSuffix(".jspx");
		resolver.setRequestContextAttribute("requestContext");
		return resolver;
	}
	
	@Override
	 public void addViewControllers(ViewControllerRegistry registry) {
	   registry.addViewController("/").setViewName("singers/list");
	 }
	
	 @Override
	 public void configureDefaultServletHandling(
	  DefaultServletHandlerConfigurer configurer) {
	   configurer.enable();
	 }
}
