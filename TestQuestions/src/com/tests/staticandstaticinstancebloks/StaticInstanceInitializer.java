package com.tests.staticandstaticinstancebloks;

public class StaticInstanceInitializer {
	{
		// Instance initializer automatically invokes super 
		this.methodToUseOnInstanceInitializer(); 
		// instance initializers can access to static methods and variables and
		// also instance methods and variables
		
	}
	
	StaticInstanceInitializer () {
		System.out.println ("Superclass constructor");
	}
	
	public void methodToUseOnInstanceInitializer () {
		System.out.println("Method to be used by instance initializer on StaticInstanceInitializer ");
	}
}
