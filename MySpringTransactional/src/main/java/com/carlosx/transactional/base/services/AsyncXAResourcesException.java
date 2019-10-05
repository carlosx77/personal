package com.carlosx.transactional.base.services;

@SuppressWarnings("serial")
public class AsyncXAResourcesException extends RuntimeException {
	public AsyncXAResourcesException(String message) {
		super(message);
	}
}
