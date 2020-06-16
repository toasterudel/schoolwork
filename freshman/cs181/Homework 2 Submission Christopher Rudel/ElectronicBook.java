/*
 * ElectronicBook.java
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 */
package bookstore;

/**
 * 
 * @author chris rudel
 * @version 1.0
 * The ElectronicBook class is a child of the book class, specifically for electronic books. 
 */
public class ElectronicBook extends Book
{
	private final String theURL;
	/**
	 * All properties of an electronic book
	 * @param title
	 * @param author
	 * @param cost
	 * @param theURL 	The URL of the book
	 */
	public ElectronicBook(String title, String author, double cost, String theURL)
	{
		super(title, author, cost, Medium.Electronic);
		this.theURL = theURL;
	}
	
	public String getMedium()
	{
		return super.getMedium() + ":{" + this.theURL + "}";
	}
	@Override
	/**
	 * Taken from the parent class, electronic books are online so they are never for sale; only for rent. 
	 */
	public boolean isForSale()
	{
		return false;
	}
	public String toString()
	{
		return super.toString() + " From: " + this.theURL; 
	}
	
}
