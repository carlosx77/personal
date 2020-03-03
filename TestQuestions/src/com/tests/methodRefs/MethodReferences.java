package com.tests.methodRefs;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class MethodReferences {
	public static void main (String...args) {
		
		new MethodReferences().execute();
	}

	private void execute() {
		List<String> simpleList = Arrays.asList(new String[] {"D", "B", "C", "A"});
		
		simpleList.forEach(System.out::println);
		//instead of 
		simpleList.forEach((a)->System.out.print(a));
	}
	
}
