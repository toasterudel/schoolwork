/*
 * Lab02.java
 *
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 *
 */
package Lab2;

/**
 * This java file has 3 functions. 
 * The first method, getDay, takes the entered date and returns what day of the week it is. 
 * The second method, newDate, takes the entered date, adds the entered number of days to the date and returns the new date.
 * The final method, daysBetween, takes the two entered dates and finds the number of days between the two dates. 
 *
 * @author Christopher Rudel
 * @version 1.0
 * @since 20160913
 * 
 */


public class Lab02_ChristopherRudel{
    
    public static final String NAME = "Christopher Rudel";
    
    /**
     * Given a string, in the format of yyyymmdd, extracts the day of the 
     * week the date falls on
     *
     * @param s  the string, in the format of yyyymmdd to be processed
     * @return   the day of the week, as a String
     */
    public static String getDay(String s)
    {
    	/*Assuming s is provided in the format: yyyymmdd*/
    	
    	int year = Integer.parseInt(s.substring(0, 4));
    	int month = Integer.parseInt(s.substring(4,6));
    	int day = Integer.parseInt(s.substring(6,8));
    	
    	if (month == 1 || month == 2) 
    	{
    		month += 12;
    		year--;
    	}
    	
    	int resultInt = (day - 1 + ((13 * (month + 1)) / 5) + year + (year/4) - (year / 100) + (year/400)) % 7;
    	
    	if (resultInt == 0)
    		return "Sunday";
    	else if (resultInt == 1)
    		return "Monday";
    	else if (resultInt == 2)
    		return "Tuesday";
    	else if (resultInt == 3)
    		return "Wednesday";
    	else if (resultInt == 4)
    		return "Thursday";
    	else if (resultInt == 5)
    		return "Friday";
    	else if (resultInt == 6)
    		return "Saturday";
    	else return "Error";
    		
    }

   /**
    * Given a string date and a number, computes the day of the week n days 
    * after (or before) the date given
    *
    * @param s  the string, in the format of yyyymmdd to be processed
    * @param n  the number of days after (or before if negative) 
    *           the specified date
    * @return   the new date,as a String in yyyymmdd format
    */
    public static String newDate(String s, int n) 
    {
    	int beginYear = Integer.parseInt(s.substring(0, 4));
    	int beginMonth = Integer.parseInt(s.substring(4,6));
    	int beginDay = Integer.parseInt(s.substring(6,8));
    	
    	int endDay = beginDay + n;
    	int endMonth = beginMonth;
    	int endYear = beginYear;
    	
    	if(endDay > 30 && beginMonth == 4 || endDay > 30 && beginMonth == 6 || endDay > 30 && beginMonth == 9 
    			|| endDay > 30 && beginMonth == 11) //Checks to see if days are over 30 in April, June, September and November
    		{
    			endDay -= 30;
    			endMonth++;
    		}
    	else if(endDay > 31 && beginMonth == 1 || endDay > 31 && beginMonth == 3 || endDay > 31 && beginMonth == 5 
    			|| endDay > 31 && beginMonth == 7 || endDay > 31 && beginMonth == 8 || endDay > 31 && beginMonth == 10
    			|| endDay > 31 && beginMonth == 12) //Checks to see if days are over 31 in Jan, Mar, May, July, Aug, Oct, and Dec
    	{
    		endDay -= 31;
    		endMonth++;
    	}
    	else if(beginMonth == 2 && endDay > 29 && beginYear%4 ==0  && beginYear%100!=0 && beginYear%400==0 ) // leap year
    	{
    		endDay -= 29;
    		endMonth++;
    	}
    	else if(endDay > 28 && beginMonth == 2 && beginYear%4 ==0 && beginYear%100==0 && beginYear%400!=0)
    	{
    		endDay-=28;
    		endMonth++;
    	}
    	
    	if(endMonth > 12)
    	{
    		endMonth -= 12;
    		endYear++;
    	}
    	
    	String endDate = Integer.toString(endYear);
    	String endDateMonth;
    	String endDateDay;
    	if (endMonth == 1 || endMonth == 2 || endMonth ==3 || endMonth == 4 || endMonth == 5 || endMonth == 6 || endMonth == 7 || 
    			endMonth == 8 || endMonth == 9)
    		endDateMonth = "0" + Integer.toString(endMonth); //Provides a 0 for months 1-9 to keep format of yyyymmdd
    	else endDateMonth = Integer.toString(endMonth);
    	
    	if (endDay == 1 || endDay == 2 || endDay ==3 || endDay == 4 || endDay == 5 || endDay == 6 || endDay == 7 || 
    			endDay == 8 || endDay == 9)
    		endDateDay = "0" + Integer.toString(endDay); //Provides a 0 for days 1-9 to keep format yyyymmdd
    	else endDateDay = Integer.toString(endDay);
    	
    	endDate += endDateMonth + endDateDay;
    	return endDate;
    	
    		
    	
    	
    }

