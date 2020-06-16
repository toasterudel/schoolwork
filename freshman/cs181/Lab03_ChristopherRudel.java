/*
 * Lab03_ChristopherRudel.java
 *
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 *
 */

package Lab3; 

/**
 * This program, Lab03, has 3 methods. 
 * The first method, binaryPeriodic, takes a given periodic number in binary and converts it to decimal.
 * The second method, longestSubstring, takes two given substrings and produces the longest common substring with both strings forward,
 * 		the first string backwards, the second string backwards and both strings backwards.
 * The third method, threeNPlusOne, takes the given int and either multiplies it by three and adds one if its odd, or divides by two 
 * 		if it's even. 
 *
 * @author Christopher Rudel
 * @version 1.0
 * @since 20160920
 * 
 */
public class Lab03_ChristopherRudel{
    
    public static final String NAME = "Christopher Rudel"; 

    /**
     * Given a binary periodic string, return an double value
     * Accepts any input ("._" should return 0)
     * 
     * @param s  the binary string, in the format of D.A_P
     * @return   the String  value of the binary string, in the form of 
     *           INTEGER_VALUE + numerator/denominator
     */
    public static String binaryPeriodic(String s)
    {
    	String answer = "";
    	String beforeDecimal = s.substring(0,s.indexOf("."));
    	answer += binaryToInt(beforeDecimal);  //the method binarytoInt is written later in the code
    	answer += " + ";
    	
    	String a = s.substring(s.indexOf(".") + 1, s.indexOf("_"));
    	String p = s.substring(s.indexOf("_") + 1);
    	
    	int powerOfTwo = p.length();
    	double u = Integer.parseInt(binaryToInt(a));
    	double x = Integer.parseInt(binaryToInt(p));
    	x = (x / ( Math.pow(2, powerOfTwo) -1 )  );
    	
    	
    	double y = ( (x + u) / Math.pow(2, a.length() )   );
    	
    	answer += y;
    	
    	
	return answer;
    }
    
   /**
    * Given a string, find the longest substring forwards and backwards
    * More details in lab description
    * Accepts any input (including empty strings)
    *
    * @param s1  String 1 to be processed
    * @param s2  String 2 to be processed
    * @return    a SPACE deliminated string with 4 values:
    *            longest substring when both strings forward,
    *            longest substring s1 backward, longest substring s2 backward
    *            longest substring both backward.
    *            Example return is "car car rac rac"
    */
    public static String longestSubstring(String s1, String s2)
    {
   
    	String s1Forwards = s1.toLowerCase();
    	String s2Forwards = s2.toLowerCase();
    	String s1Backwards = reverseString(s1.toLowerCase());
    	String s2Backwards = reverseString(s2.toLowerCase());
    	String answer = "";
    	
    	int[][] compareForwards = new int[s1.length()][s2.length()];
    	int longestForwards = 0;
    	int lastStringBothForwards = 0;
    	
    	String longestBothForwards = "";
    	for(int i=0; i<s1.length(); i++)				//Both Strings Forward
    	{
    	for(int k=0; k<s2.length(); k++)
    		{
    		if(s1Forwards.charAt(i) == s2Forwards.charAt(k))
	    		{
	    			if(i==0 || k ==0)
	    				compareForwards[i][k] = 1;
	    			else 
	    				compareForwards[i][k] = 1 + compareForwards[i-1][k-1];
	    			
	    			if(compareForwards[i][k] > longestForwards)
	    			{
	    				longestForwards = compareForwards[i][k];
	    				int beginString = i-compareForwards[i][k] + 1;
	    				if(lastStringBothForwards == beginString)
	    				{
	    					longestBothForwards += s1Forwards.charAt(i);
	    				}else		//clears the string if a longer one is found
	    					{
	    						lastStringBothForwards = beginString;
	    						longestBothForwards = "";
	    						longestBothForwards += s1Forwards.substring(lastStringBothForwards, i+1);
	    					}
	    			}
	    		}
    		}
    	
    	
    	}
    	
    	int[][] compareS1Backwards = new int[s1.length()][s2.length()];
    	String longestS1Backwards = "";
    	int longestS1Back = 0;
    	int lastStringS1Backwards = 0;
    	
    	for(int i=0; i<s1.length(); i++)						//String s1 Backwards
    	{
    	for(int k=0; k<s2.length(); k++)
    		{
    		if(s1Backwards.charAt(i) == s2Forwards.charAt(k))
	    		{
	    			if(i==0 || k ==0)
	    				compareS1Backwards[i][k] = 1;
	    			else 
	    				compareS1Backwards[i][k] = 1 + compareS1Backwards[i-1][k-1];
	    			
	    			if(compareS1Backwards[i][k] > longestS1Back)
	    			{
	    				longestS1Back = compareS1Backwards[i][k];
	    				int beginString = i-compareS1Backwards[i][k] + 1;
	    				if(lastStringS1Backwards == beginString)
	    				{
	    					longestS1Backwards += s1Backwards.charAt(i);
	    				}else		//clears the string if a longer one is found
	    					{
	    						lastStringS1Backwards = beginString;
	    						longestS1Backwards = "";
	    						longestS1Backwards += s1Backwards.substring(lastStringS1Backwards, i+1);
	    					}
	    			}
	    		}
    		}
    	
    	
    	}
    	
    	int[][] compareS2Backwards = new int[s1.length()][s2.length()];
    	String longestS2Backwards = "";
    	int longestS2Back = 0;
    	int lastStringS2Backwards = 0;
    	
    	for(int i=0; i<s1.length(); i++)				//String s2 Backwards
    	{
    	for(int k=0; k<s2.length(); k++)
    		{
    		if(s1Forwards.charAt(i) == s2Backwards.charAt(k))
	    		{
	    			if(i==0 || k ==0)
	    				compareS2Backwards[i][k] = 1;
	    			else 
	    				compareS2Backwards[i][k] = 1 + compareS2Backwards[i-1][k-1];
	    			
	    			if(compareS2Backwards[i][k] > longestS2Back)
	    			{
	    				longestS2Back = compareS2Backwards[i][k];
	    				int beginString = i-compareS2Backwards[i][k] + 1;
	    				if(lastStringS2Backwards == beginString)
	    				{
	    					longestS2Backwards += s1Forwards.charAt(i);
	    				}else		//clears the string if a longer one is found
	    					{
	    						lastStringS2Backwards = beginString;
	    						longestS2Backwards = "";
	    						longestS2Backwards += s1Forwards.substring(lastStringS1Backwards, i+1);
	    					}
	    			}
	    		}
    		}
    	}
    	
    	int[][] compareBothBackwards = new int[s1.length()][s2.length()];
    	String longestBothBackwards = "";
    	int longestBothBack = 0;
    	int lastStringBothBackwards = 0;
    	
    	for(int i1=0; i1<s1.length(); i1++)						//Both Strings Backwards
    	{
    	for(int k=0; k<s2.length(); k++)
    		{
    		if(s1Backwards.charAt(i1) == s2Backwards.charAt(k))
	    		{
	    			if(i1==0 || k ==0)
	    				compareBothBackwards[i1][k] = 1;
	    			else 
	    				compareBothBackwards[i1][k] = 1 + compareBothBackwards[i1-1][k-1];
	    			
	    			if(compareBothBackwards[i1][k] > longestBothBack)
	    			{
	    				longestBothBack = compareBothBackwards[i1][k];
	    				int beginString = i1-compareBothBackwards[i1][k] + 1;
	    				if(lastStringBothBackwards == beginString)
	    				{
	    					longestBothBackwards += s1Backwards.charAt(i1);
	    				}else		//clears the string if a longer one is found
	    					{
	    						lastStringBothBackwards = beginString;
	    						longestBothBackwards = "";
	    						longestBothBackwards += s1Backwards.substring(lastStringS1Backwards, i1+1);
	    					}
	    			}
	    		}
    		}
    	
    	
    	}
    	
    	answer += longestBothForwards + " " + longestS1Backwards + " " + longestS2Backwards + " " + longestBothBackwards;
    	return answer; 
    	}
    

