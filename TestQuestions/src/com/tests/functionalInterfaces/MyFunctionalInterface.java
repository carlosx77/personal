package com.tests.functionalInterfaces;

@FunctionalInterface
public interface MyFunctionalInterface {
	//A functional interface can have only one abstract method
	public abstract void myMethod ();
	//trying to define another method, compiler complains about invalid annotation this 
	//interface is not functional one
	//public abstract void My2Method();
	//An interface can have static methods
	public static String staticMethodInsideAnInterface () {
		return null;
	}
}
