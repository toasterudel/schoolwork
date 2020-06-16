/*
 * Rational.java
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 */


package Lab6;

/**
 * The rational class is any rational number. It has 3 constructors, one with 2 inputs, one with 1
 * input, and one with no input(default). The default constructor automatically sets the value of the 
 * rational number to 0. 
 * reduceTerms() is a private method that takes the numerator and denominator of the rational number and makes
 * it the smallest number or equivalent fraction it can
 * computeGCD() computes the greatest common divisor of the numerator and denominator
 * computeLCM() computes the least common multiple of the numerator and denominator
 * mul(long) takes the given long and multiplies it by the rational number
 * div(long) takes the given long and divides it by the rational number
 * getInv() computes the inverse of the rational number
 * add() takes the given rational and computes the sum of the given and this rational
 * sub() takes the given rational and computes the difference of the given and this rational
 * mul(Rational) takes the given rational and multiplies this rational by it
 * div(Rational) takes the given rational and divides this by it
 * compareTo() takes the given Object(Rational) and computes this - given
 * double, float, int, and longValue() all return the value of the Rational in their respective types
 * 
 * @author Christopher Rudel
 * @version 1.0.0
 * @since 20161025
 */
public class Rational extends Number implements Comparable
{
	public static final String NAME = "Christopher Rudel";
	private long numerator;
	private long denominator;
	
	public Rational(long num, long denom)
	{
		numerator = num;
		denominator = denom;
	}
	public Rational(long num)
	{
		this(num, 1);
	}
	public Rational()
	{
		this(0);
	}

	public long getNumerator() //I am assuming documentation is not needed for getter methods.
	{return numerator;}
	public long getDenominator()
	{return denominator;}
	
	public String toString()
	{
		String answer = Long.toString(numerator) + "/" + Long.toString(denominator);
		return answer;
	}
	
