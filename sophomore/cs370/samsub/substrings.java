import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class substrings {

    static BigInteger substrings(String balls) {
        BigInteger answer = new BigInteger("0");
        for(int i=0; i<balls.length(); i++)
        {
            for(int j=i+1; j<=balls.length(); j++)
            {
                answer = answer.add(new BigInteger(balls.substring(i,j)));
            }
        }
        
        return answer;
    }

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        String balls = in.next();
        BigInteger result = substrings(balls);
        System.out.println(result.mod(BigInteger.valueOf(1000000007)));
        in.close();
    }
}

