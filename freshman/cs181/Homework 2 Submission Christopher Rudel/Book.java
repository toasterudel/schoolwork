/*
 * Book.java
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 */
package bookstore;

/**
 * 
 * @author chris rudel
 * @version 1.0
 * This is the abstract class Book, which other classes like AudioBook extend.
 */
public abstract class Book extends Object 
{
	private String author; 
	private double cost;
	private Medium medium;
	private String title;
	
	/**
	 * All of the parameters are properties of the book, medium is the format of the book i.e. digital/paperback
	 * @param title
	 * @param author
	 * @param cost    	This is the cost of the book in cents
	 * @param medium	The format of the book
	 */
	public Book(String title, String author, double cost, Medium medium)
	{
		this.title = title;
		this.author = author;
		this.cost = cost/100;	//divided by 100 because cost is in cents.
		this.medium = medium;
	}
	//I am not providing javadocs for getter Methods, they are self explanatory 
	public String getAuthor()
	{
		return author;
	}
	public double getCost()
	{
		return cost;
	}
	public String getMedium()
	{
		return medium.toString();
	}
	
	public String getTitle()
	{
		return title;
	}
	
	public abstract boolean isForSale(); //Sets up the method isForSale(), which subclasses of Book uses to determine whether or not
										// you can buy the book
	
	public String toString()
	{
		String answer = title + ".	" + author;
		answer += ".	"  + medium;			//made a separate line here, when pressing tab on the same line it doesnt indent as far
		return answer;
	}
	
}	
