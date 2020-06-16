/*
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 * QuickSort.java
 */
package Lab8;

/**
 * This is the quicksort class, using the quicksort method to sort arrays
 * 
 * @author Chris Rudel
 * @since 20161116
 * @version 1.0.0
 */
public class Quicksort 
{
	
	public static final String NAME = "CHRISTOPHER_RUDEL";
	public int[] sort(int[] arr, String order)
	{
		if(arr.length ==0 || arr==null)
		{
			int[] ret = new int[0];
			return ret;
		}
		if(order.equals("asc") || order.equals(null)) //Default for the order is ascending
		{
			int low = 0;
			int high = arr.length-1;
			int middle = low + (high - low) / 2;
			int pivot = arr[middle];
	 
			// Making left less than pivot, right greater or equal to pivot
			int i = low, j = high;
			while (i <= j) 
			{
				while (arr[i] < pivot) 
					i++;
				
				while (arr[j] > pivot) 
					j--;
				
				if (i <= j) 
				{
					int temp = arr[i];
					arr[i] = arr[j];
					arr[j] = temp;
					i++;
					j--;
				}
			}
			// recursively sort
			if (low < j)
				sort(arr, "asc");
			if (high > i)
				sort(arr, "asc");
	        return arr;
		
		}
		else if(order.equals("desc") )  
		{
			int low = 0;
			int high = arr.length-1;
			int middle = low + (high - low) / 2;
			int pivot = arr[middle];
	 
			// Making left greater than pivot, right less or equal to pivot
			int i = low, j = high;
			while (i <= j) {
				while (arr[i] > pivot) 
					i++;
				
				while (arr[j] < pivot) 
					j--;
				
				if (i <= j) {
					int temp = arr[i];
					arr[i] = arr[j];
					arr[j] = temp;
					i++;
					j--;
				}
			}
	 
			// recursively sort
			if (low < j)
				sort(arr, "desc");
			if (high > i)
				sort(arr, "desc");
	        return arr;
		}
		else
		{
			int[] answer = new int[0];
			answer[0] = -1;
			return answer;  //Returns -1 if the given String is not "asc" or "desc" or null
		}
	}
	
	
}
