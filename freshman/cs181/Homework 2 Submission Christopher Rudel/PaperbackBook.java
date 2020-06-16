/*
 * PaperbackBook.java
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 */
package bookstore;

/**
 * 
 * @author chris rudel
 * @version 1.0
 * The PaperbackBook class is a child of the book class, specifically for paperback books. 
 */
public class PaperbackBook extends Book
{
	/**
	 * All properties of a paperback book
	 * @param title
	 * @param author
	 * @param cost
	 */
	public PaperbackBook(String title, String author, double cost)
	{
		super(title, author, cost, Medium.Paperback);
	}
	
	@Override
	/**
	 * Taken from the parent class, paperback books are always available for sale. 
	 */
	public boolean isForSale()
	{
		return true;
	}
	public String toString()
	{
		return super.toString() + ".";
	}
}