   /**
    * Computes the intermediate steps of the 3n+1 conjecture
    * 
    * @requires n to be a positive, non-zero integer 
    *      ^^The requires flag tells you what input conditions
    *        your method requires. So this flag means your method
    *        does not need to handle negative nums or 0. Yay!
    *
    * @param  n  the number to be processed
    * @return    the string of intermediate steps, separated by SPACES. 
    *            The last character of the string, based on the conjecture
    *            should always be a 1
    */
    public static String threeNPlusOne(int n)
    {
    	String answer = "";
    	while(n!=1)
    	{
    		if(n % 2 == 1) //testing to see if odd
    			n = (3*n) + 1;
    		
    		else if(n % 2 == 0) //testing if even
    			n = n/2;
    		
    		answer += n + " ";
    	}
	return answer;
    }
    
    /**
     * Takes the given binary number and returns the number in decimal format
     * 
     * @requires n to be a whole binary number.
     * 
     * @param n	  the binary number to be translated
     * @return    the string of the number in decimal.
     */
    private static String binaryToInt(String n)
    {
    	int answerNum = 0;
    	String answer = "";
    	
    	for(int i = 0; i < n.length(); i++)
    	{
    		if(n.charAt(i) == '1')
    			answerNum += Math.pow(2, n.length()-1-i);
    	}
    	
    	answer += Integer.toString(answerNum); 
    	return answer;
    }

    /**
     * Reverses the provided String
     * 
     * @param r the String to be reversed
     * @return	r in reverse
     */
    private static String reverseString(String r)
    {
    	String answer = "";
    	for(int i = r.length()-1; i>=0; i--)
    	{
    		answer += r.charAt(i);
    	}
    	return answer;
    }
    
    
    /*
     *												Main Method Below 
     *
    
    public static void main(String[] args){

    	if(args[0].equals("1"))
    	{
    		System.out.println(binaryPeriodic(args[1]));
    	}
    	
    	if(args[0].equals("2"))
    	{
    		System.out.println(longestSubstring(args[1] , args[2]));
    	}
    	
    	if(args[0].equals("3"))
    	{
    		System.out.println(threeNPlusOne(Integer.parseInt(args[1])));
    	}
    	
	
    }
*/    
}
