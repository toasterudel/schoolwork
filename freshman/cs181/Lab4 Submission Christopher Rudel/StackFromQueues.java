/*
 * StackFromQueues.java
 * 
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 */

package Lab4;

import java.util.EmptyStackException;

/**
 * This program, EmptyStackException has 2 constructors and 5 methods.
 * The first constructor is if the user knows how big they want the Stack to be
 * The second constructor automatically sets the stack size to 0 if the user does not know how big they want the stack to be
 * .size() returns how big the stack is
 * .push(int) adds a value to the stack
 * .pop() returns the value at the top of the stack and removes that value from the stack
 * .empty() returns whether or not the stack is empty
 * .peek() returns the value at the top of the stack without removing it from the stack
 * 
 * @author Christopher Rudel
 * @version 1.0
 * @since 20161004
 */
public class StackFromQueues 
{
	protected static final String NAME = "Christopher Rudel"; 
	
	private Queue qStack;
	
	/**
	 * Constructor. Takes the given array of integers and makes it a stack using queues. 
	 * @param input  The array to be made a stack.
	 */
	public StackFromQueues(int[] input)
	{
		qStack = new Queue(input);
	}
	public StackFromQueues()
	{
		this(new int[0]);
	}
	
	/**
	 * Gives the size of the stack
	 * @return  The size of the stack.
	 */
	public int size()
	{
		return qStack.size();
	}
	
	/**
	 * Takes the given input i and pushes it to the front of the stack (on the top). This is different from a queue as a queue
	 * would take the given input and put it at the end of the line.
	 * @param i  The number to be pushed on the stack.
	 */
	public void push(int i)
	{
		Queue newQStack = new Queue();
		newQStack.enqueue(i);
		int size = qStack.size();
		for(int p=0; p<size; p++)
		{
			int num = qStack.dequeue();
			newQStack.enqueue(num);
		}

		qStack = newQStack;
		
	}
	
	/**
	 * Returns the value at the top of the stack and removes it from the stack.
	 * @return  The top of the stack. 
	 */
	public int pop()
	{
		if(qStack.size()==0)
			throw new EmptyStackException(); 
		int answer = qStack.dequeue();
		return answer;
	}
	
	/**
	 * Tells whether or not the stack is empty.
	 * @return  If the stack is empty. 
	 */
	public boolean empty()
	{
		if(qStack.size()==0)
			return true;
		else return false;
	}
	
	/**
	 * Returns the value at the top of the stack without removing it from the stack. 
	 * @return  The value at the top of the stack. 
	 */
	public int peek()
	{
		return qStack.peek();
	}
	
	
}
