/*
 * AudioBook.java
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 */
package bookstore;

/**
 * 
 * @author chris rudel
 * @version 1.0
 * The AudioBook class is a child of the book class, specifically for audio books.
 */
public class AudioBook extends Book
{
	private final Integer numDiscs;
	/**
	 * All are properties of a book.
	 * @param title
	 * @param author
	 * @param cost
	 * @param numDiscs	the number of discs the audio book has
	 */
	public AudioBook(String title, String author, double cost, Integer numDiscs)
	{
		super(title, author, cost, Medium.Audio);
		this.numDiscs=numDiscs;
	}
	
	@Override
	/**
	 * Taken from the parent class, audio books are never for sale and can only be rented. 
	 */
	public boolean isForSale()
	{
		return false;
	}
	
	public String toString()
	{
		String answer = super.toString() + ": " + numDiscs + " disks" +".";
		return answer;
	}
	
	public String getMedium()
	{
		return super.getMedium() + ":{" + this.numDiscs+ "} disks";
	}
	
}
