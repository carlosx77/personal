package com.tests.staticandstaticinstancebloks;

public class StaticInstanceInitializerSubClass extends StaticInstanceInitializer {
	{
		// Should call super!!!
		System.out.println ("Instance initializer on sub class");
	}
}
