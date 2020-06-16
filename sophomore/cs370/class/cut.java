import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class cut {
    static int[] getMaxPos(ArrayList<Integer> arr)
    {
        int sol = -1;
        int i;
        for(i=0; i<arr.size(); i++)
        {
                if(arr.get(i)>sol)
                sol=arr.get(i);
        }
        int[] ret = {sol,i-1};
        return ret;
    }

    static int boardCutting(int[] cost_y, int[] cost_x) 
    {
        int horiCuts = 1;
        int vertCuts = 1;
        int totalCost = 0;
        ArrayList<Integer> hori = new ArrayList<>();
        ArrayList<Integer> vert = new ArrayList<>();
        for(int i=0; i<cost_x.length; i++)
            hori.add(cost_x[i]);
        for(int i=0; i<cost_y.length; i++)
            vert.add(cost_y[i]);
        for(int i=0; i<cost_y.length + cost_x.length; i++)
        {
            if(hori.isEmpty())
            {
                int[] ma = getMaxPos(vert);
                totalCost += ma[0] * horiCuts;
                int num = ma[1];
                vert.remove(num);
                vertCuts++;                
            }
            else if(vert.isEmpty())
            {
                int[] ma = getMaxPos(hori);
                totalCost += ma[0] * vertCuts;
                int num = ma[1];
                hori.remove(num);
                horiCuts++;
            }
            
            else
            {
                if(Collections.max(hori) >= Collections.max(vert))
                {
                int[] ma = getMaxPos(hori);
                totalCost += ma[0] * vertCuts;
                int num = ma[1];
                hori.remove(num);
                horiCuts++;
                }
                else
                {
                int[] ma = getMaxPos(vert);
                totalCost += ma[0] * horiCuts;
                int num = ma[1];
                vert.remove(num);
                vertCuts++;
                }
            }
        }
        return totalCost % ((int)Math.pow(10, 9)+7);
        
    }

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int q = in.nextInt();
        for(int a0 = 0; a0 < q; a0++){
            int m = in.nextInt();
            int n = in.nextInt();
            int[] cost_y = new int[m-1];
            for(int cost_y_i = 0; cost_y_i < m-1; cost_y_i++){
                cost_y[cost_y_i] = in.nextInt();
            }
            int[] cost_x = new int[n-1];
            for(int cost_x_i = 0; cost_x_i < n-1; cost_x_i++){
                cost_x[cost_x_i] = in.nextInt();
            }
            int result = boardCutting(cost_y, cost_x);
            System.out.println(result);
        }
        in.close();
    }
}

