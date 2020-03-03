package com.tests.functionalInterfaces;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class UsingLambdaThatThrowsExceptions {
	BufferedReaderProcessor r = (b)->b.readLine();
	
	public static void main (String...args) {
		new UsingLambdaThatThrowsExceptions().execute();
	}

	private void execute() {
		try {
			//when you execute the method of the interface you need to surround with try catch
			r.process(new BufferedReader(new FileReader("file.txt")));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
}
