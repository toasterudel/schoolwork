/*
*	Author: Christopher Rudel
*/

import java.util.*;
import java.lang.Runnable;
public class PrimeFinder implements Runnable
{
	private Integer start;
	private Integer end;
	private List<Integer> primes;


	PrimeFinder(Integer sNum, Integer eNum)
	{
		this.start = sNum;
		this.end = eNum;
		this.primes = new ArrayList<>();
	}

	public List<Integer> getPrimesList()
	{
        return this.primes;
	}

    public Boolean isPrime(int n)
    {
        if(n <= 1) // 1 is not a prime
            return false;
        if(n == 2) // 2 is prime
            return true;
        for(int i=2; i<n; i++)
        {
            if(n % i == 0 && i != n)
                return false;
        }
        
        return true;
        
    }

	public void run()
	{
        for(int i = start; i<end; i++)
        {
            if(isPrime(i))
            {
                Integer x = Integer.valueOf(i);
                primes.add(x);
								//I mentioned this in the main file but primes.add(new Integer(i)); was giving me warnings
            }
        }
	}
}
