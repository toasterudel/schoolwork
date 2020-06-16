/*
 * BoggleWords.java
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 */
//package Lab9;

import java.io.*;
import java.util.ArrayList;

/**
 * The purpose of this class is only to give it a string of random letters and it returns
 * all possible combinations of the string that make a word. 
 * 
 * @author Christopher Rudel
 * @since 20161123
 * @version 1.0.0
 */
public class BoggleWords 
{
	public static final String NAME = "CHRISTOPHER_RUDEL";
	
	private static ArrayList<String> dict = new ArrayList<String>();	//The entire dictonary
	private static ArrayList<String> boggleWords = new ArrayList<String>();		//The words from the given string
	
	/**
	 * Finds all the possible words in the given string
	 * 
	 * @param initial - the given string
	 * @param subString - was not able to use recursion and was late due to traveling so I didn't use it
	 */
	public static void findWords(String initial, String subString)
	{
		//////////////////////Adding all dictionary words to ArrayList<String> dict///////////////////////////
		BufferedReader br = null;
		try {
			String currentLine;
			br = new BufferedReader(new InputStreamReader(BoggleWords.class.getResourceAsStream("dict.txt")));
			while ((currentLine = br.readLine()) != null)
			{
				dict.add(currentLine.toString());
			}
		} catch (IOException e) 
		{
			System.out.println(e.getMessage());
		} finally 
		{
			try 
			{
				if (br != null)br.close();
			} catch (IOException f) 
			{
				System.out.println(f.getMessage());
			}
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////
		initial = initial.toLowerCase();	//All the words in dict.txt are lowercase, so the string has to as well
		for(String input : dict)
			{
	            //If its a match
	            boolean noMatch = true;
	            // for each character of the current dictionary word
	            for( char inputArray : input.toCharArray()) 
	            {
	                String inputChar = Character.toString(inputArray);
	                // if the count of inputArray in word is equal to its count in input, then they are match
	                if (input.length()-input.replace(inputChar, "").length() != initial.length()-initial.replace(inputChar, "").length())
	                {
	                    noMatch = false;
	                    break;
	                }
	            }
	            if (noMatch) 
	               boggleWords.add(input);
			}
     }
	
	
	public static ArrayList<String> getBoggleWords()
	{return boggleWords;}

	//		MAIN METHOD
	public static void main(String[] args)
	{
		
		String test = "MTENLFEIOEREOHWR";
		System.out.println(test);
		findWords(test, null);
		System.out.println(boggleWords.size());
		System.out.println(getBoggleWords());
		
	
	}
	
	
	
	
}
