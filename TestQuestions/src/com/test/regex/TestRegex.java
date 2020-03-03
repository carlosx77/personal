package com.test.regex;

public class TestRegex {
	public static void main (String...args) {
		String str = "as, htasdf. ashdrdf asddhftgf";
		String[] result = str.split("(,|\\.)*\\s");
		for (String temp : result) {
			System.out.println(temp);
		}
	}
}
