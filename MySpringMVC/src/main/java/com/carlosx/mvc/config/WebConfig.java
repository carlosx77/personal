package com.carlosx.mvc.config;

import java.util.Locale;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.ui.context.support.ResourceBundleThemeSource;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.theme.CookieThemeResolver;
import org.springframework.web.servlet.theme.ThemeChangeInterceptor;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = { "com.carlosx.mvc" })
public class WebConfig implements WebMvcConfigurer {
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/").setCachePeriod(31556926);
	}
	
	 @Bean
	 UrlBasedViewResolver tilesViewResolver() {
	   UrlBasedViewResolver tilesViewResolver =  new UrlBasedViewResolver();
	   tilesViewResolver.setViewClass(TilesView.class);
	   return tilesViewResolver;
	 }
	 @Bean
	 TilesConfigurer tilesConfigurer()  {
	   TilesConfigurer tilesConfigurer  =  new TilesConfigurer();
	   tilesConfigurer.setDefinitions( "/WEB-INF/layouts/layouts.xml",
	   "/WEB-INF/views/**/views.xml"
	   );
	   tilesConfigurer.setCheckRefresh(true);
	   return tilesConfigurer;
	 }

	/*
	 * Resolves static views
	 */
	/*@Bean
	InternalResourceViewResolver viewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/views/");
		resolver.setSuffix(".jspx");
		resolver.setRequestContextAttribute("requestContext");
		return resolver;
	}*/

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("singers/list");
	}

	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}

	@Bean
	ReloadableResourceBundleMessageSource messageSource() {
		ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
		messageSource.setBasenames("WEB-INF/i18n/messages", "WEB-INF/i18n/application");
		messageSource.setDefaultEncoding("UTF-8");
		messageSource.setFallbackToSystemLocale(false);
		return messageSource;
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(localeChangeInterceptor());
		registry.addInterceptor(themeChangeInterceptor());
	}

	@Bean
	ThemeChangeInterceptor themeChangeInterceptor() {
	  return new ThemeChangeInterceptor();
	}
	
	@Bean
	LocaleChangeInterceptor localeChangeInterceptor() {
		return new LocaleChangeInterceptor();
	}

	@Bean
	CookieLocaleResolver localeResolver() {
		CookieLocaleResolver cookieLocaleResolver = new CookieLocaleResolver();
		//cookieLocaleResolver.setDefaultLocale(Locale.ENGLISH);
		//cookieLocaleResolver.setCookieMaxAge(3600);
		//cookieLocaleResolver.setCookieName("locale");
		return cookieLocaleResolver;
	}
	
	@Bean
	ResourceBundleThemeSource themeSource()  {
	  return new ResourceBundleThemeSource();
	}
	
	@Bean
	CookieThemeResolver themeResolver() {
	  CookieThemeResolver cookieThemeResolver = new CookieThemeResolver();
	  cookieThemeResolver.setDefaultThemeName("standard");//will look for standard.properties on resources
	  cookieThemeResolver.setCookieMaxAge(3600);
	  cookieThemeResolver.setCookieName("theme");
	  return  cookieThemeResolver;
	}
}
