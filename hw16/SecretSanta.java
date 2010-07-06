import java.util.*;

/* Name: Secret Santa
 * Assignment: hw16
 * Description: This program is designed to take the names and email addresses of participants from a user 
 *   and then choose a Secret Santa for every person in the list. Santas are selected with the
 *   condition that someone's Santa is not part of his/her family. Each Santa is emailed
 *   with the name of their future gift recipient. 
 * Author: Murtaza Jafferj
 * 
 */

// a person class to manage participant data
public class SecretSanta{
	private static List<Person> people_array = new ArrayList<Person>();
	
	public static void ask(){ 
		System.out.println("Enter the data (type \"done\" when finished)");
		System.out.println ("FIRST_NAME space FAMILY_NAME space <EMAIL_ADDRESS> newline"); 
	}

	public static void parse(){
		boolean flag = true;
		while (flag){
			Scanner input = new Scanner(System.in);
			String line = input.nextLine();
			if (line.toLowerCase().equals("done")){
				flag = false;
			}else{
				String[] split_line;
				split_line = line.trim().split("\\s+"); //splits the line into an array of its components
				Person person = new Person(split_line[0], split_line[1], split_line[2]);
				people_array.add(person);
			}
		}
	}
	
	// returns true if a randomly sorted second array is ordered in such a way that corresponding 
	// indices with the first array match two people without the same last name 
	public static boolean match(List<Person> pairs){
		for (int i = 0; i < people_array.size(); i++){
			if (people_array.get(i).lname.toLowerCase() == pairs.get(i).lname.toLowerCase()){
				return false;
			}
		}
		return true;
	}
	
	// randomly sort until an acceptable ordering is found
	public static List<Person> get_result(){
		List<Person> pairs = new ArrayList<Person>();
		for (int i = 0; i < people_array.size(); i++){
			pairs.add(people_array.get(i));
		}
		Collections.shuffle(pairs); //creates a new array of participants in a random ordering
		while (match(pairs) == false){ 
			Collections.shuffle(pairs);
		}
		return pairs;
	}

	// prints each Santa's name with their future gift recipient
	public static void print_pairs(List<Person> pairs){
		for (int i = 0; i < people_array.size(); i++){
			System.out.println(people_array.get(i).fname + " " + people_array.get(i).lname + " is " + pairs.get(i).fname + " " + pairs.get(i).lname + "'s Secret Santa.");
		}
	}

	public static void main(String[] args){
		ask();
		parse();
		print_pairs(get_result());
	}
}