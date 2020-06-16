/*
 * IntegerOverflowException.java
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 */
package Lab7;

/**
 * 
 * 
 * @author Christopher Rudel
 * @version 1.0.0
 * @since 20161109
 */
public class IntegerOverflowException extends Exception
{
	protected  int[] operands;
	protected  boolean operator;
	private String operate;
	
	public IntegerOverflowException(){}
	public IntegerOverflowException(int op, boolean b)
	{
		operands = new int[]{op};
		if(b==false)
			operate = "Absolute value";
		else operate = "Negation";
	}
	public IntegerOverflowException(int op1, int op2 , boolean b)
	{
		operands = new int[]{op1, op2};
		if(b== false)
			operate = "Addition/Subtraction";
		else operate = "Multiplication/Division";
	}
	public IntegerOverflowException(String message)
	{
		super(message);
	}

	
	public int[] getOperands()
	{
		return operands;
	}
	public String getOperator()
	{
		return operate;
	}
	
	public String getMessage()
	{
		String ans = "You tried to use " + this.getOperands() + " to do one of these: " + this.getOperator();
		return ans;
	}
}

