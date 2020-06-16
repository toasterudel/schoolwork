/*
 * Stack.java
 * 
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 */


package Lab4;

import java.util.EmptyStackException;

/**
 * This program, Stack, has 2 constructors and 5 methods. 
 * .size() returns the size of the method. 
 * .push(int) adds a value onto the stack
 * .pop() returns the topmost value of the stack and removes it from the stack
 * .empty() returns whether the stack is empty or not
 * .peek() returns the topmost value of the stack without removing it
 * 
 * @author Christopher Rudel
 * @version 1.0
 * @since 20161004 
 */
public class Stack 
{
	protected static final String NAME = "Christopher Rudel"; 
	
	private int stack[];
	
	/**
	 * This constructor takes a given array and makes it a stack.
	 * @param enter  The array to be made a stack.
	 */
	public Stack(int[] enter)
	{
		stack = enter;
	}
	/**
	 * This constructor creates a new Stack with size 0.
	 */
	public Stack()
	{
		this(new int[0]);  //automatically sets the size of the array to 0. 
	}
	
	/**
	 * @return  The size of the Stack.
	 */
	public int size()
	{
		return stack.length;
	}
	
	/**
	 * This method takes a number and puts it on top of the stack.
	 * @param p  The number to be pushed on top of the stack.
	 */
	public void push(int p)
	{
		int[] newStack = new int[stack.length+1];
		newStack[0] = p;
		for(int i=1; i<newStack.length; i++)
			newStack[i] = stack[i-1];
		
		stack = newStack;
	}
	/**
	 * Takes the number from the top of the stack and removes it.
	 * @return the number from the top of the stack.
	 */
	public int pop()
	{
		if(stack.length==0)
			throw new EmptyStackException();
		
		int returnNum = stack[0];
		int[] newStack = new int[stack.length-1];
		for(int i=1; i<stack.length; i++)
			newStack[i-1] = stack[i];
		stack = newStack;
		return returnNum;
	}
	
	/**
	 * 
	 * @return  Whether or not the stack is empty.
	 */
	public boolean empty()
	{
		if(stack.length == 0)
			return true;
		else return false;
	}
	
	/**
	 * @return  The top number on the stack without removing it from the stack.
	 */
	public int peek()
	{
		return stack[0];
	}
	
	
}
