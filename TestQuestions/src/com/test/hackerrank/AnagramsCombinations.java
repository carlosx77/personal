package com.test.hackerrank;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class AnagramsCombinations {
	public static List<Long> countSentences (List<String> wordset, List<String> sentences) {
		
		HashMap<String, Integer> anagramsMap = checkAnagrams (wordset);
		List<Long> result = new ArrayList<>();
		
		List<String> words;
		Long count = 1l;
		char[] charWord;
		for ( String sentence: sentences ) {
			words = getStringsList (sentence);
			count = 1l;
			for ( String word : words ) {
				charWord = word.toCharArray();
				Arrays.sort(charWord);
				count = count * anagramsMap.get(new String(charWord));
			}
			result.add(count);
			System.out.println ("Resultado: " + count);
		}
		return result;
	}
	
	private static List<String> getStringsList(String str) {
		String[] words = str.split(" ");
		List<String> result = new ArrayList<String>();
		for (String word : words) {
			result.add(word.toLowerCase());
		}
		return result;
	}

	private static HashMap<String, Integer> checkAnagrams(List<String> wordset) {
		HashMap<String, Integer> map = new HashMap<>();
		char[] chars;// = s.toCharArray();
		//Arrays.sort(chars);\
		String ordered;
		Integer count;
		for ( String str:wordset ) {
			str = str.toLowerCase();
			chars = str.toCharArray();
			Arrays.sort(chars);
			ordered = new String (chars);
			count = map.get(ordered);
			//System.out.println ("Ordered: " + ordered);
			if ( count == null ) {
				map.put(ordered, 1);
			} else {
				map.put (ordered, count+1);
			}
		}
		return map;
	}

	public static void main (String...args) {
		List<String> wordset = new ArrayList<>();
		wordset.add("The");
		wordset.add("bats");
		wordset.add("tabs");
		wordset.add("in");
		wordset.add("cat");
		wordset.add("act");
		List<String> sentences = new ArrayList<>();
		sentences.add("cat the bats");
		sentences.add("in the act");
		sentences.add("act tabs in");
		AnagramsCombinations.countSentences(wordset, sentences);
	}
	

}
class OrderedVersions {
	String ordered;
	String noOrdered;
	
	public OrderedVersions (String ordered, String noOrdered) {
		this.ordered = ordered;
		this.noOrdered = noOrdered;
	}
	
	public String getOrdered() {
		return ordered;
	}
	
	public void setOrdered(String ordered) {
		this.ordered = ordered;
	}
	
	public String getNoOrdered() {
		return noOrdered;
	}
	
	public void setNoOrdered(String noOrdered) {
		this.noOrdered = noOrdered;
	}
}


class Anagrams {
	private String orderedAnagram;
	private List<String> validAnagrams = new ArrayList<>();
	
	public String getOrderedAnagram () {
		return this.orderedAnagram;
	}
	
	public String getValidAnagrams () {
		return this.getValidAnagrams();
	}
	
	public boolean isValidAnagram (String str) {
		return validAnagrams.stream().anyMatch(a->str.compareTo(a)==0);
	}
	
	public void setOrderedAnagram (String str) {
		this.orderedAnagram = str;
	}
	public void addValidAnagram (String str) {
		validAnagrams.add(str);
	}
}
