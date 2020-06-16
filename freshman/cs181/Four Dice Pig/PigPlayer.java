/*
 * PigPlayer.java
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 * 
 */

package Stevens.CS181.Lab5;

/**
 * This file does the same tasks as the previous PigPlayer file, however it works with four dice, not two.
 * @author Original: Srinivas Sridharan , Edited: Christopher Rudel
 * @version 1.1
 * @since 20161019
 */
public abstract class PigPlayer {
    public static int WINNING_SCORE = 100;

    /** Whether or not to automatically recognize a winning score
       before the player hand off the dice */
    public static boolean AUTO_WIN_RECOGNITION_ON = true;

    protected static int numPlayers = 0;

    protected String name;
    protected DiceQuad dice;

    /** running score, does not include roundScore till turn is over */
    protected int score;
    protected int roundScore;

    protected boolean isPlayerTurn;
    
    /** Back reference to owner Pig object */
    protected Pig owner;

    public PigPlayer(Pig owner, String name) {
	assert(owner != null && name != null);

	this.owner = owner;
	this.name = name;
	dice = new DiceQuad();
	score = roundScore = 0;
	isPlayerTurn = false;

	numPlayers++;
    }

    public PigPlayer(Pig owner)
    {   this(owner, "Player" + numPlayers);   }

    /** reset player's state for a new game */
    public void reset() {
	dice = new DiceQuad ();
	score = roundScore = 0;
	isPlayerTurn = false;
    }
    /**
     * Returns the name of the player (are javadocs necessary for getters and setters?)
     * @return Name of player
     */
    public String getName()
    {   return name;  }

    /**
     * Computes the total current score.  This might differ
     * from score, since roundScore only gets added once the
     * turn is over.  Since roundScore keeps last round score,
     * need to check whose turn it is before adding that
     */
    public int getCurrentScore() { 
	return  (isPlayerTurn ? (score + roundScore) : score);
    }
    
    public boolean hasWon() 
    { 	return (getCurrentScore() >= WINNING_SCORE);  }

    /** 
     * String representation of this class is the current
     * total score, along with the current round score
     * (which could still be lost, in the case the turn
     * is still on), or the last round score, if it's
     * the other player's turn
     */
    public String toString() {
	return name + "\'s score: \t" + getCurrentScore () + "\t"
		+ (isPlayerTurn ? " (this round so far:  " 
		                : " (last round's score: ")
		+ "\t" + roundScore + ")";
    }   
	/**
	 * Prints to the console what happens when four 1's are rolled	
	 */
    protected void displayGotFourOnes()
    {
    	System.out.println(name + " rolled four 1's!!");
    	System.out.println("\t" + name + " loses all points!");
    }
    /**
	 * Prints to the console what happens when three 1's are rolled	
	 */
    protected void displayGotThreeOnes()
    {
    	System.out.println(name + " rolled three 1's!!");
    	System.out.println("\t" + name + " loses round points");
    }
    /**
	 * Prints to the console what happens when two 1's are rolled	
	 */
    protected void displayGotTwoOnes() {   
	System.out.println (name + " rolled two 1's!");
	System.out.println ("\t" + name + " doesn't lose any points"); 
    }
    /**
	 * Prints to the console what happens when one 1 is rolled	
	 */
    protected void displayGotAOne() {
	System.out.println (name + " rolled a 1!!");
	System.out.println ("\t" + name + " loses the combined points minus 10");
    }
    /**
     * Prints out the dice values
     */
    protected void displayDice() {
	System.out.println(dice);
    }
    /**
     * Prints out when a player does a roll
     */
    protected void displayDoRoll() {
	owner.displayScores ();
	System.out.print(name + " rolls... ");
    }

    /**
     * Driver method for one turn of this player.
     * The turn is over when at least one 1 is rolled, or when the player
     * relinquishes the dice
     */
    public void doTurn() {
	roundScore = 0;
	isPlayerTurn = true;

	while (isPlayerTurn) {
	    doRoll ();
	    
	    // isPlayerTurn will be turned to false when a 1 is rolled
	    if (isPlayerTurn) {
		// check whether player wants to hand dice over
		isPlayerTurn = !wantsHandOver();
	    }
	}

	score += roundScore;
    }

    /**
     * This method implements the rules of the Pig game
     */
    protected void doRoll() {
	displayDoRoll();
	dice.roll();
	displayDice();

	if(dice.isFourOnes()){
		//loses all points
		score = roundScore = 0;
		isPlayerTurn = false;
		displayGotFourOnes();
	}
	else if(dice.isThreeOnes()){
		//lose round points on three 1's
		roundScore = 0;
		isPlayerTurn = false;
		displayGotThreeOnes();
	}
	  else if (dice.isTwoOnes()) {
	    // ends turn on two 1's
	    isPlayerTurn = false;
	    displayGotTwoOnes();
	} else if (dice.isOneOne()) {
	    // gains sum of other three die - 10
		roundScore += dice.getDiceTotal();
	    score -= 11; //subtracting 11 to counter the extra 1 from the other die
	    isPlayerTurn = false;
	    displayGotAOne();
	} else {
	    roundScore += dice.getDiceTotal();
	    
	    if (AUTO_WIN_RECOGNITION_ON && hasWon()) 
		// turn is over if user won
		isPlayerTurn = false;
	}
    }

    /**
     * Sub-classes extend this method to implement their 
     * game playing strategies
     */
    abstract protected boolean wantsHandOver();
}
