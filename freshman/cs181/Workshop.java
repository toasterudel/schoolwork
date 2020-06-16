/*Chris Rudel
 * 9/6/16
 * CS181 Workshop 1
 * I pledge my honor that I have abided by the Stevens Honor System. Christopher Rudel
 */
public class Workshop 
{
	public static void main(String[] args)
	{
		System.out.print("Enter the question you would like to have done: ");
		System.out.println(args[0]);
		int first = Integer.parseInt(args[0]);
		                      /////////////////////////////QUESTION 1////////////////////////////////////
		if(first==1)
		{
			System.out.println("Input: " + args[1]);
			int res = 0;
			String arg = args[1].substring(1);		
			//Binary to Integer
			if(args[1].substring(0, 1).equals("b"))
			{
				if(arg.substring(0,1).equals("1")) //I tried to make a loop here but it proved to be difficult
					res+= Math.pow(2, 7);
				if(arg.substring(1,2).equals("1"))
					res+= Math.pow(2, 6);
				if(arg.substring(2,3).equals("1"))
					res+= Math.pow(2, 5);
				if(arg.substring(3,4).equals("1"))
					res+= Math.pow(2, 4);
				if(arg.substring(4,5).equals("1"))
					res+= Math.pow(2, 3);
				if(arg.substring(5,6).equals("1"))
					res+= Math.pow(2, 2);
				if(arg.substring(6,7).equals("1"))
					res+= Math.pow(2, 1);
				if(arg.substring(7).equals("1"))
					res+= Math.pow(2, 0);
				System.out.println("Output: i" + res);
			}
			//Integer to Binary
			if(args[1].substring(0, 1).equals("i"))
			{
				String q = args[1].substring(1);
				int num = Integer.parseInt(q);
				System.out.println("Output: b" + Integer.toBinaryString(num));
			}
		}
		
		                       //////////////////////////QUESTION 2///////////////////////////////////////
		if(first==2)
		{
			System.out.println("Enter the number you would like to have the square root of: " + args[1]);
			int n = Integer.parseInt(args[1]);
			double guess = .0001;
			do
			{
				guess = (guess+n/guess)/2;
			}while(0.0000000001<Math.abs(guess*guess-n));
			
			System.out.println("The square root: " + guess);
		}
		
		
		                       /////////////////////////QUESTION 3//////////////////////////////////////////
		if(first==3)
		{
			System.out.println("Enter coefficient a: " +args[1]);
			//args[1]
			System.out.println("Enter coefficient b: " +args[2]);
			//args[2]
			System.out.println("Enter coefficient c: " +args[3]);
			//args[3]
			
			double a = Double.parseDouble(args[1]);
			double b = Double.parseDouble(args[2]);
			double c = Double.parseDouble(args[3]);
			
			double d = Math.sqrt((b*b)-(4*a*c));
			
			double sol1 = ((b*-1)+d)/(2*a);
			double sol2 = ((b*-1)-d)/(2*a);
			
			System.out.println("The two solutions are: x=" + sol1 + " and: x=" +sol2);
		}
		
		
	}
}
