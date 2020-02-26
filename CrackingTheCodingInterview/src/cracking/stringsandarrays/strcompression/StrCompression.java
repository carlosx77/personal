package cracking.stringsandarrays.strcompression;

public class StrCompression {
	

	public static void main(String[] args) {
		StrCompression compression = new StrCompression();
		String compressed = compression.compress("aabcccccaaha");
		System.out.println(compressed);
	}

	private String compress(String string) {
		int size = string.length();
		char c;
		char previous = 0;
		int count = 0;
		boolean initial = true;
		StringBuffer compressed = new StringBuffer();
		for (int i=0; i<size; i++) {
			c = string.charAt(i);
			System.out.println("Char " + c + " previous " + previous + " comparison " + (previous != c));
			if ( previous != c && !initial ) { //we got a new letter, compress
				System.out.println("Different Letter");
				//System.out.println("Different previous: " + c + " actual: " + c );
				compressed.append(previous);
				compressed.append(count);
				previous=c;
				count = 1;
				//initial = false;
			} else { // we get same letter so compress
				System.out.println("New Letter");
				initial = false;
				previous = c;
				count++;
			}
		}
		compressed.append(previous);
		compressed.append(count);
		String result = compressed.toString();
		return result.length()<=string.length()?result:string;
	}

}
