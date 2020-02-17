package cracking.stringsandarrays.urlfy;

public class URLfyString {
	/*
	 * Replace spaces with %20 the string has sufficient space to add and hold the 
	 * additional chars, and you are given the true length of string. In Java use char array
	 */
	public static void main (String...args) {
		URLfyString urlfy = new URLfyString();
		System.out.println(urlfy.urlFy("Mr Jhon Smith    "));
	}

	private String urlFy(String string) {
		
		System.out.println(string);
		//System.out.println("Total Size " + string.length());
		
		//Assuming no extra spaces
		char[] chars = string.toCharArray();
		int charPointerSize = string.length()-1;
		int charPointerLastChar = string.trim().length()-1; //points to the last
		
		char temp;
		for ( ; charPointerLastChar>=0; 
				charPointerSize--, 
				charPointerLastChar-- ) {
			temp = chars[charPointerLastChar];
			if ( temp == ' ' ) {
				chars[charPointerSize] = '0'; 
				chars[--charPointerSize] = '2';
				chars[--charPointerSize] = '%';
				
			} else {
				chars[charPointerSize] = temp;
				//System.out.println("Temp: " + temp);
				//System.out.println("Chars '" + new String(chars) + "'");		
			}
		}
		//System.out.println (chars.toString().length());
		return new String(chars);
	}
}

	