package com.carlosx.springdata.config;

import java.util.Optional;

import org.springframework.data.domain.AuditorAware;
import org.springframework.stereotype.Component;

/**
 * In this example we are using the String "Carlosx" but in a real case we would use an object User or the object
 * which represents the logged user. In real life we would be setting the user obtained from security infrastructure
 * In spring security we would get the user info from SecurityContextHolder class
 * @author peca7004
 *
 */
@Component
public class AuditorAwareBean implements AuditorAware<String> {

	@Override
	public Optional<String> getCurrentAuditor() {
		return Optional.of("Carlosx");
	}

}
