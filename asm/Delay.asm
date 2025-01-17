s// Init Sequence
LXI H,40FF
SPHL
// Main Loop
MAINLOOP:
	MVI A,02
	STA 8000
	CALL DELAY
	MVI A,00
	STA 8000
	CALL DELAY
	JMP MAINLOOP

// New and improved delay method
// Actually delays a whole second on Kyle's Computer
DELAY:
	PUSH PSW
	PUSH B
	LXI B,C9F3
	DEL_LOOP:
		DCX B
		MOV A,B
		ADD C
		JC DEL_LOOP
		JNZ DEL_LOOP
	POP B
	POP PSW
	RET
