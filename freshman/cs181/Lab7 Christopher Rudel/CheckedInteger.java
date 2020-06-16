/*
 * CheckedInteger.java
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 */
package Lab7;

/**
 * This lab is to help our understanding of throwing exceptions in java. It takes all of the work we did in 
 * the Rational Lab and puts exceptions on the methods to make sure things work okay. 
 * 
 * @author Christopher Rudel
 * @version 1.0.0
 * @since 20161109
 */
public class CheckedInteger extends Number implements Comparable 
{
	public static final String NAME = "Christopher Rudel";
	protected int value; /**The value of the (Checked)Integer **/
	
	public CheckedInteger() //Automatically sets the value of the Integer to 0.
	{value = 0;}
	public CheckedInteger(int val) //Sets the Integer to the input
	{value = val;}
	public CheckedInteger(CheckedInteger val) //Sets the Integer to the value of the inputed Integer
	{value = val.value;}
	
	
	/**
	 * 
	 * @return The absolute value of the Integer
	 * @throws IntegerOverflowException if the absolute value function messed up
	 * @throws NullPointerException if this Object is null
	 */
	public CheckedInteger abs() throws IntegerOverflowException , NullPointerException
	{
		if(this.equals(null))
			throw new NullPointerException("Can't take the absolute value of a blank object!");
		CheckedInteger ans = null;
		if(this.value>=0)
			ans = new CheckedInteger(value);
		if(this.value<0)
			ans = new CheckedInteger(value*-1);
		if(Integer.signum(ans.value) <0)
			throw new IntegerOverflowException(this.value, false); //false with one variable = abs()
		return ans;
	}
	
	/**
	 * @return the value of the Integer in a String
	 * @throws NullPointerException if this Object is null
	 */
	public String toString() throws NullPointerException
	{
		if(this.equals(null))
			throw new NullPointerException("This is a blank object!");
		return Integer.toString(value);
	}
	
	/**
	 * 
	 * @param val The number to be added
	 * @return The sum of the this Object and the int
	 * @throws IntegerOverflowException If the sum is too big
	 * @throws NullPointerException If this Object is null
	 */
	public CheckedInteger add(int val) throws IntegerOverflowException , NullPointerException
	{
		if(this.equals(null))
			throw new NullPointerException("Please declare the Integer first, then try to add a value");
		CheckedInteger ans = new CheckedInteger(val+this.value);
		if(Integer.signum(val) != Integer.signum(ans.value) || ans.value > Integer.MAX_VALUE)
			throw new IntegerOverflowException(this.value , val, false); //false with 2 variables = add/sub
		return ans;
	}
	
	/**
	 * 
	 * @param val The Integer to be added
	 * @return The sum of the this Object and the inputed val
	 * @throws IntegerOverflowException If the sum is too big
	 * @throws NullPointerException If either Objects are null
	 */
	public CheckedInteger add(CheckedInteger val) throws IntegerOverflowException , NullPointerException
	{
		if(this.equals(null) || val.equals(null))
			throw new NullPointerException("Please make sure your objects are declared");
		CheckedInteger ans = new CheckedInteger(val.value + this.value);
		if(Integer.signum(val.value) != Integer.signum(ans.value))
			throw new IntegerOverflowException(this.value, val.value, false); //false with 2 variables = add/sub
		return ans;
	}
	
	/**
	 * 
	 * @return The opposite of this Object
	 * @throws IntegerOverflowException If negation messes up somehow
	 * @throws NullPointerException If this Object is null
	 */
	public CheckedInteger negate() throws IntegerOverflowException , NullPointerException
	{
		if(this.equals(null))
			throw new NullPointerException("Can't change the signs of a blank object");
		CheckedInteger ans = new CheckedInteger(this.value * -1);
		if(ans.value == 0)
			return ans;
		else if(Math.signum(this.value) == Math.signum(ans.value))
			throw new IntegerOverflowException(this.value, true); //true with one variable = negate()
		else return ans;
	}
	
	/**
	 * 
	 * @param val The int to be subtracted
	 * @return The difference of the Integer and inputed val
	 * @throws IntegerOverflowException If the answer is too small
	 * @throws NullPointerException If this Object is null
	 */
	public CheckedInteger sub(int val) throws IntegerOverflowException , NullPointerException
	{
		if(this.equals(null))
			throw new NullPointerException("Please declare the Object");
		CheckedInteger ans = new CheckedInteger(this.value-val);
		if(ans.value < Integer.MIN_VALUE)
			throw new IntegerOverflowException(this.value, val, false); //false with 2 variables = add/sub
		return ans;
	}
	
