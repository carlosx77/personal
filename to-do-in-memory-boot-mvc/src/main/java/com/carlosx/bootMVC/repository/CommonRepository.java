package com.carlosx.bootMVC.repository;

import java.util.Collection;

public interface CommonRepository<T> {
	public T save (T domain);
	public Iterable<T> save (Collection<T> domains);
	public void delete (T domain);
	public Iterable<T> findAll();
	public T findById(String id);
}
