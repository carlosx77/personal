package cracking.stringsandarrays.checkpermutation;

import java.util.Arrays;

public class CheckPermutation {

	/*
	 * Given 2 strings, write a method to decide if one is a permutation of the other
	 * A permutation means that 2 strings share the same letters or chars but in different order
	 * no matter what order, just simply in a different order
	 * a quick way to check if 2 strings maybe a permutation is verifying string size
	 * if they differ on size there is no way they can be a permutation
	 */
	public static void main(String[] args) {
		CheckPermutation permChecker = new CheckPermutation();
		if ( permChecker.isPermutation ( "ABCD", "ADBC" ) )
			System.out.println("Permutation!");
		else
			System.out.println("No permutation");
		
		if ( isPermutationNoSort ( "ABCD", "ADBC" ) ) {
			System.out.println("Permutation!");
		} else {
			System.out.println("No permutation");
		}
	}

	private static boolean isPermutationNoSort(String string, String string2) {
		int[] alphabet = new int[256]; //Assuming a 256 chars alphabet
		char[] strChar1 = string.toCharArray();
		char[] strChar2 = string2.toCharArray();
		
		for (char c : strChar1 ) {
			alphabet[c]++;
		}
		
		for (char c : strChar2 ) {
			alphabet[c]--;
			if ( alphabet[c] < 0 )
				return false;
		}
		
		return true;
	}

	private boolean isPermutation(String a, String b) {
		if ( a.length() != b.length() ) 
			return false;
		a = this.sortString(a);
		b = this.sortString(b);
		return a.equals(b);
		//return strA.compareTo(strB) == 0;
	}
	
	private String sortString (String unsorted) {
		char[] chars = unsorted.toCharArray();
		Arrays.sort(chars);
		return new String (chars);
	}
	
	

}
