class STtest {

	public static void main (String[] args) {
		SymbolTable st = new SymbolTable();
		
		
		st.Define("one","int",SymbolTable.C_STATIC);
		st.Define("two","boolean",SymbolTable.C_ARGUMENT);
		st.Define("three","boolean",SymbolTable.C_ARGUMENT);
		st.Define("four","String",SymbolTable.C_ARGUMENT);

		System.out.println("\nNumber of ARG variables: " + st.VarCount(SymbolTable.C_ARGUMENT));
		
		String testString = "one";
		System.out.println("The kind for " +testString+ " is: " + st.KindOf(testString));
		System.out.println("The type for " +testString+ " is: " + st.TypeOf(testString));
		System.out.println("The index for " +testString+ " is: " + st.IndexOf(testString));
		System.out.println();
		
		testString = "four";
		System.out.println("The kind for " +testString+ " is: " + st.KindOf(testString));
		System.out.println("The type for " +testString+ " is: " + st.TypeOf(testString));
		System.out.println("The index for " +testString+ " is: " + st.IndexOf(testString));
	}
}
