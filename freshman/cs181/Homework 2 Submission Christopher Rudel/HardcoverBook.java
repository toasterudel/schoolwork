/*
 * HardcoverBook.java
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 */
package bookstore;

/**
 * 
 * @author chris rudel
 * @version 1.0
 *The HardcoverBook class is a child of the book class, specifically for hard cover books.
 */
public class HardcoverBook extends Book
{
	private final String coverMaterial;
	/**
	 * All properties of a hard cover book
	 * @param title
	 * @param author
	 * @param cost
	 * @param coverMaterial What the cover material is i.e. cloth, leather
	 */
	public HardcoverBook(String title, String author, double cost, String coverMaterial)
	{
		super(title, author, cost, Medium.Hardcover);
		this.coverMaterial=coverMaterial;
	}
	
	public String getCoverMaterial()
	{
		return coverMaterial;
	}
	
	
	  public String getMedium()
	  {
		  return super.getMedium() + ".";
	  }
	 
	  @Override
	  /**
	   * Taken from the parent class, hard cover books are always available for sale
	   */
	public boolean isForSale()
	{
		return true;
	}
	
	public String toString()
	{
		String answer = super.toString() + " " + coverMaterial + ".";
		return answer;
	}
}