   /**
    * Given two dates, computes the number of days inbetween them.
    *
    * @param start  the start date, in the format of yyyymmdd 
    * @param end    the end date
    * @return       the number of days between the two dates
    */
    public static int daysBetween(String start, String end)
    {
    	int beginYear = Integer.parseInt(start.substring(0, 4));
    	int beginMonth = Integer.parseInt(start.substring(4,6));
    	int beginDay = Integer.parseInt(start.substring(6,8));
    	
    	int endYear = Integer.parseInt(end.substring(0, 4));
    	int endMonth = Integer.parseInt(end.substring(4,6));
    	int endDay = Integer.parseInt(end.substring(6,8));
    	
    	int beginTotal = 0;
    	int endTotal = 0;
    	int answer = 0;
    	
    	/*                                   Adding the beginDate total together                */
    	for(int year = 1; year<= beginYear; year++)
    	{
    		if(year % 4 == 0 && (year % 100 !=0 || year % 400 ==0))
        	{
        		beginTotal += year * 366;
        	}
        	else beginTotal += year*365;
    	}
    	
    	int beginNum = 0;
    	for(int month = 1; month<beginMonth; month++)
    	{
    		if(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
    			beginNum+=31;
    		if(month == 4 || month == 6 || month == 9 || month ==11)
    			beginNum+=30;
    		if(month == 2 && beginMonth % 4 ==0 && (beginMonth % 100 != 0 || beginMonth % 400 ==0) )
    			beginNum+=29;
    		else if (month == 2)
    			beginNum+=28;
    	}
    	beginTotal += beginNum;
    	beginTotal += beginDay;
    	
    	/**                                  Adding the endDate total together                **/
    	for(int year = 1; year<= endYear; year++)
    	{
    		if(year % 4 == 0 && (year % 100 !=0 || year % 400 ==0))
        	{
        		endTotal += year * 366;
        	}
        	else endTotal += year*365;
    	}
    	
    	int endNum = 0;
    	for(int month = 1; month<endMonth; month++)
    	{
    		if(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
    			endNum+=31;
    		if(month == 4 || month == 6 || month == 9 || month ==11)
    			endNum+=30;
    		if(month == 2 && beginMonth % 4 ==0 && (beginMonth % 100 != 0 || beginMonth % 400 ==0) )
    			endNum+=29;
    		else if(month == 2) 
    			endNum+=28;
    	}
    	endTotal += endNum;
    	endTotal += endDay;
    	
    	answer = endTotal - beginTotal;
    	 return answer;
    	
    	
    }

    public static void main(String[] args)
    {
    	System.out.println("Enter the number of the question you want.");
    	System.out.println("You entered: " + args[0]);
    	
    	if (Integer.parseInt(args[0])== 1)
    		System.out.println(Lab02_ChristopherRudel.getDay(args[1]));
    	else if (Integer.parseInt(args[0]) == 2)
    	{
    		System.out.print("Start date: " + args[1] + ", end date: ");
    		System.out.println(Lab02_ChristopherRudel.newDate(args[1], Integer.parseInt(args[2])));
    		System.out.println("Days added: " + args[2]);
    	}
    	else if (Integer.parseInt(args[0]) == 3)
    	{
    		System.out.println("Beginning date: " + args[1] + " End date: " + args[2]) ;
    		System.out.println("Days inbetween: " + Lab02_ChristopherRudel.daysBetween(args[1], args[2]));
    	}
    	else 
    		System.out.println("Please enter a valid number.");
    }
    
}
