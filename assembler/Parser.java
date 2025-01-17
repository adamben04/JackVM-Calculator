/* 
	Parser.java
 */

/** The main function of the parser is to break each assembly command into its
	underlying components (fields and symbols). **/
import java.io.File;
import java.io.FileNotFoundException; 
import java.util.Scanner;


public class Parser
{
	String data;
	private Scanner myReader;
	
	// This enum will be used to identify that type of the current command.
	
	public enum Command { L_COMMAND, A_COMMAND, C_COMMAND, INVALID_COMMAND }
	static Command currentCommand;
	
	
	/* The constructor opens the input file/stream and gets ready to parse it.
		In our implementation, it is recommended that we open the file, transfer
		all of its contents into an array with each element containing a line
		of the file and close the file. This will make doing multiple passes
		a little easier*/
	public Parser(String fileName) throws Exception {
		try {
      		File myObj = new File(fileName);
      		myReader = new Scanner(myObj);
    	} 	
    	catch (FileNotFoundException e) {
      		System.out.println("An error occurred.");
      		e.printStackTrace();
      	}
      	
	}
	
	/* hasMoreCommands will do a look-ahead scan of lines of code to see if there
		are any more lines with valid commands.*/
	public boolean hasMoreCommands() {
			
		while(myReader.hasNextLine()) {
		
			data = myReader.nextLine();
			data=data.replaceAll(" ","");
			data=data.replaceAll("	","");
			if(data.equals("")||data.charAt(0)=='/'){
				continue;	
			}
			if(data.contains("//"){
				data=data.substring(0,"//");
			System.out.println(data);
			return true;
		}
		
		myReader.close();
		
		return false;
	}
	
	/* advance is functionally similar to hasMoreCommands in that it will proceed
		to the next valid command and prepare to parse the line.*/
	public void advance() {
	
	}
	
	/* Returns the type of the current command. These values are defined as
		static variables.*/
	public Command commandType() {
		// if we have an A-Instruction
		if (data.charAt(0)=='@') currentCommand=Command.A_COMMAND;
		// if we have an L-Instruction
		else if(data.charAt(0)=='(') currentCommand=Command.L_COMMAND;
		// if we have an C-Instruction
		else currentCommand=Command.C_COMMAND;
		return currentCommand;
		
	}
	
	/* Returns the symbol or decimal Xxx of the current command @Xxx or (Xxx).
		In the first iteration of the program symbol resolution will not be
		implemented.*/
	public String symbol() 
	{
		if(data.charAt(0)=='@') return data.substring(1);
		return data.substring(1,data.length()-1);
	}
	
	/* Returns the destination portion of the current command. */
	public String dest()
	{
		if (data.contains("=")) return data.substring(0,data.indexOf("="));
		return "";
	}
	
	/* Returns the computation portion of the current command. */
	public String comp()
	{
		String a="";
		if(data.contains("=")){
			if(data.contains(";")){
				a=data.substring(data.indexOf("=")+1,data.indexOf(";"));
			}
			else{
				a=data.substring(data.indexOf("=")+1);
			}
		
		}
		else a=data.substring(0,data.indexOf(";"));
		
		return a;
	}
	
	/* Returns the jump portion of the current command. */
	public String jump()
	{
		if(data.contains(";")) return data.substring(data.indexOf(";")+1);
		return "";
	}
}