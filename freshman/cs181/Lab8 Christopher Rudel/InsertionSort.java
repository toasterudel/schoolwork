/*
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 * InsertionSort.java
 */
package Lab8;

/**
 * This is the InsertionSort class, using the insertion method to sort arrays
 * 
 * @author Chris Rudel
 * @since 20161116
 * @version 1.0.0
 */
public class InsertionSort 
{
	public static final String NAME = "CHRISTOPHER_RUDEL";
	public int[] sort(int[] arr, String order)
	{
		int[] answer = null;
		if(order.equals("asc") || order.equals(null))
		{
			answer = arr;
			int substitute; 
			for (int i=1; i<answer.length; i++) 
			{
	            for(int j=i ; j>0 ; j--)
	            {
	                if(arr[j] < arr[j-1]) //This is the swap
	                {
	                    substitute = arr[j];
	                    arr[j] = arr[j-1];
	                    arr[j-1] = substitute;
	                }
	            }
	        }			
			return answer;
		}
		else if(order.equals("desc"))
		{
			answer = arr;
			int substitute; 
			for (int i=1; i<answer.length; i++) 
			{
	            for(int j=i ; j>0 ; j--)
	            {
	                if(arr[j] > arr[j-1]) //This is the swap
	                {
	                    substitute = arr[j];
	                    arr[j] = arr[j-1];
	                    arr[j-1] = substitute;
	                }
	            }
	        }		
			return answer;
		}
		else
		{
			answer = new int[0];
			answer[0] = -1;
			return answer;  //Returns -1 if the given String is not "asc" or "desc" or null
		}
		
	}
	
	
	
}
