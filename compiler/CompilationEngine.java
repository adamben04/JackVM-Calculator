import java.io.*;
import java.util.*;

/** CompilationEngine will serve as the focus for most of the compilers functionality.
	Based on the grammar delineated in section 10.3.3, each method will output XML
	and make appropriate calls to other methods. This recursive process means that 
	the caller only needs to call compileClass for each file and all other compilations 
	will occur as needed. 
	
	Note: In chapter 10, the program outputs XML. This includes markup for symbols,
			keywords, and identifiers. Making compile methods for these token types
			would be prudent.
			
		  The book's camel-case suggestions are inconsistent in section 10.3.3 with
			about half capitalizing the first letter and half leaving it lower-case.
			We will use strict camel-case.  **/

class CompilationEngine {

	boolean outXML = true;
	int tabCount;
	String[] theTypes = {"keyword","symbol","identifier","integerConstant", "stringConstant"};
	private PrintWriter printWriter;
	
	JackTokenizer tokenizer;
	
	String currentCategory;
	String currentKind;
	boolean currentDefined;
	static int currentIndex = 0;
	
	/** The CompilationEngine will create a new JackTokenizer object based on the
		inputFile and will create an output stream to outputFile. **/
	public CompilationEngine (String inputFile, String outputFile) throws IOException{
	
		/* Note: Section 10.3.3 does not mention the need for a close() method.
			This is either an oversight or it is expected that the class is 
			self-rectifying in this regard. As compileClass() must be called
			next after the constructor, closing outputFile could occur in the 
			final stages of compileClass(). */
			
		tokenizer = new JackTokenizer(inputFile);
		tabCount = 0;
		
		System.out.println(outputFile);
		
		try {
			FileWriter fileWriter = new FileWriter(outputFile);
			printWriter = new PrintWriter(fileWriter);
		}
		catch (IOException e) {
			System.out.println("Could not create file");
			return;
		}
		
		
		compileClass();
		
		printWriter.close();
	}
	
	

	/** compileClass() is the only public method. All other methods are called
		using recursive descent parsing. **/
	public void compileClass() {
		// class:	'class' className '{' classVarDec* subroutine* '}'
	
		/* The general procedure for any "compile" method is to handle each terminal
			in order according to the Jack grammar. When a non-terminal is encountered,
			a method is to be called to handle that.
			
			ie: In this method, we should encounter 3 terminals (the keyword "class",
			an identifier and the symbol '{'). We will next see a keyword related
			to classVarDec ("static" or "field") or a keyword related to subroutines
			("constructor", "function" or "method"). We loop calling compileClassVarDec()
			until we have subroutine keywords and loop calling compileSubroutine().
			We look for the closing '}', close the output file and return.  */
		
		writeXML("<class>");	
		tabCount++;
			
		// Get class keyword	
		if (tokenizer.hasMoreTokens()) {
			tokenizer.advance();
			printXMLToken();
		}
		
		// Get identifier
		if (tokenizer.hasMoreTokens()) {
			tokenizer.advance();
			printXMLToken();
			identifierInfo("class", false, "", currentIndex);
		}
		
		// Get { symbol
		if (tokenizer.hasMoreTokens()) {
			tokenizer.advance();
			printXMLToken();
		}

		
		if (tokenizer.hasMoreTokens()) {
			tokenizer.advance();
		}
		
		
		//  turn this into a while loop
		while(tokenizer.token().equals("static") || tokenizer.token().equals("field")) {
			compileClassVarDec();
		}
		
		while(tokenizer.token().equals("method") || tokenizer.token().equals("function") || tokenizer.token().equals("constructor")) {
			compileSubroutine();
		}
			
			
		// Get } symbol
		printXMLToken();
		
		//printXMLToken();
		tabCount--;
		writeXML("</class>");
	}
	
	private void writeXML(String inString) {
	
		if(outXML) {
			for(int x=0;x<tabCount;x++){
				// change to tab later
				printWriter.print(" ");
				System.out.print(" ");
			}
			printWriter.println(inString);
			System.out.println(inString);
		}
	}

