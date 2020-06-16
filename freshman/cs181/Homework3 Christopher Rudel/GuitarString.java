/*
 * GuitarString.java
 * I pledge my Honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 */
/*****************************************************************************
 *
 *  This is a template file for GuitarString.java. 
 *  It lists the constructors and methods you need, along with descriptions
 *  of what they're supposed to do. 
 *  
 *  Note: it won't compile until you fill in the constructors and methods
 *        (or at least commment out the ones whose return type is non-void).
 *
 *****************************************************************************/
package Homework3;


/**
 * A filled out version of the file provided on canvas
 * 
 * @editor Christopher Rudel
 * @since 20161128
 * @version 1.01
 *
 */
public class GuitarString {

	public static final String NAME = "CHRISTOPHER_RUDEL";
    private RingBuffer buffer; // ring buffer
    private int tics = 0; //number of times tic() has been called
    // YOUR OTHER INSTANCE VARIABLES HERE

    // create a guitar string of the given frequency
    public GuitarString(double frequency) 
    {
        int capacity = (int) Math.ceil(44100/frequency);
        buffer = new RingBuffer(capacity);
        for(int i=0; i<capacity; i++)
        	buffer.enqueue(0);
    }
    // create a guitar string whose size and initial values are given by the array
    public GuitarString(double[] init) 
    {
       buffer = new RingBuffer(init.length);
       for(int i=0; i<init.length; i++)
    	   buffer.enqueue(init[i]);
    }

    // pluck the guitar string by setting the buffer to white noise
    public void pluck()
    {
    	for(int i=0; i<buffer.getSize(); i++)
    	{
        int rand = (int) (Math.random()*10)+1;
        double actVal=0;
        if(rand<=5)
        	actVal = rand * (.1) * (-1);
        else if(rand>5)
        	actVal = (rand-5) * (.1);
        if(rand==10)
        	actVal=0;
        buffer.enqueue(actVal);
    	}
        
    }

    // advance the simulation one time step
    public void tic() {
        buffer.dequeue();
        double first = buffer.dequeue();
        double second = buffer.dequeue();
        buffer.enqueue(first);
        buffer.enqueue(second);
        double addMe = ( (first+second) / 2) * .994;
        double copy[] = new double[buffer.getSize()];
        for(int i=0; i<copy.length; i++)
        	copy[i] = buffer.dequeue();
        copy[copy.length-1] += addMe;
        for(int i=0; i<copy.length; i++)
        	buffer.enqueue(copy[i]);
        
        tics++;
        }

    // return the current sample
    public double sample() {
        return buffer.peek();
    }

    // return number of times tic was called
    public int time() {
        return tics;
    }

}
