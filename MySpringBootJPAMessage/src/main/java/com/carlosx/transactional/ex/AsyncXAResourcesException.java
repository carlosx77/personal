package com.carlosx.transactional.ex;

@SuppressWarnings("serial")
public class AsyncXAResourcesException extends RuntimeException {
	public AsyncXAResourcesException(String message) {
		super(message);
	}
}
