import java.io.*;
import java.nio.*;
import java.util.*;


class JackAnalyzer {
	
	/* Stage 1 wants us to test the tokenizer. To do this, create a JackTokenizer
		object and advance through every token. For each token, print out a line
		of XML output as defined in Section 10.5 Stage 1.
			*/ 
	public static void main (String[] args) {
		// Check that we have an argument, otherwise, error out
		
		if(!args[0].endsWith(".jack")){
			try{
				File[] files = new File(args[0]).listFiles();
				for (File file : files){
					if(!file.getName().endsWith(".jack")){
						continue;
					}

					String name = file.getName();
					processTokenizer(name);
				}
			}		
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else{
			try{
				//String name = (args[0]).substring(0,(args[0].indexOf(".")))+"L.xml";			
				

				processTokenizer(args[0]);
			}		
			catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	// was second argument: String outputFilename
	private static void processTokenizer (String sourceFilename)  throws IOException{
		// Create a tokenizer based on the source file
		
		String outFileName = sourceFilename.replace(".jack",".xml");
		CompilationEngine engine = new CompilationEngine(sourceFilename,outFileName);
		
		// Close the output file
	}
	
	private static void printToken(JackTokenizer jc) {
//		// Print the opening tag based on the token type
//		
//		// Print the value of the tag
//		
//		// Print the closing of the tag based on the token type
	}
//


	/* Stage 2 is to complete the parser. This will use recursion to traverse down
		a tree. At the top-most level, we will need to call compileClass. This will
		call other compile methods that will recursively call others. This means that
		our process method only need to call a single compile method.
			*/ 
	private static void process (String sourceFilename, String outputFilename) {
		// Create a new CompilationEngine using the source and destination file paths
		
		// Call compileClass on the CompilationEngine
		
		/* Note: Section 10.3.3 does not mention the need for a close() method.
			This is either an oversight or it is expected that the class is 
			self-rectifying in this regard. As compileClass() must be called
			next after the constructor, closing outputFile could occur in the 
			final stages of compileClass(). 
			
			Recommended process would be to allow JackAnalyzer to have control over
			when the CompilationEngine will close the outputFile. */
	}
}