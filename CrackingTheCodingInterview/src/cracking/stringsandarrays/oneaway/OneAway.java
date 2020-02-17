package cracking.stringsandarrays.oneaway;

public class OneAway {

	/* 
	 * Analyze what a change can be:
	 * Replacement: a replacement occurs when you have same size but one letter is different
	 * Deletion: one character is removed
	 * Insertion: one character is added
	 * BE CAREFULL WHAT YOU ARE ASKED FOR, THEY ARE NOT ASKING ABOUT 2 CHANGES OR MORE
	 * JUST ASKING IF 1 CHANGE AKA ASSUME THERE CAN NOT BE 2 CHANGES ON STRINGS AND CANNOT BE EQUAL
	 */
	public static void main(String[] args) {
		OneAway oneAway = new OneAway();
		System.out.println ( oneAway.checkOneChangeOrNoChange ("pale", "bale ")?"true Has change":"false Has no just ONE change" );
	}

	private boolean checkOneChangeOrNoChange(String string1, String string2) {
		//First its good to know if any size change
		int str1Size = string1.length();
		int str2Size = string2.length();
		int lengthDiff = Math.abs(str1Size-str2Size);
		System.out.println("Diferencia de longitud: " + lengthDiff);
		
		if ( str1Size == str2Size ) {
			return this.searchForReplacement(string1, string2);
		} else if ( str1Size > str2Size ) {
			return this.searchForDeletion(string1, string2);
		} else {
			return this.searchForDeletion(string2, string1);
		}
		/*if ( lengthDiff > 1 ) 
			return false;
		
		
		char[] sorted1 = string1.toCharArray();
		char[] sorted2 = string2.toCharArray();
		Arrays.sort(sorted1);
		Arrays.sort(sorted2);
		
		int biggerSize = (str1Size>=str2Size?str1Size:str2Size)-1;
		
		//more than 2 added or removed chars case is already detected by now
		//we have still the case where size are same but 1 letter changes
		// and when size different by 1, but 3 are the same, with this for we will find them
		System.out.println("Sorted 1: " + new String(sorted1));
		System.out.println("Sorted 1: " + new String(sorted2));
		
		for (int x=0, y=0 ; x<=biggerSize && y<=biggerSize;  ) {
			System.out.println("Comparing x: " + sorted1[x] + " y: " + sorted2[y]  );
			if ( sorted1[x] == sorted2[y] ) {
				x++; y++; //no changes
			} else {
				if (changes>1)
					return false;
				//else {
				
				if ( x+1<str1Size && sorted1[x+1] == sorted2[y] ) {
					x++;
					changes++;
				} else if ( y+1<str2Size && sorted1[x] == sorted2[y+1] ) {
					y++;
					changes++;
				}  
				
				//}
			} 
		}
		System.out.println("Number of changes: " + changes);
		if (changes==0)
			return false;
		if (changes>1)
			return false;*/
		//return true;
	}

	private boolean searchForDeletion(String biggerStr, String str) {
		int index1 = 0;
		int index2 = 0;
		while (index1<str.length()) {
			System.out.println("Index1: " + index1 + " Index2: " + index2);
			System.out.println("str1: " + biggerStr.charAt(index1) + " str2: " + str.charAt(index2));
			if (biggerStr.charAt(index1) == str.charAt(index2)) {
				index1++;
				index2++;
			} else {
				System.out.println("diferente");
				index1++;
				if ( index1-index2 > 1) 
					return false;

			}
		}
		//same except for the last one character
		return true;
	}

	private boolean searchForReplacement(String string1, String string2) {
		int changes = 0;
		for ( int i=0; i<string1.length(); i++) {
			System.out.println("str1: " + string1.charAt(i) + " str2: " + string2.charAt(i));
			if ( string1.charAt(i) != string2.charAt(i) ) 
				changes++; //No need to check more!!! we are assuming its only one change
		}
		if (changes>1) 
			return false;
		else
			return true;
		//return false;
	}

}