	private void printXMLToken(){
		if(outXML) {
			for(int x=0;x<tabCount;x++){
				// change to tab later
				printWriter.printf(" ");
				
				System.out.printf(" ");
			}
			
			if (tokenizer.tokenType() == JackTokenizer.TokenType.SYMBOL) {
				if (tokenizer.token().equals("<"))
					writeXML("<symbol> &lt; </symbol>");
				else if (tokenizer.token().equals(">"))
					writeXML("<symbol> &gt; </symbol>");
				else if (tokenizer.token().equals('"'))
					writeXML("<symbol> &quot; </symbol>");
				else if (tokenizer.token().equals("&"))
					writeXML("<symbol> &amp; </symbol>");
				else
					writeXML("<symbol>"+ tokenizer.token()+"</symbol>");
			} else {
				printWriter.printf("<" + theTypes[tokenizer.tokenType().ordinal()] + ">");
				printWriter.printf(tokenizer.token());
				printWriter.println("</" + theTypes[tokenizer.tokenType().ordinal()] + ">");
			
				System.out.printf("<" + theTypes[tokenizer.tokenType().ordinal()] + ">");
				System.out.printf(tokenizer.token());
				System.out.println("</" + theTypes[tokenizer.tokenType().ordinal()] + ">");
			}
		}
	}
	
	private void compileClassVarDec() {
		// classVarDec:	('static' | 'field') type varName (',' varName)* ';'
		
		writeXML("<classVarDec>");
		tabCount++;
		 
		// prints "static/field"
		currentCategory = tokenizer.token();
		currentKind = tokenizer.token();
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		 
		// prints type
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		// prints varName
		printXMLToken();
		identifierInfo(currentCategory, true, currentKind, currentIndex);
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		while(tokenizer.token().equals(",")){
			// get comma
			printXMLToken();
			tokenizer.hasMoreTokens();
			tokenizer.advance();
			
			// get varName
			printXMLToken();
			tokenizer.hasMoreTokens();
			tokenizer.advance();
		}
		
		// get ";"
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		

		tabCount--;
		writeXML("</classVarDec>");		
	}
	
	/** Section 10.3.3 suggests making compileSubroutine. Figure 10.5 does not explicitly
		define subroutine but we can infer it as being a subroutine declaration 
		(subroutineDec) followed by a subroutine body (subroutineBody), both of which
		are defined. **/
	private void compileSubroutine() {
		// subroutine:			subroutineDec subroutineBody
		// 		subroutineDec:	('constructor' | 'function' | 'method')
		//						('void' | type) subroutineName '(' parameterList ')'
		//						subroutineBody
		//		subroutineBody:	'{' varDec* statements '}'
		
		writeXML("<subroutineDec>");
		tabCount++;
		
		// returns "method"
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		// return type, "void"
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		// return subroutineName, "characters"
		printXMLToken();
		identifierInfo("subroutine", false, "", currentIndex);
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		// returns (
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		
		writeXML("<parameterList>");
		if(tokenizer.tokenType()==JackTokenizer.TokenType.KEYWORD || tokenizer.tokenType()==JackTokenizer.TokenType.IDENTIFIER) {
			compileParameterList();
		}
		writeXML("</parameterList>");
		
		
		// returns )
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		// Get next token
		
		writeXML("<subroutineBody>");
		tabCount++;
		
		// Get next token "{"
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		while(tokenizer.token().equals("var")) {
			compileVarDec();
		}
			
		compileStatements();
		
		// Get next token "}"
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		tabCount--;
		writeXML("</subroutineBody>");
		tabCount--;
		writeXML("</subroutineDec>");		
	}
	
	private void compileParameterList() {
		// parameterList:	((type varName) (',' type varName)*)?
		tabCount++;
	
		// get type
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		// get varName
		printXMLToken();
		identifierInfo("arg", true, "arg", currentIndex);
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		while(tokenizer.token().equals(",")){
			
			// get comma
			printXMLToken();
			tokenizer.hasMoreTokens();
			tokenizer.advance();
			
			// get type
			printXMLToken();
			tokenizer.hasMoreTokens();
			tokenizer.advance();
		
			// get varName
			printXMLToken();
			identifierInfo("arg", true, "arg", currentIndex);
			tokenizer.hasMoreTokens();
			tokenizer.advance();
		}
		
		tabCount--;
	}
	
