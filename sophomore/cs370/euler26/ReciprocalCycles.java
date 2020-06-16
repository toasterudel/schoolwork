/*
*
*   Meng Qui, Kaitlynn Prescott, Christopher Rudel
*   ReciprocalCycles.java
*   We pledge our honor that we have abided by the Stevens Honor System
*
*/

import java.math.BigDecimal;

class ReciprocalCycles {
	public static void main(String[] args) {
		if (args.length != 1) {
			// incorrect number of parameters
			System.out.println("Usage: denominator");
		}
		// save denominator as integer
		int denominator = Integer.parseInt(args[0]);
		if (denominator < 1 || denominator > 2000) {
			// denominator out of range
			System.out.println("Error: Denominator must be an integer in [1,2000]. Recieved '" + denominator + "'.");
			System.exit(1);
		}
		if (isRecurring(1, denominator)) {
		// there is a recurring cycle
			int[] soln = findCycle(1, denominator);
			System.out.println("1/" + args[0] + " = 0.(" + soln[1] + "), cycle length " + soln[0]);
		} else {
			// no recurring cycle
			double soln;
			soln = (double)1/denominator;
			System.out.println("1/" + args[0] + " = " + soln);
		}
	}

	static boolean isRecurring(int numerator, int denominator) {
		// checks if a division results in a recurring number
		BigDecimal n = new BigDecimal(numerator);
    	n.setScale(2 * denominator + 1);
    	BigDecimal d = new BigDecimal(denominator);
    	try {
       		n.divide(d);
       		// not recurring
        	return false;
    	} catch (ArithmeticException ae) {
    		// recurring
        	return true;
    	}
	}

	public static int[] findCycle(int n, int d) {
		// finds the cycle, and the length of the cycle
		int[] soln = new int[2];
		int x = n*9;
		int z = x;
		int i = 1;
		// while d does not divide evenly into z
		while ((z % d) != 0) {
			// go to next decimal place
			z = z*10 + x;
			// increment the length
			i++;
		}
		soln[0] = i;
		soln[1] = z/d;
		return soln;
	}

}
