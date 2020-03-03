package com.test.exceptions;

import java.util.function.Predicate;

public class HandlingExceptions {
	public static void main (String...args) {
		/*try {
			Predicate<Thread> pred;
			return;
		} catch (IOException e) {
			
		} finally {
			return;
		}*/ // If we try to try-catch a set of instructions it has to throw the checked exception 
		//we set on cath, otherwise compiler will complain
		try {
			Predicate<Thread> pred;
			return;
		} catch (RuntimeException e) {
			
		} finally {
			return;
		}
	}
}