	private void compileVarDec() {
		// varDec:	'var' type varName (',' type varName)*)?
		
		// Prints var NOT ANYMORE
		writeXML("<varDec>");
		tabCount++;
		
		while(tokenizer.token().equals("var")){
			
			// prints var
			printXMLToken();
			tokenizer.hasMoreTokens();
			tokenizer.advance();
			
			// get type
			printXMLToken();
			tokenizer.hasMoreTokens();
			tokenizer.advance();
			
			// get varName
			printXMLToken();
			tokenizer.hasMoreTokens();
			tokenizer.advance();
			
			while(tokenizer.token().equals(",")){
				
				// get comma
				printXMLToken();
				tokenizer.hasMoreTokens();
				tokenizer.advance();
			
				// get varName
				printXMLToken();
				tokenizer.hasMoreTokens();
				tokenizer.advance();
			}
		}	
		// get semicolon
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		
		tabCount--;
		writeXML("</varDec>");
		//printXMLToken();

	}	
	
	private void compileStatements() {
		// statements:	statement*
	
		writeXML("<statements>");
		tabCount++;
				
		while(tokenizer.token().equals("let") || tokenizer.token().equals("if") || tokenizer.token().equals("while") || tokenizer.token().equals("do") || tokenizer.token().equals("return")){			
			if(tokenizer.token().equals("let")){
				compileLet();	
			} else if(tokenizer.token().equals("if")){
				compileIf();
			} else if(tokenizer.token().equals("while")){
				compileWhile();
			} else if(tokenizer.token().equals("do")){
				compileDo();
			}else if(tokenizer.token().equals("return")){
				compileReturn();
			}
		}
		
		tabCount--;
		writeXML("</statements>");
	}
	
	private void compileDo() {
		// doStatement:	'do' subroutineCall ';'
		writeXML("<doStatement>");
		tabCount++;
		
		// prints do
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		// NEEDS IF STATEMENTS	

		// prints subroutineName
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();	
		
		if(tokenizer.token().equals(".")){
			//prints the "."
			printXMLToken();
			tokenizer.hasMoreTokens();
			tokenizer.advance();
			
			//prints the subroutineName
			printXMLToken();
			tokenizer.hasMoreTokens();
			tokenizer.advance();
		}
		
		// prints the "("
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		compileExpressionList();
		
		// prints ")"
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();	
		
		// prints semicolon
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();	

		tabCount--;
		writeXML("</doStatement>");
	}
	
	private void compileLet() {
		// letStatement:  'let' varName ('[' expression ']')? '=' expression ';'
		
		writeXML("<letStatement>");
		tabCount++;
		
		// prints let
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
			
		// get varName
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		if(tokenizer.token().equals("[")){
			// prints [
			printXMLToken();
			tokenizer.hasMoreTokens();
			tokenizer.advance();

			
			compileExpression();
		
			// prints ]
			printXMLToken();
			tokenizer.hasMoreTokens();
			tokenizer.advance();
		}
		
		// get the "="
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		// get expression
		compileExpression();
		
		
		// Prints the Semicolon
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		tabCount--;
		writeXML("</letStatement>");
		
	}
	
	private void compileWhile() {
		// whileStatement:  'while' '('  expression ')' '{' statements '}'
		writeXML("<whileStatement>");
		tabCount++;

		// Prints "while"
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		// Prints "("
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		compileExpression();
		
		// Prints ")"
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		// Prints "{"
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();

		compileStatements();
		
		// Prints "}"
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();


		tabCount--;
		writeXML("</whileStatement>");
	}
	
	private void compileReturn() {
		// returnStatement:	'return' expression? ';'
		
		writeXML("<returnStatement>");
		tabCount++;
		
		// gets the "return"
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();		
		
		if(!tokenizer.token().equals(";")){
			compileExpression();
		}
				
		// Prints the Semicolon
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();

		
		tabCount--;
		writeXML("</returnStatement>");
	}
	
