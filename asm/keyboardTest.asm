// Initialize Stack Pointer
LXI H,4FFF
SPHL
// Zero out other registers
XRA A
MOV B,A
MOV C,A
MOV D,A
MOV E,A

// Initialize Heap Pointer
LXI H,4100
SHLD 4000
// Zero out the top heap structure
LXI H,0000
SHLD 4100
SHLD 4102

MAINLOOP:
	CALL KEYBOARD	// Blocking Read of Keyboard
	CALL SCREEN	// Update Screen
	JMP MAINLOOP
// END OF MAIN LOOP

KEYBOARD:
	LXI H,8010	// Keyboard at 0x8010-0x8013
	MVI C,04	// Loop Variable
	KEYLOOP:
		MOV A,M	// Read memory
		ADI 00	// Add zero to flags
		JNZ GOTKEY	// If not zero, a key is pressed
		INX H	// Move on to next memory space
		DCR C		
		JNZ KEYLOOP// and try again
	JMP KEYBOARD	// None of the four keys are pressed, start over
	GOTKEY:	// Label for exiting the keyloop when a press is detected
	MOV B,A	// Store the keyboard information in B
	KEYWAIT:
		MOV A,M	// Read the key again
		ADI 00	// Add zero to set flags
		JNZ KEYWAIT// Jump back if the key is still pressed
	// Normally we would process here to get a keymap pointer
	// Instead, we'll write this to memory to put it on the screen
	XCHG	// Keyboard Address now in DE
	LHLD 4000	// Get the heap pointer
	MOV M,B	// Put Key information at digits 0 and 1 
	INX H	// Add 2 to HL
	MVI M,00
	INX H	// DE and B are in use, so we can't DAD
	MOV M,E	// Put L of Keyboard Address at digits 4 and 5
	INX H
	MOV M,D	// Put H of Keyboard Address at digits 6 and 7
	RET
// END KEYBOARD

SCREEN:
	LXI H,8000	// Initialize Pointer to Screen at 0x8000-0x8007
	XCHG
	LHLD 4000	// Get pointer to Heap
	MVI C,04	// Loop Variable
	SCREENLOOP:
			MOV B,M	// Get two digits of the number to display
			XCHG	// switch to Screen pointer
			MOV A,B
			ANI 0F	// Get the lower digit
			MOV M,A	// Put it into the screen
			INX H	// Go to the next screen display
			MOV A,B
			ANI F0	// Get the upper digit
			RRC
			RRC	// Shift Right four times
			RRC	// to get the digit in the right nibble
			RRC
			MOV M,A	// Put it into the screen
			INX H	// Go to the next screen display
			XCHG	// switch back to heap pointer
			INX H	// and increment it				
			DCR C	// Decrement counter
			JNZ SCREENLOOP
	// All 8 digits have been written to
	RET
// END OF SCREEN
