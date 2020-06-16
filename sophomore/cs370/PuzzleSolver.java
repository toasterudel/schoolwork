import java.io.*;
import java.util.*;
public class PuzzleSolver
{

    static ArrayList<Integer> solutions;
    public static void moveL(Square[] s)
    {
	Square first = s[0];
	for(int i=0; i<8; i++)
	    s[i] = s[i+1];
	s[8] = first;
	return;
    }
    public static void moveR(Square[] s)
    {
	Square first = s[0];
	for(int i=8; i>0; i--)
	    s[i] = s[i-1];
	s[8] = first;
	return;
    }
    static boolean fits(String f, String s)
    {
	return ((f.substring(0,1).equals(s.substring(0,1))) && !(f.substring(1,2).equals(s.substring(1,2))));
    }

    public static boolean isSolution(Square[] s)
    {
	return  (fits(s[0].getRight(),s[1].getLeft()) && fits(s[0].getBottom(), s[3].getTop()) && fits(s[1].getBottom(), s[4].getTop()) && fits(s[1].getRight(), s[2].getLeft()) && fits(s[2].getBottom(), s[5].getTop()) && fits(s[3].getRight(), s[4].getLeft()) && fits(s[3].getBottom(), s[6].getTop()) && fits(s[4].getBottom(), s[7].getTop()) && fits(s[4].getRight(), s[5].getLeft()) && fits(s[5].getBottom(), s[8].getTop()) && fits(s[6].getRight(), s[7].getLeft()) && fits(s[7].getRight(), s[8].getLeft()));
	   
 }

   public void solve(Square[] s)
    {
	permute("", "012345678");
	int size = solutions.size();
	if(size == 0)
	{
	    System.out.println("No solutions found.");
	    return;
	}
	if(size == 1)
	    System.out.println("Unique solution found:\n");
	if(size > 1)
	    System.out.println("Unique solutions found:\n");
	drawSolution	
	return 0;
    }
   
    public static void main(String[] args) throws FileNotFoundException
    {
	File file = new File("input.txt");
	Scanner sc = new Scanner(file);
	solutions = new ArrayList<>();
	String strs[] = new String[9];
	for(int i=0; i<9; i++)
	{
	    strs[i]=sc.nextLine();
	    strs[i] = strs[i].replace(",","");
	}
	Square[] sqrs = new Square[9];
	for(int i=0; i<9; i++)
	    sqrs[i] = new Square(strs[i].substring(0,2), strs[i].substring(2,4), strs[i].substring(4,6), strs[i].substring(6,8));   

	System.out.println(isSolution(sqrs));
	
	System.out.println(sqrs[8].getLeft()); /*This is the very last input thin, in the example it's B0 */
	System.out.println(sqrs[8].has("G0")); /*Should return -1 because the last square doesn't have G0 */
	System.out.println(sqrs[0].getTop() + sqrs[1].getTop());
	String ned[] = sqrs[0].needs();
	System.out.println(Arrays.toString(ned));
	System.out.println(fits(sqrs[0].getTop(), sqrs[1].getTop()));
	moveL(sqrs);
	System.out.println(sqrs[8].has("G0")); /*Returns 1 because the last square has G0 on the right now */
	sqrs[8].rotateR(3);
     }
}

class Square
{
    private String top;
    private String right;
    private String bottom;
    private String left;
    private boolean inUse;

    public Square(String t, String r, String b, String l)
    {
	this.top=t;
	this.right=r;
	this.bottom=b;
	this.left=l;
	this.inUse = false;
    }

    public void rotateR()
    {
	String t=this.top;
	String r=this.right;
	String b=this.bottom;
	this.top=this.left;
	this.right=t;
	this.bottom=r;
	this.left=b;
	return;
    } 
    public void rotateR(int num)
    {
	for(int i=0; i<num; i++)
	    this.rotateR();
	return;
    }
    public void rotateL()
    {
	String t=this.top;
	String r=this.right;
	String b=this.bottom;
	this.bottom=this.left;
	this.right=b;
	this.top=r;
	this.left=t;
	return;
    }

    public void rotateL(int num)
    {
	for(int i=0; i<num; i++)
	    this.rotateL();
	return;
    }
	/*The "has" functions return -1 if the square doesnt have it, 0-3 if it does have it */
    public int has(String color)
    {
	if(this.getTop().equals(color))
	    return 0;
	else if(this.getRight().equals(color))
	    return 1;
	else if(this.getBottom().equals(color))
	    return 2;
	else if(this.getLeft().equals(color))
	    return 3;
	else return -1;
    } 

    public void useOn()
    {
	this.inUse = true;
    }
    public void useOff()
    {
	this.inUse = false;
    }
    public boolean inUse()
    {
	return this.inUse;
    }
    public String[] needs()
    {
	String ans[] = new String[4];
	StringBuffer tmp = new StringBuffer(this.getTop().substring(0,1));
	StringBuffer tmp1 = new StringBuffer(this.getRight().substring(0,1));
	StringBuffer tmp2 = new StringBuffer(this.getBottom().substring(0,1));
	StringBuffer tmp3 = new StringBuffer(this.getLeft().substring(0,1));
	int t = Integer.parseInt(this.getTop().substring(1,2));
	int t1 = Integer.parseInt(this.getRight().substring(1,2));
	int t2 = Integer.parseInt(this.getBottom().substring(1,2));
	int t3 = Integer.parseInt(this.getLeft().substring(1,2));
	t ^=1;
	t1 ^=1;
	t2 ^=1;
	t3 ^=1;
	ans[0] = (tmp.append(Integer.toString(t))).toString();
	ans[1] = (tmp1.append(Integer.toString(t1))).toString();
	ans[2] = (tmp2.append(Integer.toString(t2))).toString();
	ans[3] = (tmp3.append(Integer.toString(t3))).toString();
	return ans;
    }
 
   
    /*Getters below, setters aren't really necessary */

    public String getTop()
    {
	return this.top;
    }

    public String getRight()
    {
	return this.right;
    }
    public String getBottom()
    {
	return this.bottom;
    }
    public String getLeft()
    {
	return this.left;
    }
}
