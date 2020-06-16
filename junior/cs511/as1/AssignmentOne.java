/*
*		Author: Christopher Rudel
*/

import java.util.*;
public class AssignmentOne
{
    private static List<Integer> finalNums;
	public static void main(String[] args)
	{
        List<Integer[]> nums = new ArrayList<>();
        finalNums = new ArrayList<>();
        List<Integer> results;
		//According to assignment the array is passed thru command line args
		if(args.length <= 1)
		{
			System.out.println("Please put in more than one command line argument");
			java.lang.System.exit(1);
		}
        
		for(int i=0; i< args.length-1; i++)
		{
			Integer[] n = new Integer[]{Integer.parseInt(args[i]), Integer.parseInt(args[i+1])};
			nums.add(n);
		}
        results = lprimes(nums);
        if(results == null)
        {
            System.out.println("Please make sure your arguments are greater than or equal to two and increasing");
            java.lang.System.exit(1);
        }
        printing();

	}

	public static List<Integer> lprimes(List<Integer[]> intervals)
	{
        if(!check(intervals))
            return null;
        for(int i=0; i<intervals.size(); i++)
        {
            PrimeFinder pf = new PrimeFinder(intervals.get(i)[0], intervals.get(i)[1]);
            Thread t = new Thread(pf);
            t.start();
            
            try{
                t.join();
            }catch (InterruptedException e){
                e.printStackTrace();
            }
            List<Integer> pfList = pf.getPrimesList();
            for(int j=0; j<pfList.size(); j++)
            {
                Integer x = Integer.valueOf(pfList.get(j));
                finalNums.add(x);
                //having code that says "finalNums.add(new Integer(pfList.get(j)))" gave me warnings
            }
						
        }
        return finalNums;
	}
    
    private static boolean check(List<Integer[]> n) //all this does is validate arguments
    {
        int inc = n.get(0)[0];
        for(int i=0; i<n.size(); i++)
        {
            if(n.get(i).length != 2)
                return false;
            for(int j=0; j<n.get(i).length; j++)
            {
                if(n.get(i)[j] < inc)
                    return false;
                else if(n.get(i)[j] < 2)
                    return false;
                else
                    inc = n.get(i)[j];
            }
        }
        //if the program makes it this far the list is good
        return true;
    }
    
    private static void printing() //all this does is print the results
    {
         System.out.print("[");
        for(int i=0; i<finalNums.size()-1; i++)
            System.out.print(finalNums.get(i) + ",");
        System.out.println(finalNums.get(finalNums.size()-1) + "]");
    }
    
}
