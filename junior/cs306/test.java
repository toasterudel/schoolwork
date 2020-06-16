import java.io.File;
import java.io.FileNotFoundException;
import java.util.Map;
import java.util.HashMap;
import java.util.Scanner;
class test
{
	public static void main(String[] args)
	{
		Map<Character, Integer> letters = new HashMap<>();
		File file = new File("ciphertext1.txt");
		try {
		Scanner sc = new Scanner(file);
		String[] lines = new String[4];
		double total = 0;
		for(int i=0; sc.hasNextLine(); i++)
		{
			lines[i] = sc.nextLine();
		}
		/*
		for(int i=0; i<lines.length; i++)
			System.out.println(lines[i]);
*/
		for(int i=0; i<lines.length; i++)
		{
			for(int j=0; j<lines[i].length(); j++)
			{
				total++;
				if(letters.containsKey(lines[i].charAt(j)))
					letters.put(lines[i].charAt(j), letters.get(lines[i].charAt(j)) + 1);
				else
					letters.put(lines[i].charAt(j), 1);
			}
		}

		System.out.println("Total: " + total);
		for (Character name: letters.keySet()){
			String key = name.toString();
			String value = letters.get(name).toString();
			double percent = Double.parseDouble(value) / total;
			System.out.print(key + " " + value + " ");
			System.out.printf("%.4f", percent*100);		
			System.out.println("%");
			}
//			printGuess(lines);
			sc.close();
		} catch (FileNotFoundException error) {
			error.printStackTrace();
		}
	}


	static void printGuess(String[] guess)
	{
		String[] rep = guess;
		for(int i=0; i<guess.length; i++)
		{
			rep[i] = rep[i].replaceAll("0", " ");
			rep[i] = rep[i].replaceAll("1", "e");
			rep[i] = rep[i].replaceAll("4", "t");
			rep[i] = rep[i].replaceAll("5", "a");
			rep[i] = rep[i].replaceAll("2", "o");
			System.out.println(rep[i]);
		}
	}
}
