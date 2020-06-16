/*
 * Queue.java
 * 
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 */

package Lab4;

import java.util.EmptyStackException;

/**
 * This program Queue has 2 constructors and 5 methods
 * .size() returns the size of the queue
 * .enqueue(int) adds a value to the end of the queue
 * .dequeue() returns the firstmost value of the queue and removes it from the queue
 * .empty() returns whether the queue is empty
 * .peek() returns the firstmost value of the queue without removing it
 * 
 * @author Christopher Rudel
 * @version 1.0
 * @since 20161004
 */
public class Queue 
{
	protected static final String NAME = "Christopher Rudel"; 
	
	private int[] queue;
	
	/**
	 * Constructor
	 * @param input  Takes the given array of numbers and makes it a queue.
	 */
	public Queue(int[] input)
	{
		queue = input;
	}
	/**
	 * Constructor. Creates a queue of size 0 since the size of the queue was not specified. 
	 */
	public Queue()
	{
		this(new int[0]); //automatically sets the size of the queue to 0
	}
	
	/**
	 * @return  The size of the queue.
	 */
	public int size()
	{
		return queue.length;
	}
	
	/**
	 * Adds a number to the end of the queue.
	 * @param num  The number to be added to the queue.
	 */
	public void enqueue(int num)
	{
		int[] newQueue = new int[queue.length+1];
		newQueue[queue.length] = num;
		for(int i=0; i<queue.length; i++) //fills the newQueue with the old queue up until the enqueued number
			newQueue[i]=queue[i];
		
		queue = newQueue;
	}
	
	/**
	 * Takes the number first in the queue, returns it and removes it from the queue.
	 * @return  the first number in the queue.
	 */
	public int dequeue()
	{
		if(queue.length == 0)
			throw new EmptyStackException();
			
		int numReturn = queue[0];
		int[] newQueue = new int[queue.length-1];
		for(int i=1; i<queue.length; i++) //fills the newQueue with old queue without first number
			newQueue[i-1]=queue[i];
	
		queue = newQueue;
		
		return numReturn;
	}
	
	/**
	 * @return  Whether or not the queue is empty. 
	 */
	public boolean empty()
	{
		if(queue.length == 0)
			return true;
		else return false;
	}
	
	/**
	 * Returns the first number in the queue without removing it from the queue. 
	 * @return  The first number in the queue.
	 */
	public int peek()
	{
		return queue[0];
	}
	
}
