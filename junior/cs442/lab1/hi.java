//I could only get this to work in eclipse because you need
//the connector/j jar file from the sql website. If I wasn't lazy
//the jar should be included near this file somewhere.

import java.sql.*;
 
public class hi {
   // JDBC driver name and database URL
   static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver"; 
   static final String DB_URL = "jdbc:mysql://localhost:3306/test?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
 
   //  Database credentials
   static final String USER = "root";
   //the user name;
   static final String PASS = "root";
   //the password;
  
   public static void main(String[] args) {
   Connection conn = null;
   Statement stmt = null;
   try{
      //STEP 1: Register JDBC driver
      Class.forName("com.mysql.cj.jdbc.Driver");
 
      //STEP 2: Open a connection
      System.out.println("Connecting to database...");
      conn = DriverManager.getConnection(DB_URL, USER, PASS);
 
 
   }catch (Exception e)
           {
               System.err.println ("Cannot connect to database server");
               System.err.println(e);
           }
           finally
           {
               if (conn != null)
               {
                   try
                   {
                	   stmt = conn.createStatement();
                	   String sql = "DROP DATABASE VehicleOffice";
                	   stmt.executeUpdate(sql);
                	   System.out.println("Database deleted successfully...");
                	   
                	   sql = "CREATE DATABASE VehicleOffice";
                	   stmt.executeUpdate(sql);
                	   sql = "use VehicleOffice";
                	   stmt.executeUpdate(sql);
                	   sql = "create table branch( branch_id integer not null PRIMARY KEY, " +
                               "branch_name varchar(20) not null," +
                               "branch_addr varchar(50)," +
                               "branch_city varchar(20) not null," +
                               "branch_phone integer)";
                	   stmt.executeUpdate(sql);
                	   sql = "insert into branch values(10, 'Main', '1234 Main St.', 'Hoboken', 5551234)";
                	   String sql2 = "insert into branch values(20, 'NYC', '23 No.3 Road', 'NYC', 5552331)";
                	   String sql3 = "insert into branch values(30, 'West Creek', '251 Creek Rd.', 'Newark', 5552511)";
                	   String sql4 = "insert into branch values(40, 'Blenheim', '1342 W.22 Ave.', 'Princeton', 5551342)";
                	   stmt.executeUpdate(sql);
                	   stmt.executeUpdate(sql2);
                	   stmt.executeUpdate(sql3);
                	   stmt.executeUpdate(sql4);
                	   // 	Driver
                	   sql = "create table driver( driver_ssn integer not null PRIMARY KEY, " +
                			   "driver_name varchar(20) not null," + 
                			   "driver_addr varchar(50)," +
                			   "driver_city varchar(20) not null," + 
                			   "driver_birthdate date," +
                			   "driver_phone integer)";
                	   stmt.executeUpdate(sql);
                	   sql = "insert into driver values(11111111, 'Bob Smith', '111 E.11 st.', 'Hoboken', '1975-01-01', 5551111)";
                	   sql2 = "insert into driver values(22222222, 'John Walters', '111 E.11 st.', 'Hoboken', '1975-01-01', 5551111)";
                	   sql3 = "insert into driver values(33333333, 'Troy Rops', '111 E.11 st.', 'Hoboken', '1975-01-01', 5551111)";
                	   sql4 = "insert into driver values(44444444, 'Kevin Mark', '111 E.11 st.', 'Hoboken', '1975-01-01', 5551111)";
                	   stmt.executeUpdate(sql);
                	   stmt.executeUpdate(sql2);
                	   stmt.executeUpdate(sql3);
                	   stmt.executeUpdate(sql4);
                	   sql = "create table license( license_no integer not null," +
                			   "driver_ssn integer not null," +
                			   "license_type char," +
                			   "license_class integer," +
                			   "license_expiry date," +
                			   "issue_date date," +
                			   "branch_id integer not null,"+
                			   "PRIMARY KEY(license_no)," +
                			   "FOREIGN KEY(driver_ssn) references driver(driver_ssn)," + 
                			   "FOREIGN KEY(branch_id) references branch(branch_id))";
                	   stmt.executeUpdate(sql);
                	   sql = "insert into license values(1, 11111111, 'D', 5, '2022-05-24', '2017-05-25', 20)";
                	   sql2 = "insert into license values(2, 22222222, 'D', 5, '2023-08-29', '2016-08-29', 40)";
                	   sql3 = "insert into license values(3, 33333333, 'L', 5, '2022-12-27', '2017-06-27', 20)";
                	   sql4 = "insert into license values(4, 44444444, 'D', 5, '2022-08-30', '2017-08-30', 40)";
                	   stmt.executeUpdate(sql);
                	   stmt.executeUpdate(sql2);
                	   stmt.executeUpdate(sql3);
                	   stmt.executeUpdate(sql4);
                	   sql = "create table exam( driver_ssn integer not null," +
                			   "branch_id integer not null," +
                			   "exam_date date not null," +
                			   "exam_type char," +
                			   "exam_score integer," +
                			   "PRIMARY KEY(driver_ssn, branch_id, exam_date)," +
                			   "FOREIGN KEY(branch_id) references branch(branch_id)," +
                			   "FOREIGN KEY(driver_ssn) references driver(driver_ssn))";
                	   stmt.executeUpdate(sql);
                	   sql = "insert into exam values(11111111, 20, '2017-05-25', 'D', 79)";
                	   sql2 = "insert into exam values(11111111, 20, '2017-12-02', 'L', 67)";
                	   sql3 = "insert into exam values(22222222, 30, '2016-05-06', 'L', 25)";
                	   sql4 = "insert into exam values(22222222, 40, '2016-06-10', 'L', 51)";
                	   stmt.executeUpdate(sql);
                	   stmt.executeUpdate(sql2);
                	   stmt.executeUpdate(sql3);
                	   stmt.executeUpdate(sql4);
                	   sql = "insert into exam values(22222222, 40, '2016-08-29', 'D', 81)";
                	   sql2 = "insert into exam values(33333333, 10, '2017-07-07', 'L', 45)";
                	   sql3 = "insert into exam values(33333333, 20, '2017-06-27', 'L', 49)";
                	   sql4 = "insert into exam values(33333333, 20, '2017-07-27', 'L', 61)";
                	   stmt.executeUpdate(sql);
                	   stmt.executeUpdate(sql2);
                	   stmt.executeUpdate(sql3);
                	   stmt.executeUpdate(sql4);
                	   sql = "insert into exam values(44444444, 10, '2017-07-27', 'L', 71)";
                	   sql2 = "insert into exam values(44444444, 20, '2017-08-30', 'L', 65)";
                	   sql3 = "insert into exam values(44444444, 40, '2017-09-01', 'L', 62)";
                	   stmt.executeUpdate(sql);
                	   stmt.executeUpdate(sql2);
                	   stmt.executeUpdate(sql3);
                	   
                	   Statement s = conn.createStatement ();
                	   s.executeQuery ("SELECT branch_id, branch_name, branch_addr FROM branch");
                	   ResultSet rs = s.getResultSet ();
                	   int count = 0;
                	   while (rs.next ())
                	   {
                	       int idVal = rs.getInt ("branch_id");
                	       String nameVal = rs.getString ("branch_name");
                	       String addrVal = rs.getString ("branch_addr");
                	       System.out.println (
                	               "id = " + idVal
                	               + ", name = " + nameVal
                	               + ", address = " + addrVal);
                	       ++count;
                	   }
                	   System.out.println (count + " rows were retrieved");
                	   s.executeQuery("SELECT DISTINCT driver_name FROM driver d, branch b, license l WHERE d.driver_ssn = l.driver_ssn AND l.branch_id = b.branch_id AND branch_name = 'NYC'");
                	   rs = s.getResultSet();
                	   while(rs.next()) {
                		   System.out.println("Licenses from NYC driver_name: " + rs.getString("driver_name"));
                	   }
                	   s.executeQuery("SELECT DISTINCT driver_name FROM driver d, license l WHERE d.driver_ssn = l.driver_ssn AND l.license_expiry < '20221231'");
                	   rs = s.getResultSet();
                	   while(rs.next()) {
                		   System.out.println("Licenses expiring before 12-31-2022 driver_name: " + rs.getString("driver_name"));;
                	   }
                       rs = s.getResultSet();
                       s.executeQuery("SELECT DISTINCT driver_name FROM VehicleOffice.driver d, VehicleOffice.exam e WHERE  d.driver_ssn = e.driver_ssn AND e.exam_type IN ( SELECT e2.exam_type FROM VehicleOffice.exam e2 WHERE d.driver_ssn = e2.driver_ssn  AND e.exam_type = e2.exam_type AND e.branch_id = e2.branch_id GROUP BY e2.exam_type HAVING COUNT(e2.exam_type) >1)");
                       rs = s.getResultSet();
                	   while(rs.next()) {
                		   System.out.println("Drivers who took 2 exams driver_name: " + rs.getString("driver_name"));;
                	   }
											//Don't look at this it works but it's a brute force method
                	   s.executeQuery("SELECT DISTINCT driver_name FROM VehicleOffice.driver \n" + 
                	   		"WHERE driver_name NOT IN (SELECT driver_name FROM VehicleOffice.exam \n" + 
                	   		"AS a JOIN VehicleOffice.exam AS b ON a.driver_ssn = b.driver_ssn AND\n" + 
                	   		" a.exam_date > b.exam_date AND a.exam_score > b.exam_score \n" + 
                	   		" AND a.exam_type = b.exam_type OR a.exam_type = 'D', \n" + 
                	   		" VehicleOffice.driver d WHERE a.driver_ssn = d.driver_ssn )");
                	   rs = s.getResultSet();
                	   while(rs.next()) {
                		   System.out.println("Drivers whose exam scores got worse driver_name: " + rs.getString("driver_name"));;
                	   }
                	   rs.close ();
                	   s.close ();
                	   
                	   //	CLOSING CONNECITON
                       conn.close ();
                       System.out.println ("Database connection terminated");
                       
                   }
                   catch (Exception e) { System.err.println(e); }
               }
           }
       }
   }

