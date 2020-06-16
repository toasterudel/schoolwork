/*
*	Christopher Rudel
* hw3.java
* CS442 
* Assignment 3: JDBC programming
*/

//package testing;
import java.sql.*;

/* In this solution I could only get it to work in eclipse, trying to run
* the code through the terminal wasn't working because I had to select the 
* connector/j jar file in eclipse and I don't know how to do that in terminal*/

public class hw3 
{
   // JDBC driver name and database URL
   static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver"; //Eclipse was telling me this was deprecated unless i added the "cj"
   static final String DB_URL = "jdbc:mysql://localhost:3306/test?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
   //I was getting errors in the db_url unless I had the whole statement, it was giving me timecode errors.
   
   //  Database credentials
   static final String USER = "root";
   //the user name;
   static final String PASS = "root";
   //the password;
  
   public static void main(String[] args) 
   {
	   Connection conn = null;
	   Statement stmt = null;
	   try
	   {
	      //STEP 1: Register JDBC driver
	      Class.forName("com.mysql.cj.jdbc.Driver");
	      //Again I needed to add the "cj" because it was telling me it was deprecated if I didn't
	      
	      //STEP 2: Open a connection
	      System.out.println("Connecting to database...");
	      conn = DriverManager.getConnection(DB_URL, USER, PASS);
	   }catch(Exception e) {
		   System.out.println("Can't connect to database");
		   System.err.println(e);
	   }finally 
	   {
		   if (conn != null) 
		   {
			   try
			   {
            	   stmt = conn.createStatement();
            	   String sql = "";
            	   /*
            	   sql = "DROP DATABASE BoatRental";
            	   stmt.executeUpdate(sql);
            	   System.out.println("Database deleted successfully..."); 
            	   This is only here because I was tired of manually dropping the database
            	   each time				*/
            	   
            	   //Creating the databases 
            	   sql = "CREATE DATABASE BoatRental";
            	   stmt.executeUpdate(sql);
            	   sql = "use BoatRental";
            	   stmt.executeUpdate(sql);
            	   
            	   sql = "CREATE TABLE sailors( sid integer not null PRIMARY KEY, "
            	   		+ "sname varchar(20) not null, "
            	   		+ "rating real not null, "
            	   		+ "age integer)";
            	   stmt.executeUpdate(sql);
            	   
            	   sql = "CREATE TABLE boats( bid integer not null PRIMARY KEY, "
            	   		+ "bname varchar(20) not null, "
            	   		+ "color varchar(40) not null)";
            	   stmt.executeUpdate(sql);
            	   
            	   sql = "CREATE TABLE reserves( sid integer not null, "
            	   		+ "bid integer not null, "
            	   		+ "day date not null,"
            	   		//+ "PRIMARY KEY(day), "
            	   		+ "FOREIGN KEY(sid) references sailors(sid),"
            	   		+ "FOREIGN KEY(bid) references boats(bid))";
            	   stmt.executeUpdate(sql);
            	   //Inserting values
            	   //If there's a more elegant way to do this please tell me
            	   String[] sqls = new String[8];
            	   sqls[0] = "insert into sailors values(22, 'Dustin', 7, 45)";
            	   sqls[1] = "insert into sailors values(29, 'Brutus', 1, 33)";
            	   sqls[2] = "insert into sailors values(31, 'Lubber', 8, 55)";
            	   sqls[3] = "insert into sailors values(32, 'Andy', 8, 26)";
            	   sqls[4] = "insert into sailors values(58, 'Rusty', 10, 35)";
            	   sqls[5] = "insert into sailors values(64, 'Horatio', 7, 35)";
            	   sqls[6] = "insert into sailors values(71, 'Zorba', 20, 18)";
            	   sqls[7] = "insert into sailors values(74, 'Horatio', 9, 35)";
            	   for(int i=0; i<sqls.length; i++)
            		   stmt.executeUpdate(sqls[i]);
            	   
            	   String[] sqlb = new String[4];
            	   sqlb[0] = "insert into boats values(101, 'Interlake', 'Blue')";
            	   sqlb[1] = "insert into boats values(102, 'Interlake', 'Red')";
            	   sqlb[2] = "insert into boats values(103, 'Clipper', 'Green')";
            	   sqlb[3] = "insert into boats values(104, 'Marine', 'Red')";
            	   for(int i=0; i<sqlb.length; i++)
            		   stmt.executeUpdate(sqlb[i]);
            	   
            	   String[] sqlr = new String[10];
            	   sqlr[0] = "insert into reserves values(22, 101, '2018-10-10')";
            	   sqlr[1] = "insert into reserves values(22, 102, '2018-10-10')";
            	   sqlr[2] = "insert into reserves values(22, 103, '2017-10-08')";
            	   sqlr[3] = "insert into reserves values(22, 104, '2017-10-09')";
            	   sqlr[4] = "insert into reserves values(31, 102, '2018-11-10')";
            	   sqlr[5] = "insert into reserves values(31, 103, '2018-11-06')";
            	   sqlr[6] = "insert into reserves values(31, 104, '2018-11-12')";
            	   sqlr[7] = "insert into reserves values(64, 101, '2018-04-05')";
            	   sqlr[8] = "insert into reserves values(64, 102, '2018-09-08')";
            	   sqlr[9] = "insert into reserves values(74, 103, '2018-09-08')";
            	   for(int i=0; i<sqlr.length; i++)
            		   stmt.executeUpdate(sqlr[i]);
            	   
            	   //Selecting queries
            	   //The strings all have \n at the end of the line because I copied
            	   //a ton of the solutions I came up with from SQL workbench
            	   //and when you copy from the program into eclipse it keeps the endline statements
            	   
            	   //Question 1
            	   //Q1:  Find the name of all sailors who have reserved red boats but not green boats, before June 1, 2018.

            	   Statement s = conn.createStatement ();
            	   s.executeQuery("SELECT DISTINCT s.sname \n" + 
            	   		"FROM BoatRental.sailors s, BoatRental.boats b, BoatRental.reserves r\n" + 
            	   		"WHERE s.sid = r.sid AND b.bid = r.bid AND r.day < '20180601' \n" + 
            	   		"AND b.color = 'red' AND s.sid NOT IN\n" + 
            	   		"(SELECT DISTINCT s.sid\n" + 
            	   		"FROM BoatRental.sailors s, BoatRental.boats b, BoatRental.reserves r\n" + 
            	   		"WHERE s.sid = r.sid AND b.bid = r.bid AND r.day < '20180601' \n" + 
            	   		"AND b.color = 'green' );");
            	   ResultSet rs = s.getResultSet();
            	   while(rs.next()) {
            		   System.out.println(rs.getString("sname"));
            	   }
            	   
            	   System.out.println("End of Question 1");
            	   
            	   //Question 2
            	   //Q2:  Find the names of sailors who never reserved a red boat. 

            	   s.executeQuery("SELECT DISTINCT s.sid, s.sname\n" + 
            	   		"FROM BoatRental.sailors s, BoatRental.reserves r\n" + 
            	   		"WHERE s.sid = r.sid AND s.sid NOT IN(\n" + 
            	   		"SELECT DISTINCT s.sid\n" + 
            	   		"FROM BoatRental.boats b, BoatRental.sailors s, BoatRental.reserves r\n" + 
            	   		"WHERE s.sid = r.sid AND b.bid = r.bid AND b.color = 'Green')");
            	   rs = s.getResultSet();
            	   while(rs.next()) {
            		   System.out.println("Question 2: " + rs.getString("sname"));
            	   }
            	   System.out.println("End of Question 2");
            	   
            	   //Question 3
            	   //Q3:  Find sailors whose rating is better than all the sailors named Horatio. 
            	   // There are 2 sailors named Horatio, one has a higher rating than the other 
            	   // so it is logical to assume that one Horatio should be included.
            	   // also I assumed that just the names of the sailors were wanted.

            	   s.executeQuery("SELECT DISTINCT s.sname, s.sid\n" + 
            	   		"FROM BoatRental.sailors s \n" + 
            	   		"WHERE s.rating > (\n" + 
            	   		"SELECT min(s.rating)\n" + 
            	   		"FROM BoatRental.sailors s\n" + 
            	   		"WHERE s.sname = 'Horatio');");
            	   rs = s.getResultSet();
            	   while(rs.next()) {
            		   System.out.println("Question 3: " + rs.getString("sname"));
            	   }
            	   System.out.println("End of Question 3");
            	   
            	   //Question 4
            	   //Q4:  Find the names of sailors who have reserved all the boats.

            	   s.executeQuery("SELECT s.sname \n" + 
            	   		"FROM BoatRental.sailors s\n" + 
            	   		"WHERE NOT EXISTS \n" + 
            	   		"(SELECT b.bid\n" + 
            	   		"FROM BoatRental.boats b\n" + 
            	   		"WHERE NOT EXISTS\n" + 
            	   		"(SELECT r.bid\n" + 
            	   		"FROM BoatRental.reserves r\n" + 
            	   		"WHERE r.bid = b.bid AND r.sid = s.sid));");
            	   rs = s.getResultSet();
            	   while(rs.next()) {
            		   System.out.println("Question 4: " + rs.getString("sname"));
            	   }
            	   System.out.println("End of Question 4");
            	   
            	   //Question 5
            	   //Q5:  Find the name of the sailors who have made the maximum number of 
            	   //reservations among all sailors who have reserved red boats.
            	   // My answer is pretty meh

            	   s.executeQuery("SELECT d.sname\n" + 
            	   		"FROM(\n" + 
            	   		"SELECT c.sname, COUNT(c.sid) AS occr\n" + 
            	   		"FROM(\n" + 
            	   		"SELECT s.*\n" + 
            	   		"FROM BoatRental.sailors s, BoatRental.boats b, BoatRental.reserves r\n" + 
            	   		"WHERE s.sid = r.sid AND b.bid = r.bid AND b.color = 'red') c\n" + 
            	   		"GROUP BY c.sid\n" + 
            	   		"ORDER BY occr DESC) d\n" + 
            	   		"WHERE d.occr = (SELECT MAX(d.occr) FROM(\n" + 
            	   		"SELECT c.sname, COUNT(c.sid) AS occr\n" + 
            	   		"FROM(\n" + 
            	   		"SELECT s.*\n" + 
            	   		"FROM BoatRental.sailors s, BoatRental.boats b, BoatRental.reserves r\n" + 
            	   		"WHERE s.sid = r.sid AND b.bid = r.bid AND b.color = 'red') c\n" + 
            	   		"GROUP BY c.sid\n" + 
            	   		"ORDER BY occr DESC) d )");
            	   rs = s.getResultSet();
            	   while(rs.next()) {
            		   System.out.println("Question 5: " + rs.getString("sname"));
            	   }
            	   System.out.println("End of Question 5");
            	   
            	   
            	   rs.close();
            	   s.close();
            	   
            	   //	CLOSING CONNECITON
                   conn.close ();
                   System.out.println ("Database connection terminated");
			   }catch (Exception e) {System.err.println(e);}
		   }
	   }
   }
}

