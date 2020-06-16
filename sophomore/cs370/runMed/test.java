import java.util.*;
public class test{
    public static void main(String[] args){
        PriorityQueue<Integer> hi = new PriorityQueue<>(Collections.reverseOrder());
        hi.add(1);
        hi.add(2);
        System.out.println(hi.toString());
        hi.add(3);
        hi.add(4);
        hi.add(5);
        hi.add(6);
        System.out.println(hi.toString());
        hi.add(7);
        hi.add(8);
        hi.add(9);
//       hi.add(-1);
        hi.add(10);
        System.out.println(hi.toString());
    }   
}
