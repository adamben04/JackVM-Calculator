
import java.io.*;
import java.nio.*;
import java.util.*;

class JackTokenizer {
	
	Scanner scanner;
	FileWriter myWriter;
	String digits = "0123456789";
	String symbols = "+-*/&|<>=-~()[]{},.;";
	String characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_";
	String whiteSpace = " \t";
	String quote = "\""; 
	String allIdentifiers = digits + characters;
	String keyWords = " class constructor function method field static var int char boolean void true false null this let do if else while return ";
	boolean inComment = false;
	boolean outXML = false;
	String text;
	int index;
	int i;
	String currentToken;
	
	public enum TokenType{
		KEYWORD, SYMBOL, IDENTIFIER, INT_CONST, STRING_CONST
	}
	
	// ADD KEYWORD CONSTANT
	// ADD KEYWORD CONSTANT// ADD KEYWORD CONSTANT// ADD KEYWORD CONSTANT
	// ADD KEYWORD CONSTANT
	// ADD KEYWORD CONSTANT
	String[] theTypes = {"keyword","symbol","identifier","integerConstant", "stringConstant"};
	
	TokenType currentType;
	
	/* Declare state variables for storing the tokenType, currentIdentifier, currentInteger
		currentString and currentKeyword
		
		Create lookups for the different types (valid keywords, integer characters, starting
		identifier characters, identifier characters and symbols) */

	/** The constructor will open the inputFile and read all of the lines into
		an array for processing. The file can then be closed. **/
		String[] processor;
		
	public JackTokenizer(String inputFile) throws IOException{
		
		scanner = new Scanner(new File(inputFile));

        // name for output file
       	String name = inputFile.substring(0,(inputFile.indexOf(".")))+"L.xml";	
       	
       	// make new output file and create file writer
       	File file = new File(name);
       	myWriter = new FileWriter(file);
       	
		text = scanner.nextLine();
		i=0;
       	
//       	parse();
//       	while (scanner.hasNextLine()) {
//			myWriter.write(scanner.nextLine() + "/n");
//		}
//		myWriter.close();
	}

	/** hasMoreTokens() may not be necessary. If we assume that we have valid
		Jack code, the recursive nature of the compiler along with the 
		advance() method would handle all of the needed cases. We leave
		hasMoreTokens() for now and assess the need for it over time. **/
	
	/** JackTokenizer initially has no current token. Advance will walk through
		the code looking for tokens and setting parameters for type and token
		based on what is found. 
		
		Walking through the code should entail keeping two cursors. One tracks
		the current line number and the other tracks the character position on the 
		line. **/
	public void advance() {
	
		// Skip blank lines (advance to the next line)
		
		// Filter out single line comments from the current line of code starting from
		// the "//" comment start to the end of the line
		
		// Skip multi-line comments. Set ML-comment mode and keep advancing cursors until 
		// the "*/" delimiter is found.
		
		// We know that we are either at the end of the file or the start of a valid token
		// is pointed to by the character cursor. We call the private parse() method to 
		// extract the token.
		
		char currentLetter;
		
		currentLetter = text.charAt(i);
		
		//Checks if is string
		if(quote.contains(currentLetter+"")){
			//For the first run through, currentLetter would just be one quote. "
			currentToken = "";
			if(currentToken.length() == 0){
				i++;
				currentLetter = text.charAt(i);
			}
			while(currentLetter != '\"') {
				currentToken += currentLetter +"";
				i++;
				currentLetter = text.charAt(i);
			}
			parseString();
			i++;
		}
		
		// Check if is symbol
		else if(symbols.contains(currentLetter+"")){
			currentToken = currentLetter+"";
			parseSymbol();
			i++;
		}	
		
		// Check if is an integer
		else if(digits.contains(currentLetter+"")){
			currentToken = "";
			while(digits.contains(currentLetter+"")){
				currentToken += currentLetter+"";
				i++;
				currentLetter = text.charAt(i);
			}
			parseInt();
		}
		// Check if is character
		else if(characters.contains(currentLetter+"")){
			currentToken = "";
			while(allIdentifiers.contains(currentLetter+"")){
				currentToken += currentLetter+"";
				i++;
				currentLetter = text.charAt(i);
			}
			parseIdentifier();
		}

	}
	
