package cracking.stringsandarrays.oneaway;

import java.util.HashMap;
import java.util.Iterator;

public class OneAwayWrong {

	public static void main(String[] args) {
		OneAwayWrong oneAway = new OneAwayWrong();
		System.out.println ( oneAway.checkOneChange ("pape", "papa")?"Has only one change":"Has no change or more than one chage" );
	}
	
	//THIS IS NOT A GOOD SOLUTION!!!!!!!!! WHEN I HAVE REPETED LETTERS THE COUNTING DOESNT WORK
	// AS IT WILL COUNT MORE CHANGES THAN THE ONES ARE ON
	// pape and papa is an example
	// pape counting will be p = 2, a = 1, e = 1
	// papa counting will be p = 0, a = -1 e = 1 adding using abs will count 2, 
			//and adding them will be 0 and both cases are incorrect
	// USING HASMAP IS A VERY BAD IDEA!!!!!
	// Using this approach could work if there are not repeated chars like in this case
	

	private boolean checkOneChange(String string1, String string2) {
		
		if ( Math.abs(string1.length()-string2.length()) > 2 )
			return false;
		//Counting chars on string1
		HashMap<Character, Integer> charMap = new HashMap<>();
		countChars(string1, charMap);
		System.out.println("Counted chars: " + charMap);
		
		char[] charStr2 = string2.toCharArray();
		Integer ocurrences;
		int changes = 0;
		for (Character c:charStr2 ) {
			//System.out.println("Counted chars: " + charMap);
			ocurrences = charMap.get(c);
			if ( ocurrences == null ) {
				changes++;
				charMap.put(c, 1);
				//System.out.println("A changes on " + c + " value: " + changes);
			} else {
				
				charMap.put(c, (ocurrences.intValue()-1));
				System.out.println("B changes on " + c + " value: " + (ocurrences.intValue()-1));
			}
		}
		System.out.println("1 CharMap : " + charMap);
		changes = this.countChanges(charMap);
		System.out.println("2 CharMap : " + charMap);
		if (changes==1)
			return true;
		//if changes
		return false;
	}

	private int countChanges(HashMap<Character, Integer> charMap) {
		System.out.println("CharMap with final changes!!!: " + charMap );
		int counter = 0;
		Iterator<Integer> it = charMap.values().iterator();
		while ( it.hasNext() ) {
			Integer value = it.next();
			counter += (value);
			System.out.println ("next: " + counter + " value: " + value);
		}
		System.out.println("Changes made: " + counter);
		return (counter);
	}

	private void countChars(String string1, HashMap<Character, Integer> strMap) {
		char[] charStr1 = string1.toCharArray();
		Integer ocurrences;
		for (Character c:charStr1) {
			//System.out.println("Character: " + c);
			ocurrences = strMap.get(c);
			if (ocurrences == null) 
				ocurrences = new Integer(0);
			strMap.put(c, ocurrences.intValue()+1);
			System.out.println("Character: " + c + " Ocurrences: " + (ocurrences + 1));
		}
	}
}
