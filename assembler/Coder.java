public class Coder
{
	/* Declare static data structures to contain lookups for the 
		destinations, computations and jumps.*/
	
	
	public String symbol(String inStr){
		
		String binary = Integer.toBinaryString(Integer.parseInt(inStr));
		String zeros="000000000000000";
		return zeros.substring(0,15-binary.length())+binary;
	
	}
	
	/* Initialize and populate the data structures*/
	public Coder() {
	
	}
	
	/* Returns the translated destination or "000" if there is no
		destination (null string passed in) */
	public String dest(String inStr)
	{
		String dest1="";	
		if(inStr.contains("A")){
			dest1+="1";
		}
		else{
			dest1+="0";
		}
		if(inStr.contains("D")){
			dest1+="1";
		}
		else{
			dest1+="0";
		}
		if(inStr.contains("M")){
			dest1+="1";
		}
		else{
			dest1+="0";
		}
		return dest1;
	}
	
	/* Returns the translated computation. This should not be called
		if there is no computation as that would be a violation of the
		language specification. */
	public String comp(String inStr)
	{
		String comp1="0";
		
		if(inStr.contains("M")) comp1="1";
		
		
		if(inStr.equals("0")){
			comp1+="101010";
		}
		if(inStr.equals("1")){
			comp1+="111111";
		}
		if(inStr.equals("-1")){
			comp1+="111010";
		}
		if(inStr.equals("D")){
			comp1+="001100";
		}
		if(inStr.equals("A")||inStr.equals("M")){
			comp1+="110000";
		}
		if(inStr.equals("!D")){
			comp1+="001101";
		}
		if(inStr.equals("!A")||inStr.equals("!M")){
			comp1+="110001";
		}
		if(inStr.equals("-D")||inStr.equals("")){
			comp1+="001111";
		}
		if(inStr.equals("-A")||inStr.equals("-M")){
			comp1+="110011";
		}
		if(inStr.equals("D+1")){
			comp1+="011111";
		}
		if(inStr.equals("A+1")||inStr.equals("M+1")){
			comp1+="110111";
		}
		if(inStr.equals("D-1")){
			comp1+="001110";
		}
		if(inStr.equals("A-1")||inStr.equals("M-1")){
			comp1+="110010";
		}
		if(inStr.equals("D+A")||inStr.equals("D+M")){
			comp1+="000010";
		}
		if(inStr.equals("D-A")||inStr.equals("D-M")){
			comp1+="010011";
		}
		if(inStr.equals("A-D")||inStr.equals("M-D")){
			comp1+="000111";
		}
		if(inStr.equals("D&A")||inStr.equals("D&M")){
			comp1+="000000";
		}
		if(inStr.equals("D|A")||inStr.equals("D|M")){
			comp1+="010101";
		}
		return comp1;
	}
	
	/* Returns the translated jump or "000" if there is no
		jump (null string passed in) */
	public String jump(String inStr)
	{
		if(inStr.contains("JGT")) return "001";
		if(inStr.contains("JEQ")) return "010";
		if(inStr.contains("JGE")) return "011";
		if(inStr.contains("JLT")) return "100";
		if(inStr.contains("JNE")) return "101";
		if(inStr.contains("JLE")) return "110";
		if(inStr.contains("JMP")) return "111";
		return "000";
	}
}