	private void compileIf() {
		// ifStatement:  'if' '(' expression ')' '{' statements '}'
		//				('else' '{' statements '}')?
		
		writeXML("<ifStatement>");
		tabCount++;

		// Prints "if"
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		// Prints "("
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		compileExpression();
		
		// Prints ")"
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		// Prints "{"
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();

		compileStatements();		
		
		// Prints "}"
		printXMLToken();
		tokenizer.hasMoreTokens();
		tokenizer.advance();
		
		if(tokenizer.token().equals("else")){
		
			// Prints "else"
			printXMLToken();
			tokenizer.hasMoreTokens();
			tokenizer.advance();
	
			// Prints "{"
			printXMLToken();
			tokenizer.hasMoreTokens();
			tokenizer.advance();
				
			compileStatements();
			// Prints "}"
			printXMLToken();
			tokenizer.hasMoreTokens();
			tokenizer.advance();	
		}
		
		tabCount--;
		writeXML("</ifStatement>");
	}
	
	private void compileExpression() {
		// expression:	term (op term)*
	
		writeXML("<expression>");
		tabCount++;

		compileTerm();
		
		//if(tokenizer.hasMoreTokens()){			
			while(tokenizer.token().equals("+") || tokenizer.token().equals("-") || tokenizer.token().equals("*") || tokenizer.token().equals("/") || tokenizer.token().equals("&") || tokenizer.token().equals("|") || tokenizer.token().equals("<") || tokenizer.token().equals(">") || tokenizer.token().equals("=")){
				
				//prints the op
				printXMLToken();
				tokenizer.hasMoreTokens();
				tokenizer.advance();
				compileTerm();
			}
		//}

		tabCount--;
		writeXML("</expression>");
	}
	
	/** Near the end of section 10.1.3, it is mentioned that the Jack grammer is
		"almost" LL(0). The exception being that lookahead is required for the
		parsing of expressions. Specifically, a subroutineCall starts with an identifier
		which makes it impossible to differentiate from varName without
	 	more context either in terms of a pre-populated symbol table or a lookahead.
	 	Subroutine call identifiers are always followed by an '('. Looking ahead
	 	one token resolves the problem. **/
	private void compileTerm() {
		
		
		writeXML("<term>");
		tabCount++;
		// term:	integerConstant | stringConstant | keywordConstant |
		//			varName | varName '[' expression ']' | subroutineCall |
		//			'(' expression ')' | unaryOp term

		if(tokenizer.tokenType() == JackTokenizer.TokenType.IDENTIFIER || tokenizer.token().equals("true") || tokenizer.token().equals("false") || tokenizer.token().equals("null") || tokenizer.token().equals("this") || tokenizer.tokenType() == JackTokenizer.TokenType.STRING_CONST || tokenizer.tokenType() == JackTokenizer.TokenType.INT_CONST || tokenizer.token().equals("-") || tokenizer.token().equals("~") || tokenizer.token().equals("(")){
			String currentToken = tokenizer.token();
			
			if (tokenizer.tokenType() == JackTokenizer.TokenType.INT_CONST){
				//prints the int constant
				printXMLToken();
				tokenizer.hasMoreTokens();
				tokenizer.advance();
					
			} else if (tokenizer.tokenType() == JackTokenizer.TokenType.STRING_CONST){
				//prints the string constant
				printXMLToken();
				tokenizer.hasMoreTokens();
				tokenizer.advance();
			} else if (tokenizer.tokenType() == JackTokenizer.TokenType.KEYWORD){
				//prints the keyword constant
				printXMLToken();
				tokenizer.hasMoreTokens();
				tokenizer.advance();
			}else if(tokenizer.token().equals("-") || tokenizer.token().equals("~") ){
				//prints the unary op
				printXMLToken();
				tokenizer.hasMoreTokens();
				tokenizer.advance();
				
				//compile term
				compileTerm();
			
			}else if(tokenizer.tokenType() == JackTokenizer.TokenType.IDENTIFIER){
				//set up varName, varName[], subroutineCall	

				//prints the Identifier
				printXMLToken();
				tokenizer.hasMoreTokens();
				tokenizer.advance();
				
				// checks for the term, varName['expression']
				if(tokenizer.token().equals("[")){
					//prints the "["
					printXMLToken();
					tokenizer.hasMoreTokens();
					tokenizer.advance();
					
					compileExpression();
					
					//prints the "]"
					printXMLToken();
					tokenizer.hasMoreTokens();
					tokenizer.advance();
					
					
				// checks to see if subroutineCall with "()" only;
				}  else if(tokenizer.token().equals("(")){
				
				//prints the "("
				printXMLToken();
				tokenizer.hasMoreTokens();
				tokenizer.advance();
				
				//prints the expressionList
				compileExpressionList();
				
				//prints the ")"
				printXMLToken();
				tokenizer.hasMoreTokens();
				tokenizer.advance();
				
				
				// checks to see if subroutineCall with "."
				} else if (tokenizer.token().equals(".")){
					//prints the "."
					printXMLToken();
					tokenizer.hasMoreTokens();
					tokenizer.advance();
					
					
					//print the identifier
					printXMLToken();
					tokenizer.hasMoreTokens();
					tokenizer.advance();
					
					//print the "("
					printXMLToken();
					tokenizer.hasMoreTokens();
					tokenizer.advance();
					
					compileExpressionList();
					
					//print the ")"	
					printXMLToken();
					tokenizer.hasMoreTokens();
					tokenizer.advance();	
						
				} 
			}
		
		
			else if (tokenizer.token().equals("(")){
				//prints the "("
				printXMLToken();
				tokenizer.hasMoreTokens();
				tokenizer.advance();
				
				compileExpression();
				
				//prints the ")"
				printXMLToken();
				tokenizer.hasMoreTokens();
				tokenizer.advance();
			}	

//			else{
//				printXMLToken();
//				tokenizer.hasMoreTokens();
//				tokenizer.advance();
//				
//				if(tokenizer.token().equals("[")){
//					//prints the "["
//					printXMLToken();
//					tokenizer.hasMoreTokens();
//					tokenizer.advance();
//					
//					compileExpression();
//					
//					//prints the "]"
//					printXMLToken();
//					tokenizer.hasMoreTokens();
//					tokenizer.advance();
//					
//				} else if (tokenizer.token().equals(".")){
//					//prints the "."
//					printXMLToken();
//					tokenizer.hasMoreTokens();
//					tokenizer.advance();
//					
//					
//					//print the identifier
//					printXMLToken();
//					tokenizer.hasMoreTokens();
//					tokenizer.advance();
//					
//					//print the "("
//					printXMLToken();
//					tokenizer.hasMoreTokens();
//					tokenizer.advance();
//					
//					compileExpressionList();
//					
//					//print the ")"	
//					printXMLToken();
//					tokenizer.hasMoreTokens();
//					tokenizer.advance();	
//						
//				} 
//				
//				else if (tokenizer.token().equals("(")){
//				//prints the "("
//				System.out.println(tokenizer.token());
//				printXMLToken();
//				tokenizer.hasMoreTokens();
//				tokenizer.advance();
//				
//				compileExpression();
//				
//				//prints the ")"
//				printXMLToken();
//				tokenizer.hasMoreTokens();
//				tokenizer.advance();
//				}
//			}
		
		tabCount--;
		writeXML("</term>");
		
		
		}
	}
	