	public void printXML() {
		System.out.print("<" + theTypes[currentType.ordinal()] + ">");
		System.out.print(currentToken);
		System.out.println("</" + theTypes[currentType.ordinal()] + ">");
	}
	
	/** The parse method will look at the current character. It then passes control to the
		appropriate parsing method. **/
	public boolean hasMoreTokens(){
		char currentLetter;
		boolean inComment = false;
		
		// Skip blank lines
		while(i>=text.length()) {
			if(scanner.hasNextLine()){
				text = scanner.nextLine();
				i=0;
			}
		}
		
		// parsing letters
		while(i<text.length()){
		
			currentLetter = text.charAt(i);
			if (!inComment) {
				// Check if single line comment
				if(currentLetter=='/'){
					char nextLetter = text.charAt(i+1);

					if(nextLetter=='/'){
						i=text.length();
					}
					
					else if(nextLetter=='*'){
					
						inComment = true;
						i++;
						continue;
					} else{
						return true;
					}
				}
				// Skip whitespace
				else if(whiteSpace.contains(currentLetter+"")){
					i++;
					continue;
				}
				
				//Checks if is string
				else if(quote.contains(currentLetter+"")){
					return true;
				}
				
				// Check if is symbol
				else if(symbols.contains(currentLetter+"")){
					return true;
				}	
				
				// Check if is an integer
				else if(digits.contains(currentLetter+"")){
					return true;
				}
				
				// Check if is character
				else if(characters.contains(currentLetter+"")){
					return true;
				}
			} else {	// We must be in a multi-line comment			
				if(currentLetter == '*'){
					if(i+1<text.length()){
						currentLetter = text.charAt(++i);
						if(currentLetter == '/'){
							inComment = false;
						}
					}
				}
				i++;
			}
			
			while(i>=text.length()) {
				if(scanner.hasNextLine()){
					text = scanner.nextLine();
					i=0;
				}
			}
		}
		return false;
	}
	
	private void parseInt() {
		
		// Set the token type
		currentType = TokenType.INT_CONST;
		
		
		if(outXML) {
			System.out.print("<int>");
			System.out.print(currentToken);
			System.out.println("</int>");
		}
		// Walk through each character. As long as we have an integer value, accumulate
		// the value into the current int variable
	}
	
	private void parseIdentifier() {
		
		
		currentType = TokenType.IDENTIFIER;
			
		
		if(keyWords.contains(" "+currentToken+" ")){
			currentType = TokenType.KEYWORD;
		
			if(outXML) {
				System.out.print("<keyword>");
				System.out.print(currentToken);
				System.out.println("</keyword>");
			}
			
			return;
		}
					
		if(outXML) {
			System.out.print("<identifier>");
			System.out.print(currentToken);
			System.out.println("</identifier>");
		}

		
		
		// Walk through each character. As long as we have a valid character, append it
		// to a string holder. 
		
		// Compare the string to the valid keywords
		
		// If we have a keyword, set the token type and keyword
		
		// If we do not have a keyword, we have an identifier. Set the token type
		// and identifier state value.
	
		return;
	}
	
	private void parseString() {
	
		currentType = TokenType.STRING_CONST;
	
		
		if(outXML) {
			System.out.print("<stringConstant>");
			System.out.print(currentToken);
			System.out.println("</stringConstant>");
		}
		// Set the token type
		
		// The first character is a quote. Skip past and append every character to a string
		// until the ending quote is encountered.
		
		// Set the string state value to the collected string.
		
		// Advance the character cursor past the closing quote.	
	}
	
	private void parseSymbol() {
	
		// Set the token type
		currentType = TokenType.SYMBOL;
		
		if(outXML) {
			System.out.print("<symbol>");
			System.out.print(currentToken);
			System.out.println("</symbol>");
		}

		// Set the current symbol state variable
	}
	
	public TokenType tokenType() {
	
		return currentType;
	}
	
	public String token() {
		return currentToken;
	}
	
	public int keyWord() {
		return 0;
	}
	
//	public char symbol() {
//		if(tokenType()==SYMBOL){
//			
//		}
//	}
	
	public String identifier() {
		return "";
	}
	
	public int intVal() {
		return 0;
	}
	
	public String stringVal() {
		return "";
	}
}



