/*
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 * SelectionSort.java
 */

package Lab8;
import java.util.ArrayList;
/**
 * This is the SelectionSort class, using the selection sort to sort an array
 * 
 * @author Chris Rudel
 * @since 20161116
 * @version 1.0.0
 */
public class SelectionSort
{
	public static final String NAME = "CHRISTOPHER_RUDEL";
	public  int[] sort(int[] arr, String order)
	{
		int[] answer = null;
		if(order.equals("asc") || order.equals(null)) //Default for the order is ascending
		{
			answer = arr;
			for (int i=0; i<arr.length-1; i++)
	        {
	            int min = i;
	            for (int j= i+1; j<answer.length; j++)
	            {
	                if (answer[j] < answer[min])
	                    min = j;
	            }
	                
	            int smaller = answer[min]; 
	            answer[min] = answer[i];
	            answer[i] = smaller;
	        }
	        return answer;
		
		}
		else if(order.equals("desc") )  
		{
			answer = arr;
			for(int i = 0; i < answer.length-1; i++)
			{
				int max = i;
				for(int j = i+1; j<answer.length; j++)
				{
					if(answer[j] > answer[max])
						max = j;
				}
				int bigger = answer[max];
				answer[max] = answer[i];
				answer[i] = bigger;
				
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
