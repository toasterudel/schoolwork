package Homework3;
import Homework3.StdDraw;
import Homework3.StdAudio;
/*
 * GuitarHero.java
 * I pledge my Honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 */
import Homework3.GuitarString;

/**
 * An edited version of the provided GuitarHeroLite java code that was provided.
 * This version includes all number and letter keys.
 * 
 * @editor Christopher Rudel
 * @version 1.01
 * @since 20161128
 *
 */
public class GuitarHero
{ 
	public static final String NAME = "CHRISTOPHER_RUDEL";
	
	 public static void main(String[] args) {
		 // create two guitar strings, for concert A and C
		 String keyboard = "1234567890qwertyuiopasdfghjklzxcvbnm,";
		 GuitarString strings[] = new GuitarString[37];
		 for(int i=0; i<strings.length; i++)
			 strings[i] = new GuitarString((440.0) * (Math.pow( 2, (i-24) / 12) ));
	
 while (true)
 {           
			 // check if the user has typed a key; if so, process it    
			 if (StdDraw.hasNextKeyTyped()) {               
				 char key = StdDraw.nextKeyTyped();
	                int index = keyboard.indexOf(key);
	                if (index != -1) 
	                	strings[index].pluck();
			}        
			 // compute the superposition of samples    
			 double sample = 0;
			 for(GuitarString string : strings)
				 sample += string.sample();
            // send the result to the sound card     
			 StdAudio.play(sample);        
			 // advance the simulation of each guitar string by one step      
			 for(GuitarString string : strings)
				 string.tic();
 }     
		 }
		
}
