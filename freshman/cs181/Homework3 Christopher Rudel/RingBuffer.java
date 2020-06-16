/*
 * RingBuffer.java
 * I pledge my Honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 */
/*****************************************************************************
 *
 *  This is a template file for RingBuffer.java. It lists the constructors and
 *  methods you need, along with descriptions of what they're supposed to do.
 *  
 *  Note: it won't compile until you fill in the constructors and methods
 *        (or at least commment out the ones whose return type is non-void).
 *
 *****************************************************************************/

package Homework3;

/**
 * 
 * @editor Chris Rudel
 * @version 1.01
 * @since 20161127
 *
 */
public class RingBuffer {
	
	public static final String NAME = "CHRISTOPHER_RUDEL";
	
    private int first;            // index of first item in buffer
    private int last;             // index of last item in buffer
    private int size;             // current number of items of buffer
    private double[] buffer;

    // create an empty buffer, with given max capacity
    public RingBuffer(int capacity) 
    {
        buffer = new double[capacity];
        for(int i=0; i<buffer.length; i++)
        	buffer[i] = -1;			//a specific index is empty if value==-1, was having confusion with 0
        size = 0;
        last = 0;
    }

    // return number of items currently in the buffer
    public int getSize() {
        int answer = buffer.length;
        for(int i=0; i<buffer.length; i++)
        {
        	if(!hasValue(i)) //if it doesn't have a value
        		answer--;
        }
        return answer;
    }

    // is the buffer empty (size equals zero)?
    public boolean isEmpty() {
        boolean answer = true;
        for(int i=0; i<buffer.length; i++)
        {
        	if(hasValue(i))
        		answer = false;
        }
        return answer;
        
    }

    // is the buffer full (size equals array capacity)?
    public boolean isFull() {
    	boolean answer = true;
    	for(int i=0; i<buffer.length; i++)
    	{
    		if(!hasValue(i))
    			answer = false;
    	}
    	return answer;
    }
    //returns whether or not buffer is empty at the given index
    private boolean hasValue(int pos)
    {
    	Double q = buffer[pos];
    	if(q.equals(null) || q==-1)
    		return false;
    	else return true;
    }
    //just puts wraps the values back to 0 when they reach their limit
    private void checkAndWrap()
    {
    	if(first == buffer.length)
    		first = 0;
    	if(last == buffer.length)
    		last = 0;
    }

    // enqueues item x to the buffer
    public void enqueue(double x) 
    {
        if (isFull()) { throw new RuntimeException("Ring buffer overflow"); }
        checkAndWrap();
        buffer[last] = x;
        last++;
        size++;
        
        
    }

    // removes and returns the value from the front of the queue/buffer
    public double dequeue() {
        if (isEmpty()) { throw new RuntimeException("Ring buffer underflow"); }
        checkAndWrap();
        double answer = buffer[first];
        buffer[first] = -1;
        first++;
        size--;
        checkAndWrap();
        return answer;
    }

    // only returns the value from the front of the queue/buffer without removing it
    public double peek() {
        if (isEmpty()) { throw new RuntimeException("Ring buffer underflow"); }
        checkAndWrap();
        
        return buffer[first];
    }

    // a simple test of the constructor and methods in RingBuffer
    /*
    public static void main(String[] args) {
        int N = Integer.parseInt("10");
        RingBuffer buffer = new RingBuffer(N);
        System.out.println(buffer.isFull());
        for (int i = 1; i <= N; i++) {
            buffer.enqueue(i);
        }
		double t = buffer.dequeue();
		buffer.enqueue(t);
		System.out.println("Size after wrap-around is "  + buffer.getSize());
		System.out.println("helllo darkness");
			while (buffer.getSize() >= 2) {
            double x = buffer.dequeue();
            double y = buffer.dequeue();
            buffer.enqueue(x + y);
			}
		System.out.println(buffer.peek());
    }
    */
}







