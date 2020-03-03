package com.tests.staticandstaticinstancebloks;

public class TestInstanceInitializer {
	public static void main (String...args) {
		new StaticInstanceInitializer();
		
		System.out.println ("Testing with subclases");
		new StaticInstanceInitializerSubClass();
	}
}