	/**
	 * 
	 * @param val The Integer to be subtracted
	 * @return The difference of this Object and val Object
	 * @throws IntegerOverflowException If the answer is too small
	 * @throws NullPointerException If either this Object or inputed Object is null
	 */
	public CheckedInteger sub(CheckedInteger val) throws IntegerOverflowException , NullPointerException
	{
		if(this.equals(null) || val.equals(null))
			throw new NullPointerException("Please make sure to declare your objects");
		CheckedInteger ans = new CheckedInteger(this.value-val.value);
		if(ans.value < Integer.MIN_VALUE)
			throw new IntegerOverflowException(this.value, val.value, false); //false with 2 variables = add/sub
		return ans;
	}
	
	/**
	 * 
	 * @param val The int to be multiplied
	 * @return The product of this Object and int val
	 * @throws IntegerOverflowException If this object is null
	 * @throws NullPointerException If answer is too big
	 */
	public CheckedInteger mul(int val) throws IntegerOverflowException , NullPointerException
	{
		if(this.equals(null))
			throw new NullPointerException("I can't multiply the given int by your null Object");
		CheckedInteger ans = new CheckedInteger(this.value*val);
		if (ans.value > Integer.MAX_VALUE)
			throw new IntegerOverflowException(this.value, val, true); //true with two variables = mul/div
		return ans;
	}
	
	/**
	 * 
	 * @param val The Integer to be Multiplied
	 * @return The product of the two Integers
	 * @throws IntegerOverflowException If the product is too large
	 * @throws NullPointerException If either Integers are null
	 */
	public CheckedInteger mul(CheckedInteger val) throws IntegerOverflowException , NullPointerException
	{
		if(this.equals(null))
			throw new NullPointerException("Make sure your Objects are declared!");
		CheckedInteger ans = new CheckedInteger(this.value * val.value);
		if (ans.value > Integer.MAX_VALUE)
			throw new IntegerOverflowException(this.value, val.value, true); //true with two variables = mul/div
		return ans;
	}
	
	/**
	 * 
	 * @param val the int to be divided
	 * @return The quotient of this Object and int val
	 * @throws IntegerOverflowException ¯\_(ツ)_/¯
	 * @throws NullPointerException If this Object is null
	 */
	public CheckedInteger div(int val) throws IntegerOverflowException , NullPointerException
	{
		if(val==0)
			throw new IllegalArgumentException("Dividing by zero is never allowed!");
		else if(this.equals(null))
			throw new NullPointerException("Please declare the Object before doing math. Please.");
		else
		{
			CheckedInteger ans = new CheckedInteger(this.value / val);
			return ans;
		}
	}
	
	/**
	 * 
	 * @param val the Integer to be divided
	 * @return the quotient of this Object and val Object
	 * @throws IntegerOverflowException ¯\_(ツ)_/¯
	 * @throws NullPointerException If either this Object or val Object is null
	 */
	public CheckedInteger div(CheckedInteger val) throws IntegerOverflowException , NullPointerException
	{
		if(val.value == 0)
			throw new IllegalArgumentException("Dividing by zero is never allowed!");
		else if(this.equals(null) || val.equals(null))
			throw new NullPointerException("Please make sure your Objects are declared.");
		else
		{
			CheckedInteger ans = new CheckedInteger(this.value / val.value);
			return ans;
		}
	}
	
	
	
	@Override
	public int compareTo(Object arg0) throws NullPointerException
	{
		if(this.equals(null) || arg0.equals(null))
			throw new NullPointerException("Make sure your Objects aren't null!");
		CheckedInteger theArg = (CheckedInteger)arg0;
		int ans = this.value - theArg.value;
		return ans;		
	} 

	@Override
	public double doubleValue() throws NullPointerException
	{
		if(this.equals(null))
			throw new NullPointerException("The Object is null!");
	return (double)value;
	}
	@Override
	public float floatValue() throws NullPointerException
	{
		if(this.equals(null))
			throw new NullPointerException("The Object is null!");
		return (float)value;
	}
	@Override
	public int intValue() throws NullPointerException
	{
		if(this.equals(null))
			throw new NullPointerException("The Object is null!");
		return (int)value;
	}
	@Override
	public long longValue() throws NullPointerException
	{
		if(this.equals(null))
			throw new NullPointerException("The Object is null!");
		return (long)value;
	}
}