	/**
	 * Reduces the Rational to its simplest terms
	 */
	private void reduceTerms()
	{
		long GCF = computeGCD(numerator, denominator);
		numerator /= GCF;
		denominator /= GCF;
	}
	/**
	 * 
	 * @param x a number
	 * @param y a number
	 * @return the greatest common divisor of x and y
	 */
	private long computeGCD(long x, long y)
	{	
		long gcf = 1;
		if(x<y)
			gcf = computeGCD(y,x);
		else{
			while(y>0){
			long oldY = y;
			y = x % y;
			x = oldY;
			gcf = x;
		
		}
		
	}
		return gcf;
		
		
	}
	/**
	 * 
	 * @param x a number
	 * @param y a number
	 * @return the least common multiple of x and y
	 */
	private long computeLCM(long x, long y)
	{
		long gcf = computeGCD(x,y);
		long multiplierX = y/gcf;
		long multiplierY = x/gcf;
		if(x*multiplierX == y*multiplierY)
			return x*multiplierX;
			else return x*y;
	}
	/**
	 * 
	 * @param multiplier The number to have the Rational be multiplied by
	 * @return The rational multiplied by the multiplier
	 */
	public Rational mul(long multiplier)
	{
		long newNumerator = multiplier*numerator;
		long newDenominator = denominator;
		Rational answer = new Rational(newNumerator, newDenominator);
		answer.reduceTerms();
		return answer;
	}
	/**
	 * 
	 * @param divider The number to have the Rational be divided by
	 * @return The rational divided by the divider
	 */
	public Rational div(long divider)
	{
		long newNumerator = numerator;
		long newDenominator = divider*denominator;
		Rational answer = new Rational(newNumerator, newDenominator);
		answer.reduceTerms();
		return answer;
	}
	/**
	 * Gives the inverse of the Rational number
	 * @return	The inverse of the rational number
	 */
	public Rational getInv()
	{
		try{
		Rational inverse = new Rational(denominator, numerator);
		inverse.reduceTerms();
		return inverse;
		}catch(ArithmeticException e){
			return null;}
	}
	/**
	 * Takes a rational number and adds it to the current rational number
	 * @param adder the number to be added
	 * @return Takes the given rational number and adds it to this Rational number
	 */
	public Rational add(Rational adder)
	{
		long thisNumerator = numerator;
		long thisDenominator = denominator;
		long adderNumerator = adder.getNumerator();
		long adderDenominator = adder.getDenominator();
		Rational answer;
		if(adder.getNumerator()==0 || adder.getDenominator()==0)
			return this;
		else if(thisDenominator == adderDenominator)
		{
			thisNumerator += adderNumerator;
			answer = new Rational(thisNumerator, thisDenominator);
			answer.reduceTerms();
			return answer;
		}
		else
		{
			long denomLCM = computeLCM(thisDenominator, adder.getDenominator());
			long thisMult = denomLCM / thisDenominator;
			long adderMult = denomLCM / adder.getDenominator();
			thisNumerator *= thisMult; 
			adderNumerator *= adderMult;
			long finalNumerator = thisNumerator + adderNumerator;
			
			answer = new Rational(finalNumerator, denomLCM);
			answer.reduceTerms();
			return answer;
			
		}
	}
	/**
	 * Takes the given rational and subtracts it from this rational
	 * @param subtracter the rational to be subtracted
	 * @return This - subtracter
	 */
	public Rational sub(Rational subtracter)
	{
		long thisNumerator = numerator;
		long thisDenominator = denominator;
		long subNumerator = subtracter.getNumerator();
		long subDenominator = subtracter.getDenominator();
		Rational answer;
		if(subtracter.getNumerator()==0 || subtracter.getDenominator()==0)
			return this;
		else if(thisDenominator == subDenominator)
		{
			thisNumerator -= subNumerator;
			answer = new Rational(thisNumerator, thisDenominator);
			answer.reduceTerms();
			return answer;
		}
		else
		{
			long denomLCM = computeLCM(thisDenominator, subDenominator);
			long thisMult = denomLCM / thisDenominator;
			long subMult = denomLCM / subDenominator;
			thisNumerator *= thisMult; 
			subNumerator *= subMult;
			long finalNumerator = thisNumerator - subNumerator;
			
			answer = new Rational(finalNumerator, denomLCM);
			answer.reduceTerms();
			return answer;
			
		}
	}
	/**
	 * Multiplies this rational by the given rational
	 * @param num the given rational
	 * @return the product of the two rationals
	 */
	public Rational mul(Rational num)
	{
		try{
		long newNumerator = numerator * num.getNumerator();
		long newDenominator = denominator *  num.getDenominator();
		Rational answer = new Rational(newNumerator, newDenominator);
		answer.reduceTerms();
		return answer;
		}catch(ArithmeticException e){
			return new Rational(0);	}
	}
	/**
	 * Returns the quotient of this Rational and the given rational
	 * @param num the given rational
	 * @return the quotient of this / given
	 */
	public Rational div(Rational num)
	{
		//Dividing by a fraction = multiplying by the inverse
		try{
		long newNumerator = numerator * num.getDenominator();
		long newDenominator = denominator * num.getNumerator();
		Rational answer = new Rational(newNumerator, newDenominator);
		answer.reduceTerms();
		if (newDenominator == 0 )
			return null;
		return answer;
		}catch(ArithmeticException e){
			return null;	}
	}

	@Override
	/**
	 * @param arg0 the object to be compared
	 * @return the difference of the Rational and the object in int
	 */
	public int compareTo(Object arg0) 
	{
		int answer = 0;
		int thisRat = this.intValue();
		Rational arg = (Rational)arg0;
		int otherRat = arg.intValue();
		answer = thisRat - otherRat;
		return answer;
	}

	@Override
	public double doubleValue() {
		// TODO Auto-generated method stub
		try{
		double num = (double)numerator;
		double denom = (double)denominator;
		return num/denom;
		}catch(ArithmeticException e){
			return -1;	}
	}

	@Override
	public float floatValue() {
		try{
		float num = (float)numerator; 
		float denom = (float)denominator;
		return num/denom;
		}catch(ArithmeticException e){
			return -1;	}
		}
	

	@Override
	public int intValue() {
		try{
		int num = (int)numerator;
		int denom = (int)denominator;
		return num/denom;
		}catch(ArithmeticException e){
			return -1;		}
	}

	@Override
	public long longValue() {
		// TODO Auto-generated method stub
		try{
		return numerator/denominator;
		}catch(ArithmeticException e){
			return -1;		}
	}
		
	
}
