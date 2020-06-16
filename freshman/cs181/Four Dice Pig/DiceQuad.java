/*
 * DiceQuad.java
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 * 
 */



package Stevens.CS181.Lab5;
/**
 * This class essentially does the same job as DicePair.java except it has 4 dice. 
 * In addition to DicePair methods, it has methods to see if 1 of the four dice contains a one,
 * if 2 of the dice contain a one and so on. 
 * 
 * @author Christopher Rudel
 * @version 1.0
 * @since 20161019
 */
public class DiceQuad 
{
	private Die die1;
	private Die die2;
	private Die die3;
	private Die die4;
	
	public DiceQuad()
	{die1 = new Die(); die2 = new Die(); die3 = new Die(); die4 = new Die();  }
	
	/**
	 * Generates a random number between 1-6 for each die and assigns it to the die
	 */
	public void roll()
	{	die1.roll(); die2.roll(); die3.roll(); die4.roll();   }
	
	
	/**
	 * @return Whether all four of the dies are 1
	 */
	public boolean isFourOnes()
	{
		if(die1.getFaceValue()==1 && die2.getFaceValue()==1 
				&& die3.getFaceValue()==1 && die4.getFaceValue()==1)
			return true;
			else return false;
	}
	/**
	 * @return Whether three of the dies are 1
	 */
	public boolean isThreeOnes()
	{
			if(die1.getFaceValue()==1 && die2.getFaceValue()!=1 
				&& die3.getFaceValue()==1 && die4.getFaceValue()==1)  // All are 1 except 2
				return true;
			else if(die1.getFaceValue()==1 && die2.getFaceValue()==1 
					&& die3.getFaceValue()!=1 && die4.getFaceValue()==1)  // All are 1 except 3
				return true;
			else if(die1.getFaceValue()==1 && die2.getFaceValue()==1 
					&& die3.getFaceValue()==1 && die4.getFaceValue()!=1)  // All are 1 except 4
				return true;
			else if(die1.getFaceValue()!=1 && die2.getFaceValue() ==1 
					&& die3.getFaceValue()==1 && die4.getFaceValue()==1)  // All are 1 except 1
				return true;
			else return false;
	}
	/**
	 * @return Whether two of the dies are 1
	 */
	public boolean isTwoOnes()
	{
		if(die1.getFaceValue()==1 && die2.getFaceValue()==1 
				&& die3.getFaceValue()!=1 && die4.getFaceValue()!=1)  // 1's on 1 & 2
			return true;
		else if(die1.getFaceValue()==1 && die2.getFaceValue()!=1 
				&& die3.getFaceValue()==1 && die4.getFaceValue()!=1)  // 1's on 1 & 3
			return true;
		else if(die1.getFaceValue()==1 && die2.getFaceValue()!=1 
				&& die3.getFaceValue()!=1 && die4.getFaceValue()==1)  // 1's on 1 & 4
			return true;
		else if(die1.getFaceValue()!=1 && die2.getFaceValue()==1 
				&& die3.getFaceValue()==1 && die4.getFaceValue()!=1)  // 1's on 2 & 3
			return true;
		else if(die1.getFaceValue()!=1 && die2.getFaceValue()==1 
				&& die3.getFaceValue()!=1 && die4.getFaceValue()==1)  // 1's on 2 & 4
			return true;
		else if(die1.getFaceValue()!=1 && die2.getFaceValue()!=1 
				&& die3.getFaceValue()==1 && die4.getFaceValue()==1)  // 1's on 3 & 4
			return true;
		else return false;
	}
	/**
	 * @return Whether one of the dies are 1
	 */
	public boolean isOneOne()
	{
		if(die1.getFaceValue()==1 && die2.getFaceValue()!=1 
				&& die3.getFaceValue()!=1 && die4.getFaceValue()!=1)
			return true;
		else if(die1.getFaceValue()!=1 && die2.getFaceValue()==1 
				&& die3.getFaceValue()!=1 && die4.getFaceValue()!=1)
			return true;
		else if(die1.getFaceValue()!=1 && die2.getFaceValue()!=1 
				&& die3.getFaceValue()==1 && die4.getFaceValue()!=1)
			return true;
		else if(die1.getFaceValue()!=1 && die2.getFaceValue()!=1 
				&& die3.getFaceValue()!=1 && die4.getFaceValue()==1)
			return true;
		else return false;
	}
	/**
	 * @return The sum of the four dice
	 */
	public int getDiceTotal()
    { return (die1.getFaceValue () + die2.getFaceValue () + die3.getFaceValue() + die4.getFaceValue()); }
	/**
	 * @return A string in the form of (Dice1 value,Dice2 value,Dice3 value, Dice4 value)
	 */
    public String toString()
    { return "(" + die1 + "," + die2 + "," + die3 + "," + die4 + ")"; 
}
}