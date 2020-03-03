package com.tests.staticandstaticinstancebloks;

public class StaticAndStaticMethods {
	static {
		main ("Hola");
	}
	// THIS IS AN INSTANCE INITIALIZER, its called before any constructor
	// you can add login to be executed no matter which constructor is used
	// has access to instance variables and static ones
	{
		this.methodToUseOnInstanceInitializer();
	}
	public static void main (String...args) {
		System.out.println ("Hola");
		new StaticAndStaticMethods();
	}
	
	public void methodToUseOnInstanceInitializer () {
		System.out.println("Method to be used by instance initializer");
		// why this text is printed twice, because inside static{} we call main and main is
		// also called when the program loads 
		// see how behaves on testInstance initializer
	}

}
