#!/usr/bin/perl

# RKoenig 2022-11-22 -> 2023-06-21
# nand2Tetris_VM->Intel_8085 Translator
# Chapters 7 and 8 Full VM Translator
# 8085 Assembly to be done by Jubin's 8085 Simulator
# http://8085simulatorj.blockspot.com

# In General Architecture, we use Register Pair HL as Hack's A Register and BC as Hack's D Register.
#  Register Pair DE is used mostly in function calls and program flow statements.
# When making use of M, since 8085 addresses Bytes not Words, we must double the value of A.
#  We also invert the memory map, so Hack M[0] is at 0xFFFE (and 0xFFFF) and M[1] is at 0xFFFC (and 0xFFFD)
#  This allows us to better simulate the memory of Hack, since the 8085 Stack grows down.
# On-Stack segments are handled by the assembler, automatically doubling and negating the offset.
#  Off-Stack segments are handled in Binary, by 1s-Complementing the address and left shifting by one to multiply by two.
# 8085 Assemblers do not permit periods in variable or function names.
#  Thus, when concatenating the class name and function or static designation, '$' is used instead of '.'.

# Other hardware constraints of note:
#  Significant Memory limitations: Total Address Space of 8085 is the same as total memory
#   available to the Hack CPU.  We somehow have to also fit the program in here too, but
#   thankfully Screen is not planned to be used.  The address space used by screen is where the program will reside.
#  We have 32K of RAM and 32k of ROM.  ROM is at addresses 0x0000 through 0x7FFF, and RAM from 0x8000 to 0xFFFF.
#  User Interface is handled by a FPGA on the bus, activated by IO Calls.
#   IO 00-07 are the eight 8-segment displays.  
#    Values 00-09 will display the digit.  Add 80 to the digit to enable the decimal point.
#    Values 0A-0E will display special characters from the following list in order: '- Ero'
#    All other values will produce undefined behavior.
#   IO 08-0A are the three rows of the keyboard input.
#    The keys are bit-mapped, so the second button from the left in the top row will produce value 40 at IO 08.
#    The right most key in the second row will produce value 01 at IO 09.
#   Special Macros are available at IO 0F, however it is unlikely that we will use them.
#    Value 01 will shift all digits right one space, dropping the rightmost digit
#    Value 02 will shift all digits left one space, dropping the leftmost digit
#    Value 03 will shift all digits right one space, wrapping the rightmost digit to the leftmost space
#    Value 04 will shift all digits left one space, wrapping the leftmost digit to the rightmost space
#    Value 05 will clear all displays and set the rightmost one to '0'
#    Value 06 will clear all displays and set the left five displays to 'Error'.



# Major procedural changes:
#  'Function' has the responsiblity of saving the caller's segments to the stack instead of 'call'.
#  similarilly 'return' is responsible for the reverse, restoring the caller's segments.  These two changes permit efficient use of the 8085 built-in stack.

# Warnings and Strict force us into good code practices.
use warnings;
use strict;
# Libraries would go here if we needed them

# Enable or disable debug:
# - Verbose logging to STDOUT
# - Writing the VM line to ASM as a comment (and non-matched lines, eg VM Comments)
my $debug = 0;
# Program Size optimization, done by moving common sequences to a function and replacing with a call
# 0: No optimization
# 1: + Hack to 8085 Memory Map calculation - Adds 10 Bytes total, but saves 6 bytes per push/pop against this/that in exchange for 28 additional T-States
# 2: + Inequality Helper Functions - Adds 28 Bytes total, but saves 16 bytes per lt/gt/eq in exchange for 28 additional T-States
my $optimization = 2;

# Global Variables
my $OUTPUT = undef;	# Output file handle, initialized in main() and used in processFile()
my $class = undef;	# Used to scope static variables and function names
my $function = undef;	# Used to scope labels to the specific function
my $ifCount = 0;	# Used to differentiate labels for if statements
my $byteCount = 0;	# Used as an estimate to print out ROM capacity utilization

# *** Begin Program ***
# Perl is a scripting language, so execution begins here
# We are supplied one argument, a path to a file or directory to translate
my $mode = 0;
print( "Argument: $ARGV[0]\n" ) if $debug;

# Split the supplied path into its components
my @path = split( '/', $ARGV[0] );
# Program basename is the last component
my $name = $path[-1];	# Perl has negative indexes, its easy to get the last index of an array
print( "Last Node: $name\n" ) if $debug;

# Check for and strip extension, which also indicates file mode vs directory mode
if ( $name =~ /.vm$/ ) {
	print( "Single File Detected\n" );
	$name = substr( $name, 0, -3 );	# Trim the last three characters off of the filename
} else {
	print( "Directory Detected\n" );
	$mode = 1;	# Engage Directory Mode
}

# Output file has .asm extension, concatenate it here
$name .= '.asm';
print( "Output Name: $name\n" );
# Update the path with the constructed file name and re-join it
$path[-1] = $name;
my $outFile = join( '/', @path );
print( "Output file path: $outFile\n" );

# Open the output file for writing
open( $OUTPUT, '>', $outFile ) or die( "Unable to Open Output File: ", $! );

