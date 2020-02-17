package cracking.stringsandarrays.isunique;

import java.util.HashMap;

/* Implement an algorithm to determine if a string has all unique characters
 * 
 */
public class IsUniqueProblem {
	public static void main (String...args) {
		IsUniqueProblem unique = new IsUniqueProblem();
		System.out.println("Is unique: " + unique.hasAllUnique("nique"));
		System.out.println("Is unique: " + unique.hasAllUniqueNoDataStructures("nique"));
	}
	
	public boolean hasAllUnique (String str) {
		char ch;
		HashMap<Character, Integer> charSet = new HashMap<Character, Integer>();
		for ( int i=0; i<str.length(); i++ ) {
			ch = str.charAt(i);
			Integer ocurrences = charSet.get(ch);
			if ( ocurrences == null ) {
				charSet.put(ch, 1);
			} else {
				//we can also simply return true;
				charSet.put(ch, ocurrences+1);
				return false;
			}
		}
		return true;
	}
	
	//now without data structures:
	public boolean hasAllUniqueNoDataStructures (String str ) {
		//taking into account that we have a predefined list of set of characters
		char ch;
		int dictionaryLength = 256;
		int[] dictionaryCount = new int[dictionaryLength];
		for ( int i=0; i<str.length(); i++ ) {
			ch = str.charAt(i);
			if ( dictionaryCount[ch] == 0 )
				dictionaryCount[ch] = 1;
			else
				return false;
		}
		return true;
	}
	
	// if they dont want me to use even arrays the only option is to compare each char with all others
	// this will give an O(N^2)
}

	