	private void compileExpressionList() {
		// expressionList:	( expression (',' expression)* )?
		writeXML("<expressionList>");
		tabCount++;
				
		if(tokenizer.tokenType() == JackTokenizer.TokenType.IDENTIFIER || tokenizer.tokenType() == JackTokenizer.TokenType.STRING_CONST || tokenizer.tokenType() == JackTokenizer.TokenType.INT_CONST || tokenizer.tokenType() == JackTokenizer.TokenType.KEYWORD  || tokenizer.token().equals("(")){
			compileExpression();
			
			while(!tokenizer.token().equals(")")){
				
				// get comma
				printXMLToken();
				tokenizer.hasMoreTokens();
				tokenizer.advance();
		
				compileExpression();
			
			}
		}
		
		tabCount--;
		writeXML("</expressionList>");
	}

	private void identifierInfo(String category, boolean defined, String kind, int index){
		if(category.equals("field") || category.equals("static") || category.equals("var") || category.equals("arg")){
			writeXML("<identifierInfo1> " + category + "</identifierInfo1>");
			if(defined){
				writeXML("<identifierInfo2> defined </identifierInfo2>");
			}
			else{
				writeXML("<identifierInfo2> undefined </identifierInfo2>");
			}
			writeXML("<identifierInfo3>" + kind + "</identifierInfo3>");
			writeXML("<identifierInfo4> " + index + "</identifierInfo4>");
		}
		else if(category.equals("class")||category.equals("subroutine")){
			writeXML("<identifierInfo1> " + category + "</identifierInfo1>");
		}
	}
}