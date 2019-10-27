package com.carlosx.mvc.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.csrf.CsrfTokenRepository;
import org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository;

@Configuration
@EnableWebSecurity
@ComponentScan("com.carlosx.rest")
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	private static Logger logger = LoggerFactory.getLogger(SecurityConfig.class);
	
	@Autowired
	protected void configureGlobal (AuthenticationManagerBuilder auth) throws Exception {
		logger.info("-------ZZZZZ Configuring authentication 1!!!! ");
		try {
			User.withDefaultPasswordEncoder().username("prospring5").password("prospring5").roles("REMOTE").build();
			//auth.inMemoryAuthentication().withUser("prospring5").password("{noop}prospring5").roles("REMOTE");
		} catch (Exception e) {
			logger.error("Could not configure Authentication!!!", e);
		}
	}
	
	@Override
	protected void configure (HttpSecurity http) throws Exception {
		logger.info("-------ZZZZZ Configuring authentication 2!!!! ");
		http
		.authorizeRequests()
		.antMatchers("/*").permitAll()
		.and()
		.formLogin()
		.usernameParameter("username")
		.passwordParameter("password")
		.loginProcessingUrl("/login")
		.loginPage("/singers")
		.failureUrl("/security/loginfail")
		.defaultSuccessUrl("/singers")
		.permitAll()
		.and()
		.logout()
		.logoutUrl("/logout")
		.logoutSuccessUrl("/singers")
		.and()
		.csrf().disable();
		//csrfTokenRepository(repo());
	}
	
	@Bean
    public UserDetailsService userDetailsService() {
        User.UserBuilder users = User.withDefaultPasswordEncoder();
        InMemoryUserDetailsManager manager = new InMemoryUserDetailsManager();
        manager.createUser(users.username("prospring5").password("prospring5").roles("REMOTE").build());
        //manager.createUser(users.username("admin").password("password").roles("USER", "ADMIN").build());
        return manager;
    }
	
	@Bean
	public CsrfTokenRepository repo() {
		HttpSessionCsrfTokenRepository repo = new HttpSessionCsrfTokenRepository();
		repo.setParameterName("_csrf");
		repo.setHeaderName("X-CSRF-TOKEN");
		return repo;
	}
}
