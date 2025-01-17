/* 
	Assembler.java
 */

import java.io.*;

/** Assembler will serve as the central class that will call all other methods
	as needed. It will house the instances of the other classes. **/

public class Assembler
{
	// Static variables section
	static int debugLevel = 10;
	private int lineNumber = 0;
	
	public static void main(String[] args) {
		Debug debugger = new Debug();
		Coder myCoder = new Coder();
		
		// We make sure that a file has been specified or we give an error and exit
		if (args.length == 0) {
			System.out.println("Error: Filepath required");
			return;
		}
		String fileName = args[0];
		
		// With the filename defined, extract everything before the .asm suffix
		// to get the base of the filename. This will be used to create an output file

		String newName = fileName.substring(0, fileName.indexOf('.')) + ".hack";
		
		try {
			// Create a new Parser object sending in the input filename. This must be
			// in a try block as there is the potential for a IOException when dealing
			// with the file system
			Parser myParser = new Parser(fileName);
			
			// Create a new file for output. File to be named same as input file except with the
			// extension of .hack
			
			FileWriter writer = new FileWriter(newName);

			
			
			while (myParser.hasMoreCommands()) {
			
				if (myParser.commandType() == Parser.Command.A_COMMAND)
				{
					// Process an A_Command and write to output file
					System.out.println("We have an A command");
					String inSymbol = myParser.symbol();
					System.out.println(inSymbol);
					String aCommand="0"+myCoder.symbol(inSymbol);
					System.out.println(aCommand); // Binary A
					writer.write(aCommand+"\n");
					
				}
				if (myParser.commandType() == Parser.Command.C_COMMAND)
				{
					// Process the C_Command by using a Coder object to translate into binary
					// and write to the output file
					System.out.println("We have an C command");
					 
					System.out.print("111");
					System.out.print(myCoder.comp(myParser.comp()));
					System.out.print(myCoder.dest(myParser.dest()));
					System.out.println(myCoder.jump(myParser.jump()));
					String cCommand="111"+myCoder.comp(myParser.comp())+myCoder.dest(myParser.dest())+myCoder.jump(myParser.jump());
					writer.write(cCommand+"\n");
					
				}
				
				
				// Advance to the next available command
				myParser.advance();
			}
			
			// Close the output file
			writer.close();
			
		}

		catch (Exception e) {
			System.out.println("Error " + e.getMessage());
		}
	}
}