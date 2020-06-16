/*
 *   Version 1
 *
 *   Name is "printAmountOwed" but method (1) prints and
 *   (2) calculates for (3) both current and prior orders.
 *
 *   
 */
 void printAmountOwed(double balance) {

     Enumeration e = _orders.elements();
     double outstanding = 0.0;

     System.out.println("***********************");
     System.out.println("***  Customer owes  ***");
     System.out.println("***********************");

     while (e.hasMoreElements()) {
         Order order = (Order) e.nextElement();
         outstanding += order.getAmount();
     }

     System.out.println("name: " + _name);
     System.out.println("amount = " + (balance + outstanding));
 }
/*
*   Version 2
*/

static double getOwed(double balance){
    Enumeration e = _orders.elements();
    double outstanding = 0.0;
    
    while (e.hasMoreElements()){
        Order order = (Order) e.nextElement();
        outstanding += order.getAmount();
    }
    
    return balance + outstanding;
}

void newPrintAmountOwed(double balance){
     double owed = getOwed(balance);
     System.out.println("***********************");
     System.out.println("***  Customer owes  ***");
     System.out.println("***********************");
     System.out.println("name: " + _name);
     System.out.println("amount = " + owed);
}
