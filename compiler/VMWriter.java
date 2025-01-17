import java.util.*;
import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

class VMWriter {

	private PrintWriter printWriter;
	private int labelNumber, tabCount;
	
	private static final int dLevel = 11;
	
	public static final int C_ADD = 1;
	public static final int C_SUB = 2;
	public static final int C_NEG = 3;
	public static final int C_EQ = 4;
	public static final int C_GT = 5;
	public static final int C_LT = 6;
	public static final int C_AND = 7;
	public static final int C_OR = 8;
	public static final int C_NOT = 9;
	
	public static final String S_CONSTANT = "constant";
	public static final String S_ARGUMENT = "argument";
	public static final String S_LOCAL = "local";
	public static final String S_STATIC = "static";
	public static final String S_THIS = "this";
	public static final String S_THAT = "that";
	public static final String S_POINTER = "pointer";
	public static final String S_TEMP = "temp";

	public VMWriter(String outFile){
		writer = null;
		try {
			Pattern pattern = Pattern.compile("(.*).jack");
			Matcher matcher = pattern.matcher(inFile);
			if (matcher.find()) {
				String fileNameBase = matcher.group(1);	
				printWriter = new PrintWriter(fileNameBase + ".vm");
			}
		}
		catch (IOException e) {
			System.out.println("Could not create file");
			return;
		}
		labelNumber = 0;
	}
	
	public void close() {
		printWriter.close();
	}

	private void writeVMCode(String inString) {
		for (int counter = 0; counter < tabCount; counter++) {
			System.out.print("  ");
			printWriter.printf("  ");
		}
		Debug.println(dLevel,inString);
		printWriter.printf(inString);
	}

	public void writePush(String segment, int index) {
		String outString = String.format("push %s %d",segment, index);
		Debug.println(dLevel,outString);
		writeVMCode(outString);
	}

	public void writePop(String segment, int index) {
		String outString = String.format("pop %s %d",segment, index);
		Debug.println(dLevel,outString);
		writeVMCode(outString);
	}

	public void writeArithmetic(String command) {
		Debug.println(dLevel,command);
		writeVMCode(command);
	}

	public void writLabel(String label) {
		String outString = String.format("label %s",label);
		Debug.println(dLevel,outString);
		writeVMCode(outString);
	}

	public void writeGoto(String label) {
		String outString = String.format("goto %s",label);
		Debug.println(dLevel,outString);
		writeVMCode(outString);
	}

	public void writeIf(String label) {
		String outString = String.format("if-goto %s",label);
		Debug.println(dLevel,outString);
		writeVMCode(outString);
	}

	public void writeCall(String name, int nArgs) {
		String outString = String.format("call %s %d",name, nArgs);
		Debug.println(dLevel,outString);
		writeVMCode(outString);
	}

	public void writeFunction(String name, int nLocals) {
		String outString = String.format("function %s %d",name, nLocals);
		Debug.println(dLevel,outString);
		writeVMCode(outString);
	}

	public void writeReturn() {
		Debug.println(dLevel,"return");
		writeVMCode("return");
	}
}