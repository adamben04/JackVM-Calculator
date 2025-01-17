import java.util.*;
import java.lang.*;
import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

class SymbolTable {

	public static final int C_NONE = 0;
	public static final int C_VAR = 1;
	public static final int C_ARGUMENT = 2;
	public static final int C_STATIC = 3;
	public static final int C_FIELD = 4;
	public static final int C_CLASS = 5;
	public static final int C_SUBROUTINE = 6;
	public static final String[] theKinds = {"NONE","VAR","ARGUMENT","STATIC","FIELD"};
	
	private static HashMap<String, TableEntry> classMap, subroutineMap;
	private static int staticIndex, fieldIndex, argIndex, varIndex;
	
	// We create a nested class to store the type and kind for each entry
	class TableEntry {
		private String theType;
		private int theKind, theIndex;
		
		public TableEntry(String inType, int inKind, int index) {
			theType = inType;
			theKind = inKind;
			theIndex = index;
		}
		
		// Accessor methods
		public String getType() {
			return theType;
		}
		
		public int getKind() {
			return theKind;
		}
		
		public int getIndex() {
			return theIndex;
		}
	}

	// We create 2 maps. One for class variables and one for subroutine variables.
	public SymbolTable() {
		// We create an index for each map tracking the index as each entry is added
		classMap = new HashMap<String, TableEntry>();
		staticIndex = fieldIndex = 0;
		subroutineMap = new HashMap<String, TableEntry>();
		argIndex = varIndex = 0;
	}
	
	// Whenever we enter a new subroutine, this method should be called to clear
	// out any entries for previous subroutines and reset the index.
	public void startSubroutine () {
		subroutineMap.clear();
		argIndex = varIndex = 0;
	}
	
	public void Define(String name, String type, int kind) {
		
		if (kind == C_VAR) {
			subroutineMap.put(name, new TableEntry(type,kind,varIndex));
			varIndex++;	
		} else if (kind == C_ARGUMENT ) {
			subroutineMap.put(name, new TableEntry(type,kind,argIndex));
			argIndex++;	
		} else if (kind == C_STATIC ) {
			classMap.put(name, new TableEntry(type,kind,staticIndex));
			staticIndex++;
		} else if (kind == C_FIELD ) {
			classMap.put(name, new TableEntry(type,kind,fieldIndex));
			fieldIndex++;
		}
	}
	
	public int VarCount(int kind) {
		if (kind == C_VAR)
			return varIndex;	
		else if (kind == C_ARGUMENT )
			return argIndex;	
		else if (kind == C_STATIC )
			return staticIndex;
		else if (kind == C_FIELD )
			return fieldIndex;
			
		return -1;
	}
	
	public int KindOf(String name) {
		HashMap<String, TableEntry> searchMap;
		
		searchMap = subroutineMap;
			
		TableEntry theEntry = searchMap.get(name);
		
		if (theEntry != null)
			return theEntry.getKind();
		
		searchMap = classMap;
		theEntry = searchMap.get(name);
		
		if (theEntry != null)
			return theEntry.getKind();
		else
			return 0;
	}
	
	public String TypeOf(String name) {
		HashMap<String, TableEntry> searchMap;
		
		searchMap = subroutineMap;
			
		TableEntry theEntry = searchMap.get(name);
		
		if (theEntry != null)
			return theEntry.getType();
		
		searchMap = classMap;
		theEntry = searchMap.get(name);
		
		if (theEntry != null)
			return theEntry.getType();
		else
			return "";
	}
	
	public int IndexOf(String name) {
		HashMap<String, TableEntry> searchMap;
		
		searchMap = subroutineMap;
			
		TableEntry theEntry = searchMap.get(name);
		
		if (theEntry != null)
			return theEntry.getIndex();
		
		searchMap = classMap;
		theEntry = searchMap.get(name);
		
		if (theEntry != null)
			return theEntry.getIndex();
		else
			return -1;
	}
}