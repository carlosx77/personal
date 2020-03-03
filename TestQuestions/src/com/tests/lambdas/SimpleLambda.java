package com.tests.lambdas;

import java.util.Arrays;
import java.util.List;
import java.util.function.Predicate;
import java.util.stream.Collectors;

public class SimpleLambda {
	// this is my first lambda!!!
	
	public static void main (String...arg) {
		SimpleLambda test = new SimpleLambda();
		test.executeTests();
	}

	private void executeTests() {
		List<String> array = Arrays.asList(new String[]{"A", "B", "C"});
		/*
		 * Example of a Consumer!
		 * For Each receives a Consumer, it means that an element is passed as a parameter
		 * and nothing is returned
		 */
		array.forEach((e)->System.out.println (e)); 
		/*
		 * Example of a Predicate	
		 */
		List<String> array2 = array.stream()
				.filter((a)->a.equals("A") || a.equals("B"))
				.collect(Collectors.<String>toList()); //Terminal Method, try commenting this
					//method  and the list will be intact (Intermediate methods not executed)
		System.out.print ("Collecting ");
		array2.forEach((e)->System.out.println (e)); 
		
		//original array kept intact
		array.forEach((e)->System.out.println("Original " + e.toString()));
		
		/*
		 * Predicate with additional conditions
		 */
		Predicate<String> stringEqualA = (a)->a.equals("A");
		Predicate<String> stringEqualB = (a)->a.equals("B");

		List<String> array3 = array.stream()
				.filter( stringEqualA.or( (a)->a.equals("B") ) )
				//.filter( stringEqualA.or( stringEqualB ) ) //also this is valid
				.collect(Collectors.<String>toList());
		
		System.out.println ("filter if value equals a or b:");
		array3.forEach( (a)-> System.out.println (a));
	}
}