# Write the necessary Bootstrap Assembly
print( "Writing Bootstrap Code & Hardcoded Sys methods...\n" );
print( $OUTPUT "// Bootstrap Code\n" ) if $debug;
print( $OUTPUT "LXI H,FE00\nSPHL\nSHLD LCL\nSHLD ARG\nSHLD THIS\nSHLD THAT\nXCHG\n" ); # Initialize internal registers & Virtual Memory Segment Pointers
$byteCount += 17;
print( $OUTPUT "PUSH D\nCALL Memory\$init\nCALL Main\$main\nSys\$halt:\nHLT\n" ); # Call Memory.init, followed by Main.main.  Halt if Main.main returns or if called.
$byteCount += 8;
# Define Sys.error, copy the memory address of ARG to HL
print( $OUTPUT "Sys\$error:\nXCHG\n" );
$byteCount += 1;
# Print 'Err   ' to the first 6 digits of the screen
print( $OUTPUT "MVI A,0B\nOUT 02\nOUT 03\nOUT 04\nINR A\nOUT 07\nINR A\nOUT 06\nOUT 05\n" );
$byteCount += 16;
# Read the error code from the supplied memory address, and split it into individual hexadecimal values
print( $OUTPUT "MOV B,M\nMOV A,B\nANI 0F\nOUT 00\nMOV A,B\nANI F0\nRAR\nRAR\nRAR\nRAR\nOUT 01\nJMP Sys\$halt\n");  # Output the two values to the rightmost two values on the screen
$byteCount += 18;
print( "Writing VM Helper Functions...\n" );
print( $OUTPUT "// VM Helper Functions\n" ) if $debug;
$byteCount += 10;
# Helper Function to parse string characters into FPGA Display Characters
print( $OUTPUT "VM\$str2out:\nDCX H\nDCX H\nMOV A,M\nSBI 30\nMOV C,A\n" );
print( $OUTPUT "DCX H\nDCX H\nMOV A,M\nCPI 2E\nMOV A,C\nRNZ\nORI 80\nRET\n" );
$byteCount += 16;
if( $optimization ) {
	# VM$memory used to be in here, but became critical to the other emulated functions.
	# Helper Function to map Hack Memory Address to 8085 Address - Inverts the Number and multiplies by two
	print( $OUTPUT "VM\$memory:\nXRA A\nMOV A,L\nCMA\nRAL\nMOV L,A\nMOV A,H\nCMA\nRAL\nMOV H,A\nRET\n" ); # 10 Bytes, 36 T-States
	if( $optimization > 1 ) {
		# There was an attempt to simplify lt/gt/eq into a function call, but that was not completed. 20230615 mind changed, solution found
		print( $OUTPUT "VM\$gt:\nMOV A,B\nCMP H\nJC VM\$true\nMOV A,C\nCMP L\nJC VM\$true\nVM\$false:\nLXI D,0000\nRET\n" );
		$byteCount += 14;
		print( $OUTPUT "VM\$eq:\nMOV A,C\nCMP L\nJNZ VM\$false\nMOV A,B\nCMP H\nJNZ VM\$false\nVM\$true:\nLXI D,FFFF\nRET\n" );
		$byteCount += 14;
	}
	
}
# Write the minimum required Output functions, tailored to our hardware
print( "Writing Hardcoded Output methods...\n" );
# function printString 0 (modified)
print( $OUTPUT "Output\$printString:\nLHLD LCL\nPUSH H\nLHLD ARG\nPUSH H\nLHLD THIS\nPUSH H\nLHLD THAT\nPUSH H\nLXI H,FFFE\nDAD SP\nSHLD LCL\n" );
$byteCount += 23;
# hardcoded assembly to print the first eight characters to the screen
# De-reference ARG, which is currently stashed in DE.  It should contain the memory address of the string from which we need to print.
# Load the value from ARG[0] into DE which is a Jack Pointer to the String Object we need to print from.  Move this to HL, and convert it to an 8085 Address
print( $OUTPUT "XCHG\nMOV E,M\nINX H\nMOV D,M\nXCHG\n" );
$byteCount += 5;
if( $optimization ) {
	print( $OUTPUT "CALL VM\$memory\n" );
	$byteCount += 3;
}
else {
	print( $OUTPUT "XRA A\nMOV A,L\nCMA\nRAL\nMOV L,A\nMOV A,H\nCMA\nRAL\nMOV H,A\n" );
	$byteCount += 23;
}
# The String Object has a pointer to an Array Object at this[1].  Load this Jack pointer into HL via DE and convert it into an 8085 address
print( $OUTPUT "DCX H\nDCX H\nMOV D,M\nDCX H\nMOV E,M\nXCHG\n" );
$byteCount += 6;
if( $optimization ) {
	print( $OUTPUT "CALL VM\$memory\n" );
	$byteCount += 3;
}
else {
	print( $OUTPUT "XRA A\nMOV A,L\nCMA\nRAL\nMOV L,A\nMOV A,H\nCMA\nRAL\nMOV H,A\n" );
	$byteCount += 23;
}
# We now have access to the character array.  Check the first character, will be either a '-' or ' '.  Load the Relevant code into C
print( $OUTPUT "MOV A,M\nCPI 2D\nJNZ Output\$printString\$IF_FALSE0\nMVI C,0A\nJMP Output\$printString\$IF_END0\nOutput\$printString\$IF_FALSE0:\nMVI C,0B\nOutput\$printString\$IF_END0:\n" );
$byteCount += 13;
# Check the second character, will be either a '.' or ' '.  OR the stashed value in C with 80H if the character was '.', then output to the first digit.
print( $OUTPUT "DCX H\nDCX H\nMOV A,M\nCPI 2E\nMOV A,C\nJNZ Output\$printString\$IF_END1\nORI 80\nOutput\$printString\$IF_END1:\nOUT 07\n" );
$byteCount += 13;
# Now we can get on to the digits, of which we can now print seven.  Our Helper Function VMstr2out will return the appropriate output byte when called sequentially
print( $OUTPUT "CALL VM\$str2out\nOUT 06\n" );
print( $OUTPUT "CALL VM\$str2out\nOUT 05\n" );
print( $OUTPUT "CALL VM\$str2out\nOUT 04\n" );
print( $OUTPUT "CALL VM\$str2out\nOUT 03\n" );
print( $OUTPUT "CALL VM\$str2out\nOUT 02\n" );
print( $OUTPUT "CALL VM\$str2out\nOUT 01\n" );
print( $OUTPUT "CALL VM\$str2out\nOUT 00\n" );
$byteCount += 35;
# return
print( $OUTPUT "LXI D,0000\nLHLD LCL\nINX H\nINX H\nSPHL\nPOP H\nSHLD THAT\nPOP H\nSHLD THIS\nPOP H\nSHLD ARG\nPOP H\nSHLD LCL\nRET\n" );
$byteCount += 26;
# function println 0 (modified)
print( $OUTPUT "Output\$println:\nLHLD LCL\nPUSH H\nLHLD ARG\nPUSH H\nLHLD THIS\nPUSH H\nLHLD THAT\nPUSH H\nLXI H,FFFE\nDAD SP\nSHLD LCL\n" );
$byteCount += 23;
# a glorified noop in function call form
print( $OUTPUT "LXI D,0000\nLHLD LCL\nINX H\nINX H\nSPHL\nPOP H\nSHLD THAT\nPOP H\nSHLD THIS\nPOP H\nSHLD ARG\nPOP H\nSHLD LCL\nRET\n" );
$byteCount += 26;
# Write the minimum required Keyboard functions, tailored to our hardware
print( "Writing Hardcoded Keyboard method...\n" );
# function readChar 0 (modified)
print( $OUTPUT "Keyboard\$readChar:\nLHLD LCL\nPUSH H\nLHLD ARG\nPUSH H\nLHLD THIS\nPUSH H\nLHLD THAT\nPUSH H\nLXI H,FFFE\nDAD SP\nSHLD LCL\n" );
$byteCount += 23;
# Load zero into register C, for ADDing to force the flags after IN.  Register B will hold the lower order nibble of the IO Address
print( $OUTPUT "MVI C,00\n" );
$byteCount += 2;
# Read from the first line of the keyboard, Jumping to the next block if no key detected.  If key, wait until no more key
print( $OUTPUT "Keyboard\$readChar\$KEY1:\nMVI B,00\nIN 10\nADD C\nJZ Keyboard\$readChar\$KEY2\nMOV D,A\nKeyboard\$readChar\$WAIT1:\nIN 10\nADD C\nJNZ Keyboard\$readChar\$WAIT1\nJMP Keyboard\$readChar\$KEYEND\n" );
$byteCount += 18;
# Read from the second line of the keyboard, same jump conditions
print( $OUTPUT "Keyboard\$readChar\$KEY2:\nINR B\nIN 11\nADD C\nJZ Keyboard\$readChar\$KEY3\nMOV D,A\nKeyboard\$readChar\$WAIT2:\nIN 11\nADD C\nJNZ Keyboard\$readChar\$WAIT2\nJMP Keyboard\$readChar\$KEYEND\n" );
$byteCount += 17;
# Read from the third line of the keyboard, same jump conditions
print( $OUTPUT "Keyboard\$readChar\$KEY3:\nINR B\nIN 12\nADD C\nJZ Keyboard\$readChar\$KEY4\nMOV D,A\nKeyboard\$readChar\$WAIT3:\nIN 12\nADD C\nJNZ Keyboard\$readChar\$WAIT3\nJMP Keyboard\$readChar\$KEYEND\n" );
$byteCount += 17;
# Finally read from the fourth line, Jumping to the beginning of the loop if no key detected.
print( $OUTPUT "Keyboard\$readChar\$KEY4:\nINR B\nIN 13\nADD C\nJZ Keyboard\$readChar\$KEY1\nMOV D,A\nKeyboard\$readChar\$WAIT4:\nIN 13\nADD C\nJNZ Keyboard\$readChar\$WAIT4\nJMP Keyboard\$readChar\$KEYEND\n" );
$byteCount += 17;
# Define the Loop Exit Label, and load the stored key value back into A
print( $OUTPUT "Keyboard\$readChar\$KEYEND:\nMOV A,D\n" );
$byteCount += 1;
# Convert the bitmap to an integer offset, storing the result in C
print( $OUTPUT "Keyboard\$readChar\$LOOP:\nRAL\nJNZ Keyboard\$readChar\$LOOPEND\nINR C\nJMP Keyboard\$readChar\$LOOP\nKeyboard\$readChar\$LOOPEND:\n" );
$byteCount += 8;
# DEBUG: Output these values to the screen for debugging
print( $OUTPUT "MVI A,05\nOUT 0F\nMOV A,B\nOUT 07\nMOV A,C\nOUT 06\n" );
$byteCount += 10;
# Define the second loop exit label, we now have key address offset in B and bit offset in C.  B is two bytes, and C is up to 3 bytes, we can combine them into a single value
print( $OUTPUT "MOV A,B\nRLC\nRLC\nRLC\nORA C\n" );
$byteCount += 5;
# A now has values 00 through 1E, not including *3, *7, *B or 0F
print( $OUTPUT "MVI B,00\nCMP B\nMVI E,5E\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 00: KS1-K3: 0x5E: '^'
print( $OUTPUT "INR B\nCMP B\nMVI E,2A\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 01: KS1-K2: 0x2A: '*'
print( $OUTPUT "INR B\nCMP B\nMVI E,2B\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 02: KS1-K1: 0x2A: '+'
print( $OUTPUT "INR B\n" );
$byteCount += 23;
print( $OUTPUT "INR B\nCMP B\nMVI E,52\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 04: KS2-K3: 0x52: 'R'
print( $OUTPUT "INR B\nCMP B\nMVI E,2F\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 05: KS2-K2: 0x2F: '/'
print( $OUTPUT "INR B\nCMP B\nMVI E,2D\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 06: KS2-K1: 0x2D: '-'
print( $OUTPUT "INR B\n" );
$byteCount += 22;
print( $OUTPUT "INR B\nCMP B\nMVI E,54\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 08: KS3-K3: 0x54: 'T'
print( $OUTPUT "INR B\nCMP B\nMVI E,43\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 09: KS3-K2: 0x43: 'C'
print( $OUTPUT "INR B\nCMP B\nMVI E,53\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 0A: KS3-K1: 0x53: 'S'
print( $OUTPUT "INR B\n" );
$byteCount += 22;
print( $OUTPUT "INR B\nCMP B\nMVI E,30\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 0C: KS4-K3: 0x30: '0'
print( $OUTPUT "INR B\nCMP B\nMVI E,45\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 0D: KS4-K2: 0x45: 'E'
print( $OUTPUT "INR B\nCMP B\nMVI E,50\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 0E: KS4-K1: 0x50: 'P'
print( $OUTPUT "INR B\n" );
$byteCount += 22;
print( $OUTPUT "INR B\nCMP B\nMVI E,31\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 10: KS5-K3: 0x31: '1'
print( $OUTPUT "INR B\nCMP B\nMVI E,34\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 11: KS5-K2: 0x34: '4'
print( $OUTPUT "INR B\nCMP B\nMVI E,37\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 12: KS5-K1: 0x37: '7'
print( $OUTPUT "INR B\n" );
$byteCount += 22;
print( $OUTPUT "INR B\nCMP B\nMVI E,32\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 14: KS6-K3: 0x32: '2'
print( $OUTPUT "INR B\nCMP B\nMVI E,35\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 15: KS6-K2: 0x35: '5'
print( $OUTPUT "INR B\nCMP B\nMVI E,38\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 16: KS6-K1: 0x38: '8'
print( $OUTPUT "INR B\n" );
$byteCount += 22;
print( $OUTPUT "INR B\nCMP B\nMVI E,33\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 18: KS7-K3: 0x33: '3'
print( $OUTPUT "INR B\nCMP B\nMVI E,36\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 19: KS7-K2: 0x36: '6'
print( $OUTPUT "INR B\nCMP B\nMVI E,39\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 1A: KS7-K1: 0x39: '9'
print( $OUTPUT "INR B\n" );
$byteCount += 22;
print( $OUTPUT "INR B\nCMP B\nMVI E,80\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 1C: KS8-K3: 0x80 '\r'
print( $OUTPUT "INR B\nCMP B\nMVI E,81\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 1D: KS8-K2: 0x81 '\b'
print( $OUTPUT "INR B\nCMP B\nMVI E,2E\nJZ Keyboard\$readChar\$MAPEND\n" );		# Button 1E: KS8-K1: 0x2E: '.'
$byteCount += 21;
# In case the key does not match any, set 00, then define the end label to finalize the return variable
print( $OUTPUT "MVI E,00\nKeyboard\$readChar\$MAPEND:\nMVI D,00\n" );
$byteCount += 4;
# DEBUG: Output these values to the screen for debugging
print( $OUTPUT "MOV A,E\nANI 0F\nOUT 00\nMOV A,E\nANI F0\nRAR\nRAR\nRAR\nRAR\nOUT 01\n" );
$byteCount += 14;
# return
print( $OUTPUT "LHLD LCL\nINX H\nINX H\nSPHL\nPOP H\nSHLD THAT\nPOP H\nSHLD THIS\nPOP H\nSHLD ARG\nPOP H\nSHLD LCL\nRET\n" );
$byteCount += 23;

# Process input files depending on our operating mode
if( $mode ) {
	print( "Globbing Directory $ARGV[0]...\n" );
	my @files = glob("$ARGV[0]/*.vm");	# wildcard in Glob behaves exactly like wildcard in Shell
	foreach( @files ) {
		processFile( $_ );
	}
} else {
	processFile( $ARGV[0] );
}

# Close the file handle to our output and return
print( "Closing Output File...\n" );
close( $OUTPUT );
print( "Program consumes an estimated $byteCount Bytes\n" );
$byteCount = $byteCount / 327.68;
print( " That is a $byteCount percent utilization of available ROM\n");
# Exit program cleanly
exit;

# Function Declarations

# processFile, expects one scalar argument, a path to a vm file that needs translating
# Will open the file for reading, and will write to the global OUTPUT variable
sub processFile( $ ) {
	print( "Processing $_[0]...\n" );
	open( my $INPUT, '<', $_[0] ) or die( "Unable to Open Output File: ", $! );	# $_ is a special perl variable, considered the 'default argument'
	
	# Update the class variable with the filename of the currently parsing file
	# this means re-splitting and trimming the path provided
	my @path = split( '/', $_[0] );
	my $name = $path[-1];
	$class = substr( $name, 0, -3 );
	print( "\tClass Name: $class\n" ) if $debug;
	my $var = -1;
	
	# Process the selected file line by line
	foreach( <$INPUT> ) {		# foreach now sets $_ because we did not specify a loop variable
		local $/ = "\r\n";	# Textbook-supplied files have CRLF line endings
		chomp;	# Remove line ending from $_	
		print( "\tLine: $_\n" ) if $debug;
		$_ =~ s/\./\$/g;
		# We're going to use Regex to parse the line, decoding the regex may take a whole second lesson
		# The first capture group requires [\w-]+ because 'if-goto' contains '-'
		# The second capture group requires [\w\$]+ because function names contain '.' which has been replaced by '$' in the previous code line
		if( $_ !~ /^\h*([\w-]+)(?>\h+([\w\$]+))?(?>\h+(\w+))?/ ) {
			# note the 'Not Match' operator in the if statement
			print( "\tIgnored\n") if $debug;
			print( $OUTPUT "// $_\n") if $debug;
			next;
		}
		print( "\tMatched: ") if $debug;
		print( "'$1' " ) if $debug;
		print( "'$2' " ) if $debug and defined $2;	# We do have to worry about uninitialized variables
		print( "'$3' " ) if $debug and defined $3;	# Since the second two capture groups are in optional atomic groups
		print( "\n" ) if $debug;
		# Command If Tree
		# Arithmetic Commands
		if( $1 eq 'add' ) {
			print( "\tCommand: add\n" ) if $debug;
			print( $OUTPUT "// add\n" ) if $debug;
			# Pop the top two numbers off the stack
			print( $OUTPUT "POP B\nPOP H\n" ); # 2 Bytes, 20 T-States
			# add them together
			print( $OUTPUT "DAD B\n" ); # 1 Byte, 10 T-States
			# push the Result back to the stack
			print( $OUTPUT "PUSH H\n" ); # 1 Byte, 12 T-States
			$byteCount += 4;
			# Total 4 Bytes, 42 T-States
		} elsif( $1 eq 'sub' ) {
			print( "\tCommand: sub\n" ) if $debug;
			print( $OUTPUT "// sub\n" ) if $debug;
			# Pop the top two numbers off the stack
			print( $OUTPUT "POP B\nPOP H\n" ); # 2 Bytes, 20 T-states
			# Subtract the lower byte via the accumulator
			print( $OUTPUT "MOV A,L\nSUB C\nMOV L,A\n" ); # 3 Bytes, 12 T-States
			# Subtract the higher byte via the accumulator with carry
			print( $OUTPUT "MOV A,H\nSBB B\nMOV H,A\n" ); # 3 Bytes, 12 T-States
			# Push the result back to the stack
			print( $OUTPUT "PUSH H\n" ); # 1 Bytes, 12 T-States
			$byteCount += 9;
			# Total 9 Bytes, 56 T-States
		} elsif( $1 eq 'neg' ) {
			print( "\tCommand: neg\n" ) if $debug;
			print( $OUTPUT "// neg\n" ) if $debug;
			# Pop the top number off the stack
			print( $OUTPUT "POP H\n" ); # 1 Byte, 10 T-States
			# complement the lower byte via the accumulator
			print( $OUTPUT "MOV A,L\nCMA\nMOV L,A\n" ); # 3 Bytes, 12 T-States
			# complement the higher byte via the accumulator
			print( $OUTPUT "MOV A,H\nCMA\nMOV H,A\n" ); # 3 Bytes, 12 T-States
			# To complete the 2s complement negation we must add one
			print( $OUTPUT "INX H\n" ); # 1 Byte, 6 T-States
			# push the result back to the stack
			print( $OUTPUT "PUSH H\n" ); # 1 Byte, 12 T-States
			$byteCount += 9;
			# Total 9 Bytes, 52 T-States
		}
		# Logic Commands
		elsif( $1 eq 'and' ) {
			print( "\tCommand: and\n" ) if $debug;
			print( $OUTPUT "// and\n" ) if $debug;
			# Pop the top two numbers off the stack
			print( $OUTPUT "POP B\nPOP H\n" ); # 2 Bytes, 20 T-states
			# Perform Bitwise And on the lower Byte via the accumulator
			print( $OUTPUT "MOV A,L\nANA C\nMOV L,A\n" ); # 3 Bytes, 12 T-States
			# Perform Bitwise And on the upper Byte via the accumulator
			print( $OUTPUT "MOV A,H\nANA B\nMOV H,A\n" ); # 3 Bytes, 12 T-States
			# push the result back to the stack
			print( $OUTPUT "PUSH H\n" ); # 1 Byte, 12 T-States
			$byteCount += 9;
			# Total 9 Bytes, 56 T-States
		} elsif( $1 eq 'or' ) {
			print( "\tCommand: or\n" ) if $debug;
			print( $OUTPUT "// or\n" ) if $debug;
			# Pop the top two numbers off the stack
			print( $OUTPUT "POP B\nPOP H\n" ); # 2 Bytes, 20 T-states
			# Perform Bitwise And on the lower Byte via the accumulator
			print( $OUTPUT "MOV A,L\nORA C\nMOV L,A\n" ); # 3 Bytes, 12 T-States
			# Perform Bitwise And on the upper Byte via the accumulator
			print( $OUTPUT "MOV A,H\nORA B\nMOV H,A\n" ); # 3 Bytes, 12 T-States
			# push the result back to the stack
			print( $OUTPUT "PUSH H\n" ); # 1 Byte, 12 T-States
			$byteCount += 9;
			# Total 9 Bytes, 56 T-States
		} elsif( $1 eq 'not' ) {
			print( "\tCommand: not\n" ) if $debug;
			print( $OUTPUT "// not\n" ) if $debug;
			# Pop the top number off the stack
			print( $OUTPUT "POP H\n" ); # 1 Byte, 10 T-States
			# complement the lower byte via the accumulator
			print( $OUTPUT "MOV A,L\nCMA\nMOV L,A\n" ); # 3 Bytes, 12 T-States
			# complement the higher byte via the accumulator
			print( $OUTPUT "MOV A,H\nCMA\nMOV H,A\n" ); # 3 Bytes, 12 T-States
			# push the result back to the stack
			print( $OUTPUT "PUSH H\n" ); # 1 Byte, 12 T-States
			$byteCount += 8;
			# Total 8 Bytes, 46 T-States
		}
		# Comparison Commands
		elsif( $1 eq 'eq' ) {
			print( "\tCommand: eq\n" ) if $debug;
			print( $OUTPUT "// eq (inequality # $ifCount)\n" ) if $debug;
			# Pop the top two numbers off the stack
			print( $OUTPUT "POP B\nPOP H\n" ); # 2 Bytes, 20 T-states
			$byteCount += 2;
			if( $optimization > 1 ) {
				# Call the helper function
				print( $OUTPUT "CALL VM\$eq\n" );
				$byteCount += 3;
			} else {
				# Compare the two values, lower byte first
				print( $OUTPUT "MOV A,C\nCMP L\nJNZ VM\$false$ifCount\n" ); # 5 Bytes, 18 T-States
				print( $OUTPUT "MOV A,B\nCMP H\nJNZ VM\$false$ifCount\n" ); # 5 Bytes, 18 T-States
				# Here both bytes are equal
				print( $OUTPUT "LXI D,FFFF\nJMP VM\$end$ifCount\n" ); # 6 Bytes
				# Define the False Case
				print( $OUTPUT "VM\$false$ifCount:\nLXI D,0000\n" ); # 3 Bytes
				# Define the end
				print( $OUTPUT "VM\$end$ifCount:\n" ); # 0 Byte
				$byteCount += 19;
				# Increment the number of inequalities printed, so that the next one has unique labels
				$ifCount++;
			}
			# Push result to stack
			print( $OUTPUT "PUSH D\n" );
			$byteCount += 1;
		} elsif( $1 eq 'gt' ) {
			print( "\tCommand: gt\n" ) if $debug;
			print( $OUTPUT "// gt (inequality # $ifCount)\n" ) if $debug;
			# Pop the top two numbers off the stack
			print( $OUTPUT "POP B\nPOP H\n" ); # 2 Bytes, 20 T-states
			$byteCount += 2;
			if( $optimization > 1 ) {
				# Call the helper function
				print( $OUTPUT "CALL VM\$gt\n" );
				$byteCount += 3;
			} else {
				# Compare the two values, higher byte first
				print( $OUTPUT "MOV A,B\nCMP H\nJC VM\$true$ifCount\n" ); # 5 Bytes, 18 T-States
				print( $OUTPUT "MOV A,C\nCMP L\nJC VM\$true$ifCount\n" ); # 5 Bytes, 18 T-States
				# Here is not greater
				print( $OUTPUT "LXI D,0000\nJMP VM\$end$ifCount\n" ); # 6 Bytes
				# Define the True Case
				print( $OUTPUT "VM\$true$ifCount:\nLXI D,FFFF\n" ); # 3 Bytes
				# Define the end
				print( $OUTPUT "VM\$end$ifCount:\n" ); # 0 Byte
				$byteCount += 19;
				# Increment the number of inequalities printed, so that the next one has unique labels
				$ifCount++;
			}
			# Push the result to the stack
			print( $OUTPUT "PUSH D\n" );
			$byteCount += 1;
		} elsif( $1 eq 'lt' ) {
			print( "\tCommand: lt\n" ) if $debug;
			print( $OUTPUT "// lt (inequality # $ifCount)\n" ) if $debug;
			# Pop the top two numbers off the stack (Note the reverse order compared to gt)
			print( $OUTPUT "POP H\nPOP B\n" ); # 2 Bytes, 20 T-states
			$byteCount += 2;
			# The remainder is identical to gt
			if( $optimization > 1 ) {
				# Call the helper function
				print( $OUTPUT "CALL VM\$gt\n" );
				$byteCount += 3;
			} else {
				# Compare the two values, higher byte first
				print( $OUTPUT "MOV A,B\nCMP H\nJC VM\$true$ifCount\n" ); # 5 Bytes, 18 T-States
				print( $OUTPUT "MOV A,C\nCMP L\nJC VM\$true$ifCount\n" ); # 5 Bytes, 18 T-States
				# Here is not greater
				print( $OUTPUT "LXI D,0000\nJMP VM\$end$ifCount\n" ); # 6 Bytes
				# Define the True Case
				print( $OUTPUT "VM\$true$ifCount:\nLXI D,FFFF\n" ); # 3 Bytes
				# Define the end
				print( $OUTPUT "VM\$end$ifCount:\n" ); # 0 Byte
				$byteCount += 19;
				# Increment the number of inequalities printed, so that the next one has unique labels
				$ifCount++;
			}
			# Push the result to the stack
			print( $OUTPUT "PUSH D\n" );
			$byteCount += 1;
		}
		# Stack Operation Commands
		elsif( $1 eq 'push' ) {
			print( "\tCommand: push " ) if $debug;
			# $2 has the relevant segment, and $3 the index of said segment
			# Standard Segments (Will need Helper Function)
			if( $2 eq 'argument' ) {
				print( "Segment: argument Index: $3\n" ) if $debug;
				print( $OUTPUT "// push argument $3\n" ) if $debug;
				# Load in the offset as a constant
				printf( $OUTPUT "LXI B,%04X\n", ($3 * -2) & 0xFFFF );		# 3 Bytes, 10 T-States
				# Read in the base address of the segment and apply the offset
				print( $OUTPUT "LHLD ARG\nDAD B\n" );		# 4 Bytes, 26 T-States
				# Read the value from memory
				print( $OUTPUT "MOV C,M\nINX H\nMOV B,M\n" );	# 3 Bytes, 20 T-States
				# Push the item onto the stack
				print( $OUTPUT "PUSH B\n" );			# 1 Byte, 12 T-States
				$byteCount += 11;
				# Total 11 Bytes, 68 T-States
			} elsif( $2 eq 'local' ) {
				print( "Segment: local Index: $3\n" ) if $debug;
				print( $OUTPUT "// push local $3\n" ) if $debug;
				# Load in the offset as a constant
				printf( $OUTPUT "LXI B,%04X\n", ($3 * -2) & 0xFFFF );		# 3 Bytes, 10 T-States
				# Read in the base address of the segment and apply the offset
				print( $OUTPUT "LHLD LCL\nDAD B\n" );		# 4 Bytes, 26 T-States
				# Read the value from memory
				print( $OUTPUT "MOV C,M\nINX H\nMOV B,M\n" );	# 3 Bytes, 20 T-States
				# Push the item onto the stack
				print( $OUTPUT "PUSH B\n" );			# 1 Byte, 12 T-States
				$byteCount += 11;
				# Total 11 Bytes, 68 T-States
			} elsif( $2 eq 'this' ) {
				print( "Segment: this Index: $3\n" ) if $debug;
				print( $OUTPUT "// push this $3\n" ) if $debug;
				# Load in the offset as a constant
				printf( $OUTPUT "LXI B,%04X\n", $3 );		# 3 Bytes, 10 T-States
				# Read in the base address of the segment and apply the offset
				print( $OUTPUT "LHLD THIS\nDAD B\n" );		# 4 Bytes, 26 T-States
				if( $optimization ) {
					# Call the VM Memory helper function
					print( $OUTPUT "CALL VM\$memory\n" );
					$byteCount += 3;
					}
				else {
					# Convert the Jack VM Address to 8085 Address (Invert & Multiply by two)
					print( $OUTPUT "XRA A\nMOV A,L\nCMA\nRAL\nMOV L,A\nMOV A,H\nCMA\nRAL\nMOV H,A\n" );
					$byteCount += 23;
				}
				# Read the value from memory
				print( $OUTPUT "MOV C,M\nINX H\nMOV B,M\n" );	# 3 Bytes, 20 T-States
				# Push the item onto the stack
				print( $OUTPUT "PUSH B\n" );			# 1 Byte, 12 T-States
				$byteCount += 14;
				# Total 14 Bytes, 122 T-States
			} elsif( $2 eq 'that' ) {
				print( "Segment: that Index: $3\n" ) if $debug;
				print( $OUTPUT "// push that $3\n" ) if $debug;
				# Load in the offset as a constant
				printf( $OUTPUT "LXI B,%04X\n", $3 );		# 3 Bytes, 10 T-States
				# Read in the base address of the segment and apply the offset
				print( $OUTPUT "LHLD THAT\nDAD B\n" );		# 4 Bytes, 26 T-States
				if( $optimization ) {
					# Call the VM Memory helper function
					print( $OUTPUT "CALL VM\$memory\n" );
					$byteCount += 3;
					}
				else {
					# Convert the Jack VM Address to 8085 Address (Invert & Multiply by two)
					print( $OUTPUT "XRA A\nMOV A,L\nCMA\nRAL\nMOV L,A\nMOV A,H\nCMA\nRAL\nMOV H,A\n" );
					$byteCount += 23;
				}
				# Read the value from memory
				print( $OUTPUT "MOV C,M\nINX H\nMOV B,M\n" );	# 3 Bytes, 20 T-States
				# Push the item onto the stack
				print( $OUTPUT "PUSH B\n" );			# 1 Byte, 12 T-States
				$byteCount += 14;
				# Total 14 Bytes, 122 T-States
			}
			# Special Segments (Variable names, don't need doubled)
			elsif( $2 eq 'pointer' ) {
				print( "Segment: pointer Index: $3\n" ) if $debug;
				print( $OUTPUT "// push pointer $3\n" ) if $debug;
				# Load the relevant pointer
				if ( $3 ) { print( $OUTPUT "LHLD THAT\n" ); }
				else { print( $OUTPUT "LHLD THIS\n" ); } # 3 Bytes, 16 T-States
				# And push it onto the stack
				print( $OUTPUT "PUSH H\n" ); # 1 Byte, 12 T-States
				$byteCount += 4;
				# Total 4 Bytes, 28 T-States
			} elsif( $2 eq 'temp' ) {
				print( "Segment: temp Index: $3\n" ) if $debug;
				print( $OUTPUT "// push temp $3\n" ) if $debug;
				# Load the value
				print( $OUTPUT "LHLD TEMP$3\n" ); # 3 Bytes, 16 T-States
				# Push to Stack
				print( $OUTPUT "PUSH H\n" ); # 1 Byte, 10 T-States
				$byteCount += 4;
				# Total 4 Bytes, 26 T-States
			} elsif( $2 eq 'static' ) {
				print( "Segment: static Index: $3\n" ) if $debug;
				print( $OUTPUT "// push static $3\n" ) if $debug;
				# Construct the variable name
				my $target = join( '$', $class, $3);
				print( "\tTranslated: $target\n" ) if $debug;
				print( $OUTPUT "// Translated: $target\n" ) if $debug;
				# Load the Value
				print( $OUTPUT "LHLD $target\n" ); # 3 Bytes, 16 T-States
				# Push to Stack
				print( $OUTPUT "PUSH H\n" ); # 1 Byte, 12 T-States
				$byteCount += 4;
				# Total 4 Bytes, 28 T-States
				# Update the number of static variables this class uses
				$var = $3 if( $3 > $var );
			} elsif( $2 eq 'constant' ) {
				print( "Segment: constant Value: $3\n" ) if $debug;
				print( $OUTPUT "// push constant $3\n" ) if $debug;
				# Load the Constant
				printf( $OUTPUT "LXI B,%04X\n", $3 ); # 3 Bytes, 10 T-States
				# Push to Stack
				print( $OUTPUT "PUSH B\n" ); # 1 Byte, 12 T-States
				$byteCount += 4;
				# Total 4 Bytes, 28 T-States
			} else {
				die( "Unknown Segment $2 in push\n" );
			}
			
		} elsif( $1 eq 'pop' ) {
			print( "\tCommand: pop " ) if $debug;
			# $2 has the relevant segment, and $3 the index of said segment
			# Standard Segments (Will need Helper function)
			if( $2 eq 'argument' ) {
				print( "Segment: argument Index: $3\n" ) if $debug;
				print( $OUTPUT "// pop argument $3\n" ) if $debug;
				# Load in the offset as a constant
				printf( $OUTPUT "LXI B,%04X\n", ($3 * -2) & 0xFFFF );		# 3 Bytes, 10 T-States
				# Read in the base address of the segment and apply the offset
				printf( $OUTPUT "LHLD ARG\nDAD B\n" );
				# Pop the value off the stack
				print( $OUTPUT "POP B\n" );		# 1 Byte, 10 T-States
				# Write the value into memory
				print( $OUTPUT "MOV M,C\nINX H\nMOV M,B\n" );	# 3 Bytes, 20 T-States
				$byteCount += 11;
				# Total 11 Bytes, 66 T-States
			} elsif( $2 eq 'local' ) {
				print( "Segment: local Index: $3\n" ) if $debug;
				print( $OUTPUT "// pop local $3\n" ) if $debug;
				# Load in the offset as a constant
				printf( $OUTPUT "LXI B,%04X\n", ($3 * -2) & 0xFFFF );		# 3 Bytes, 10 T-States
				# Read in the base address of the segment and apply the offset
				print( $OUTPUT "LHLD LCL\nDAD B\n" );		# 4 Bytes, 26 T-States
				# Pop the value off the stack
				print( $OUTPUT "POP B\n" );		# 1 Byte, 10 T-States
				# Write the value into memory
				print( $OUTPUT "MOV M,C\nINX H\nMOV M,B\n" );	# 3 Bytes, 20 T-States
				$byteCount += 11;
				# Total 11 Bytes, 66 T-States
			} elsif( $2 eq 'this' ) {
				print( "Segment: this Index: $3\n" ) if $debug;
				print( $OUTPUT "// pop this $3\n" ) if $debug;
				# Load in the offset as a constant
				printf( $OUTPUT "LXI B,%04X\n", $3 );		# 3 Bytes, 10 T-States
				# Read in the base address of the segment and apply the offset
				print( $OUTPUT "LHLD THIS\nDAD B\n" );		# 4 Bytes, 26 T-States
				if( $optimization ) {
					# Call the VM Memory helper function
					print( $OUTPUT "CALL VM\$memory\n" );
					$byteCount += 3;
					}
				else {
					# Convert the Jack VM Address to 8085 Address (Invert & Multiply by two)
					print( $OUTPUT "XRA A\nMOV A,L\nCMA\nRAL\nMOV L,A\nMOV A,H\nCMA\nRAL\nMOV H,A\n" );
					$byteCount += 23;
				}
				# Pop the value off the stack
				print( $OUTPUT "POP B\n" );		# 1 Byte, 10 T-States
				# Write the value into memory
				print( $OUTPUT "MOV M,C\nINX H\nMOV M,B\n" );	# 3 Bytes, 20 T-States
				$byteCount += 14;
				# Total 14 Bytes not including VMmemory, 102 T-States including VMmemory
			} elsif( $2 eq 'that' ) {
				print( "Segment: that Index: $3\n" ) if $debug;
				print( $OUTPUT "// pop that $3\n" ) if $debug;
				# Load in the offset as a constant
				printf( $OUTPUT "LXI B,%04X\n", $3 );		# 3 Bytes, 10 T-States
				# Read in the base address of the segment and apply the offset
				print( $OUTPUT "LHLD THAT\nDAD B\n" );		# 4 Bytes, 26 T-States
				# Call the helper function to convert the hack address to 8085 address
				if( $optimization ) {
					# Call the VM Memory helper function
					print( $OUTPUT "CALL VM\$memory\n" );
					$byteCount += 3;
					}
				else {
					# Convert the Jack VM Address to 8085 Address (Invert & Multiply by two)
					print( $OUTPUT "XRA A\nMOV A,L\nCMA\nRAL\nMOV L,A\nMOV A,H\nCMA\nRAL\nMOV H,A\n" );
					$byteCount += 23;
				}
				# Pop the value off the stack
				print( $OUTPUT "POP B\n" );		# 1 Byte, 10 T-States
				# Write the value into memory
				print( $OUTPUT "MOV M,C\nINX H\nMOV M,B\n" );	# 3 Bytes, 20 T-States
				$byteCount += 14;
				# Total 14 Bytes, 102 T-States
			}
			# Special Segments (Variable names, don't need doubled)
			elsif( $2 eq 'pointer' ) {
				print( "Segment: pointer Index: $3\n" ) if $debug;
				print( $OUTPUT "// pop pointer $3\n" ) if $debug;
				# Pop the new pointer off the stack
				print( $OUTPUT "POP H\n" ); # 1 Byte, 10 T-States
				# Store it in the relevant location
				if ( $3 ) { print( $OUTPUT "SHLD THAT\n" ); }
				else { print( $OUTPUT "SHLD THIS\n" ); } # 3 Bytes, 16 T-States
				$byteCount += 4;
				# Total 4 Bytes, 26 T-States
			} elsif( $2 eq 'temp' ) {
				print( "Segment: temp Index: $3\n" ) if $debug;
				print( $OUTPUT "// pop temp $3\n" ) if $debug;
				# Construct the variable name
				my $target = "TEMP$3";
				# Pop from the Stack
				print( $OUTPUT "POP H\n" ); # 1 Byte, 10 T-States
				# Store the value
				print( $OUTPUT "SHLD $target\n" ); # 3 Bytes, 16 T-States
				$byteCount += 4;
				# Total 4 Bytes, 26 T-States
			} elsif( $2 eq 'static' ) {
				print( "Segment: static Index: $3\n" ) if $debug;
				print( $OUTPUT "// pop static $3\n" ) if $debug;
				# Construct the variable name
				my $target = join( '$', $class, $3);
				print( "\tTranslated: $target\n" ) if $debug;
				print( $OUTPUT "// Translated: $target\n" ) if $debug;
				# Pop from the stack
				print( $OUTPUT "POP H\n" ); # 1 Byte, 10 T-States
				# Store the Value
				print( $OUTPUT "SHLD $target\n" ); # 3 Bytes, 16 T-States
				$byteCount += 4;
				# Total 4 Bytes, 28 T-States
				# Update the number of static variables this class uses
				$var = $3 if( $3 > $var );
			} else {
				print( "Unknown Segment\n" );
			}
		}
		# Program Flow Commands	
		elsif( $1 eq 'label' ) {
			print( "\tCommand: label Target: $2\n" ) if $debug;
			print( $OUTPUT "// label '$2'\n" ) if $debug;
			my $target = join( '$', $function, $2 );
			print( "\tTranslated: $target\n" ) if $debug;
			print( $OUTPUT "// Translated: $target\n" ) if $debug;
			print( $OUTPUT "$target:\n" ); # 0 Bytes, converted by assembler
		} elsif( $1 eq 'goto' ) {
			print( "\tCommand: goto Target: $2\n" ) if $debug;
			print( $OUTPUT "// goto '$2'\n" ) if $debug;
			my $target = join( '$', $function, $2 );
			print( "\tTranslated: $target\n" ) if $debug;
			print( $OUTPUT "// Translated: $target\n" ) if $debug;
			print( $OUTPUT "JMP $target\n" ); # 3 Bytes, 10 T-States
			$byteCount += 3;
		} elsif( $1 eq 'if-goto' ) {
			print( "\tCommand: if-goto Target: $2\n" ) if $debug;
			print( $OUTPUT "// if-goto '$2'\n" ) if $debug;
			my $target = join( '$', $function, $2 );
			print( "\tTranslated: $target\n" ) if $debug;
			print( $OUTPUT "// Translated: $target\n" ) if $debug;
			print( $OUTPUT "POP H\nMOV A,H\nORA L\nJNZ $target\n" ); # 6 Bytes, 28 T-States
			$byteCount += 6;
		}
		# Function Commands
		elsif( $1 eq 'call') {
			print( "\tCommand: call Target: $2 Args: $3\n" ) if $debug;
			print( $OUTPUT "// call '$2':$3\n" ) if $debug;
			# Initialize HL with the argument memory offset
			printf( $OUTPUT "LXI H,%04X\n", ($3 * 2 - 2) & 0xFFFF ); # 3 Bytes, 10 Cycles
			# Add SP to HL, to get the new ARG.  Store a copy on the stack, and stash a copy in DE for function to use
			print( $OUTPUT "DAD SP\nPUSH H\nXCHG\n" ); # 2 Bytes, 14 T-States
			# Call the target function, thus initializing the stack frame with the return address
			print( $OUTPUT "CALL $2\n" ); # 3 Bytes, 18 T-States
			# Return stashes the return variable in DE
			# Collect the defunct ARG, which serves both as the new SP
			#  and the memory address where we need to store the return variable
			print( $OUTPUT "POP H\nSPHL\nMOV M,D\nINX H\nMOV M,E\n" ); # 5 Bytes, 36 T-States
			$byteCount += 13;
			# Total 13 Bytes, 78 T-States
		} elsif( $1 eq 'function') {
			print( "\tCommand: function Name: $2 Vars: $3\n" ) if $debug;
			print( $OUTPUT "// function '$2':$3\n" ) if $debug;
			$function = $2;
			my $target = join( '$', $function );
			print( "\tTranslated: $target\n" ) if $debug;
			print( $OUTPUT "// Translated: $target\n" ) if $debug;
			# Print Function Label, and construct remainder of Caller's stack Frame
			print( $OUTPUT "$target:\nLHLD LCL\nPUSH H\nLHLD ARG\nPUSH H\nLHLD THIS\nPUSH H\nLHLD THAT\nPUSH H\n" ); # 16 Bytes, 112 T-States
			# Call stashes the new ARG in DE, so we can now put it in the appropriate place
			print( $OUTPUT "XCHG\nSHLD ARG\n" ); # 4 Bytes, 20 T-States
			# Subtract two from SP to get LCL
			print( $OUTPUT "LXI H,FFFE\nDAD SP\nSHLD LCL\n" ); # 7 Bytes, 36 T-States
			$byteCount += 27;
			if( $3 ) {
				# Push onto the stack 0x0000 as many times as the number of arguments supplied
				print( $OUTPUT "LXI H,0000\n" ); # plus 3 Bytes, 10 T-States if non-zero local variables
				$byteCount += 3;
				for ( my $i = $3; $i > 0; $i-- ) { 
					print( $OUTPUT "PUSH H\n" );
					$byteCount++;
				} # plus 1 Bytes, 12 T-States per local variable
			}
			# Total 30+n Bytes, 178+12n Cycles where n is local variable count
		} elsif( $1 eq 'return') {
			print( "\tCommand: return\n" ) if $debug;
			print( $OUTPUT "// return\n" ) if $debug;
			# Collect the return value and Stash it in DE
			print( $OUTPUT "POP D\n" );	# 1 Byte, 10 T-States
			# Update SP to point to the bottom of the frame (address before LCL)
			print( $OUTPUT "LHLD LCL\nINX H\nINX H\nSPHL\n" ); # 6 Bytes, 34 T-States
			# Restore the Caller's Segments
			print( $OUTPUT "POP H\nSHLD THAT\nPOP H\nSHLD THIS\nPOP H\nSHLD ARG\nPOP H\nSHLD LCL\n" ); # 16 Bytes, 104 T-States
			# Finally return
			print( $OUTPUT "RET\n" ); # 1 Byte, 10 T-States
			$byteCount += 24;
			# Total: 24 Bytes, 158 T-States
		} else {
			print( "Unknown Command $1\n" );
		}
	}
	print( "Closing...\n" ) if $debug;
	close( $INPUT );
	return 0;
}
