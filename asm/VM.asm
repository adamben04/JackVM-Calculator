// Bootstrap Code
LXI H,FE00
SPHL
SHLD LCL
SHLD ARG
SHLD THIS
SHLD THAT
XCHG
PUSH D
CALL Memory$init
CALL Main$main
Sys$halt:
HLT
Sys$error:
XCHG
MVI A,0B
OUT 02
OUT 03
OUT 04
INR A
OUT 07
INR A
OUT 06
OUT 05
MOV B,M
MOV A,B
ANI 0F
OUT 00
MOV A,B
ANI F0
RAR
RAR
RAR
RAR
OUT 01
JMP Sys$halt
// VM Helper Functions
VM$str2out:
DCX H
DCX H
MOV A,M
SBI 30
MOV C,A
DCX H
DCX H
MOV A,M
CPI 2E
MOV A,C
RNZ
ORI 80
RET
VM$memory:
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
RET
VM$gt:
MOV A,B
CMP H
JC VM$true
MOV A,C
CMP L
JC VM$true
VM$false:
LXI D,0000
RET
VM$eq:
MOV A,C
CMP L
JNZ VM$false
MOV A,B
CMP H
JNZ VM$false
VM$true:
LXI D,FFFF
RET
Output$printString:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
LXI H,FFFE
DAD SP
SHLD LCL
XCHG
MOV E,M
INX H
MOV D,M
XCHG
CALL VM$memory
DCX H
DCX H
MOV D,M
DCX H
MOV E,M
XCHG
CALL VM$memory
MOV A,M
CPI 2D
JNZ Output$printString$IF_FALSE0
MVI C,0A
JMP Output$printString$IF_END0
Output$printString$IF_FALSE0:
MVI C,0B
Output$printString$IF_END0:
DCX H
DCX H
MOV A,M
CPI 2E
MOV A,C
JNZ Output$printString$IF_END1
ORI 80
Output$printString$IF_END1:
OUT 07
CALL VM$str2out
OUT 06
CALL VM$str2out
OUT 05
CALL VM$str2out
OUT 04
CALL VM$str2out
OUT 03
CALL VM$str2out
OUT 02
CALL VM$str2out
OUT 01
CALL VM$str2out
OUT 00
LXI D,0000
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
Output$println:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
LXI H,FFFE
DAD SP
SHLD LCL
LXI D,0000
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
Keyboard$readChar:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
LXI H,FFFE
DAD SP
SHLD LCL
MVI C,00
Keyboard$readChar$KEY1:
MVI B,00
IN 10
ADD C
JZ Keyboard$readChar$KEY2
MOV D,A
Keyboard$readChar$WAIT1:
IN 10
ADD C
JNZ Keyboard$readChar$WAIT1
JMP Keyboard$readChar$KEYEND
Keyboard$readChar$KEY2:
INR B
IN 11
ADD C
JZ Keyboard$readChar$KEY3
MOV D,A
Keyboard$readChar$WAIT2:
IN 11
ADD C
JNZ Keyboard$readChar$WAIT2
JMP Keyboard$readChar$KEYEND
Keyboard$readChar$KEY3:
INR B
IN 12
ADD C
JZ Keyboard$readChar$KEY4
MOV D,A
Keyboard$readChar$WAIT3:
IN 12
ADD C
JNZ Keyboard$readChar$WAIT3
JMP Keyboard$readChar$KEYEND
Keyboard$readChar$KEY4:
INR B
IN 13
ADD C
JZ Keyboard$readChar$KEY1
MOV D,A
Keyboard$readChar$WAIT4:
IN 13
ADD C
JNZ Keyboard$readChar$WAIT4
JMP Keyboard$readChar$KEYEND
Keyboard$readChar$KEYEND:
MOV A,D
Keyboard$readChar$LOOP:
RAL
JNZ Keyboard$readChar$LOOPEND
INR C
JMP Keyboard$readChar$LOOP
Keyboard$readChar$LOOPEND:
MVI A,05
OUT 0F
MOV A,B
OUT 07
MOV A,C
OUT 06
MOV A,B
RLC
RLC
RLC
ORA C
MVI B,00
CMP B
MVI E,5E
JZ Keyboard$readChar$MAPEND
INR B
CMP B
MVI E,2A
JZ Keyboard$readChar$MAPEND
INR B
CMP B
MVI E,2B
JZ Keyboard$readChar$MAPEND
INR B
INR B
CMP B
MVI E,52
JZ Keyboard$readChar$MAPEND
INR B
CMP B
MVI E,2F
JZ Keyboard$readChar$MAPEND
INR B
CMP B
MVI E,2D
JZ Keyboard$readChar$MAPEND
INR B
INR B
CMP B
MVI E,54
JZ Keyboard$readChar$MAPEND
INR B
CMP B
MVI E,43
JZ Keyboard$readChar$MAPEND
INR B
CMP B
MVI E,53
JZ Keyboard$readChar$MAPEND
INR B
INR B
CMP B
MVI E,30
JZ Keyboard$readChar$MAPEND
INR B
CMP B
MVI E,45
JZ Keyboard$readChar$MAPEND
INR B
CMP B
MVI E,50
JZ Keyboard$readChar$MAPEND
INR B
INR B
CMP B
MVI E,31
JZ Keyboard$readChar$MAPEND
INR B
CMP B
MVI E,34
JZ Keyboard$readChar$MAPEND
INR B
CMP B
MVI E,37
JZ Keyboard$readChar$MAPEND
INR B
INR B
CMP B
MVI E,32
JZ Keyboard$readChar$MAPEND
INR B
CMP B
MVI E,35
JZ Keyboard$readChar$MAPEND
INR B
CMP B
MVI E,38
JZ Keyboard$readChar$MAPEND
INR B
INR B
CMP B
MVI E,33
JZ Keyboard$readChar$MAPEND
INR B
CMP B
MVI E,36
JZ Keyboard$readChar$MAPEND
INR B
CMP B
MVI E,39
JZ Keyboard$readChar$MAPEND
INR B
INR B
CMP B
MVI E,80
JZ Keyboard$readChar$MAPEND
INR B
CMP B
MVI E,81
JZ Keyboard$readChar$MAPEND
INR B
CMP B
MVI E,2E
JZ Keyboard$readChar$MAPEND
MVI E,00
Keyboard$readChar$MAPEND:
MVI D,00
MOV A,E
ANI 0F
OUT 00
MOV A,E
ANI F0
RAR
RAR
RAR
RAR
OUT 01
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$init':0
// Translated: ArbNum$init
ArbNum$init:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push constant 16
LXI B,0010
PUSH B
// pop static 0
// Translated: ArbNum$0
POP H
SHLD ArbNum$0
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$getOffset':0
// Translated: ArbNum$getOffset
ArbNum$getOffset:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$getSign':0
// Translated: ArbNum$getSign
ArbNum$getSign:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push this 0
LXI B,0000
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$getDigits':0
// Translated: ArbNum$getDigits
ArbNum$getDigits:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$getPrecision':0
// Translated: ArbNum$getPrecision
ArbNum$getPrecision:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$setSign':0
// Translated: ArbNum$setSign
ArbNum$setSign:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop this 0
LXI B,0000
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$setOffset':0
// Translated: ArbNum$setOffset
ArbNum$setOffset:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$new':5
// Translated: ArbNum$new
ArbNum$new:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
PUSH H
PUSH H
PUSH H
// push constant 3
LXI B,0003
PUSH B
// call 'Memory$alloc':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Memory$alloc
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop pointer 0
POP H
SHLD THIS
// push constant 0
LXI B,0000
PUSH B
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'String$length':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$length
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// call 'Array$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Array$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP0'
// Translated: ArbNum$new$WHILE_EXP0
ArbNum$new$WHILE_EXP0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: ArbNum$new$WHILE_END0
POP H
MOV A,H
ORA L
JNZ ArbNum$new$WHILE_END0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push constant 0
LXI B,0000
PUSH B
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP0'
// Translated: ArbNum$new$WHILE_EXP0
JMP ArbNum$new$WHILE_EXP0
// label 'WHILE_END0'
// Translated: ArbNum$new$WHILE_END0
ArbNum$new$WHILE_END0:
// push constant 0
LXI B,0000
PUSH B
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push constant 0
LXI B,0000
PUSH B
// pop this 0
LXI B,0000
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP1'
// Translated: ArbNum$new$WHILE_EXP1
ArbNum$new$WHILE_EXP1:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'String$charAt':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$charAt
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// and
POP B
POP H
MOV A,L
ANA C
MOV L,A
MOV A,H
ANA B
MOV H,A
PUSH H
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END1'
// Translated: ArbNum$new$WHILE_END1
POP H
MOV A,H
ORA L
JNZ ArbNum$new$WHILE_END1
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'String$length':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$length
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 1
LXI B,0001
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// call 'String$charAt':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$charAt
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// and
POP B
POP H
MOV A,L
ANA C
MOV L,A
MOV A,H
ANA B
MOV H,A
PUSH H
// if-goto 'IF_TRUE0'
// Translated: ArbNum$new$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ ArbNum$new$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: ArbNum$new$IF_FALSE0
JMP ArbNum$new$IF_FALSE0
// label 'IF_TRUE0'
// Translated: ArbNum$new$IF_TRUE0
ArbNum$new$IF_TRUE0:
// push constant 0
LXI B,0000
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push constant 0
LXI B,0000
PUSH B
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// pop this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push pointer 0
LHLD THIS
PUSH H
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE0'
// Translated: ArbNum$new$IF_FALSE0
ArbNum$new$IF_FALSE0:
// goto 'WHILE_EXP1'
// Translated: ArbNum$new$WHILE_EXP1
JMP ArbNum$new$WHILE_EXP1
// label 'WHILE_END1'
// Translated: ArbNum$new$WHILE_END1
ArbNum$new$WHILE_END1:
// label 'WHILE_EXP2'
// Translated: ArbNum$new$WHILE_EXP2
ArbNum$new$WHILE_EXP2:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// and
POP B
POP H
MOV A,L
ANA C
MOV L,A
MOV A,H
ANA B
MOV H,A
PUSH H
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END2'
// Translated: ArbNum$new$WHILE_END2
POP H
MOV A,H
ORA L
JNZ ArbNum$new$WHILE_END2
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'String$charAt':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$charAt
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 4
LXI B,FFF8
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 46
LXI B,002E
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE1'
// Translated: ArbNum$new$IF_TRUE1
POP H
MOV A,H
ORA L
JNZ ArbNum$new$IF_TRUE1
// goto 'IF_FALSE1'
// Translated: ArbNum$new$IF_FALSE1
JMP ArbNum$new$IF_FALSE1
// label 'IF_TRUE1'
// Translated: ArbNum$new$IF_TRUE1
ArbNum$new$IF_TRUE1:
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// goto 'IF_END1'
// Translated: ArbNum$new$IF_END1
JMP ArbNum$new$IF_END1
// label 'IF_FALSE1'
// Translated: ArbNum$new$IF_FALSE1
ArbNum$new$IF_FALSE1:
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 32
LXI B,0020
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'IF_TRUE2'
// Translated: ArbNum$new$IF_TRUE2
POP H
MOV A,H
ORA L
JNZ ArbNum$new$IF_TRUE2
// goto 'IF_FALSE2'
// Translated: ArbNum$new$IF_FALSE2
JMP ArbNum$new$IF_FALSE2
// label 'IF_TRUE2'
// Translated: ArbNum$new$IF_TRUE2
ArbNum$new$IF_TRUE2:
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 48
LXI B,0030
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// label 'IF_FALSE2'
// Translated: ArbNum$new$IF_FALSE2
ArbNum$new$IF_FALSE2:
// label 'IF_END1'
// Translated: ArbNum$new$IF_END1
ArbNum$new$IF_END1:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP2'
// Translated: ArbNum$new$WHILE_EXP2
JMP ArbNum$new$WHILE_EXP2
// label 'WHILE_END2'
// Translated: ArbNum$new$WHILE_END2
ArbNum$new$WHILE_END2:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'String$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push pointer 0
LHLD THIS
PUSH H
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$copy':2
// Translated: ArbNum$copy
ArbNum$copy:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
// push constant 3
LXI B,0003
PUSH B
// call 'Memory$alloc':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Memory$alloc
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop pointer 0
POP H
SHLD THIS
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop this 0
LXI B,0000
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// call 'Array$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Array$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getDigits':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getDigits
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP0'
// Translated: ArbNum$copy$WHILE_EXP0
ArbNum$copy$WHILE_EXP0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: ArbNum$copy$WHILE_END0
POP H
MOV A,H
ORA L
JNZ ArbNum$copy$WHILE_END0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP0'
// Translated: ArbNum$copy$WHILE_EXP0
JMP ArbNum$copy$WHILE_EXP0
// label 'WHILE_END0'
// Translated: ArbNum$copy$WHILE_END0
ArbNum$copy$WHILE_END0:
// push pointer 0
LHLD THIS
PUSH H
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$isGreater':2
// Translated: ArbNum$isGreater
ArbNum$isGreater:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'IF_TRUE0'
// Translated: ArbNum$isGreater$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ ArbNum$isGreater$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: ArbNum$isGreater$IF_FALSE0
JMP ArbNum$isGreater$IF_FALSE0
// label 'IF_TRUE0'
// Translated: ArbNum$isGreater$IF_TRUE0
ArbNum$isGreater$IF_TRUE0:
// push this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE0'
// Translated: ArbNum$isGreater$IF_FALSE0
ArbNum$isGreater$IF_FALSE0:
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getDigits':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getDigits
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP0'
// Translated: ArbNum$isGreater$WHILE_EXP0
ArbNum$isGreater$WHILE_EXP0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// and
POP B
POP H
MOV A,L
ANA C
MOV L,A
MOV A,H
ANA B
MOV H,A
PUSH H
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: ArbNum$isGreater$WHILE_END0
POP H
MOV A,H
ORA L
JNZ ArbNum$isGreater$WHILE_END0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP0'
// Translated: ArbNum$isGreater$WHILE_EXP0
JMP ArbNum$isGreater$WHILE_EXP0
// label 'WHILE_END0'
// Translated: ArbNum$isGreater$WHILE_END0
ArbNum$isGreater$WHILE_END0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$isEqual':2
// Translated: ArbNum$isEqual
ArbNum$isEqual:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push this 0
LXI B,0000
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'IF_TRUE0'
// Translated: ArbNum$isEqual$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ ArbNum$isEqual$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: ArbNum$isEqual$IF_FALSE0
JMP ArbNum$isEqual$IF_FALSE0
// label 'IF_TRUE0'
// Translated: ArbNum$isEqual$IF_TRUE0
ArbNum$isEqual$IF_TRUE0:
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE0'
// Translated: ArbNum$isEqual$IF_FALSE0
ArbNum$isEqual$IF_FALSE0:
// push this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'IF_TRUE1'
// Translated: ArbNum$isEqual$IF_TRUE1
POP H
MOV A,H
ORA L
JNZ ArbNum$isEqual$IF_TRUE1
// goto 'IF_FALSE1'
// Translated: ArbNum$isEqual$IF_FALSE1
JMP ArbNum$isEqual$IF_FALSE1
// label 'IF_TRUE1'
// Translated: ArbNum$isEqual$IF_TRUE1
ArbNum$isEqual$IF_TRUE1:
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE1'
// Translated: ArbNum$isEqual$IF_FALSE1
ArbNum$isEqual$IF_FALSE1:
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getDigits':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getDigits
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP0'
// Translated: ArbNum$isEqual$WHILE_EXP0
ArbNum$isEqual$WHILE_EXP0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// and
POP B
POP H
MOV A,L
ANA C
MOV L,A
MOV A,H
ANA B
MOV H,A
PUSH H
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: ArbNum$isEqual$WHILE_END0
POP H
MOV A,H
ORA L
JNZ ArbNum$isEqual$WHILE_END0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP0'
// Translated: ArbNum$isEqual$WHILE_EXP0
JMP ArbNum$isEqual$WHILE_EXP0
// label 'WHILE_END0'
// Translated: ArbNum$isEqual$WHILE_END0
ArbNum$isEqual$WHILE_END0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$arrayAdd':3
// Translated: ArbNum$arrayAdd
ArbNum$arrayAdd:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getDigits':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getDigits
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push constant 0
LXI B,0000
PUSH B
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push constant 0
LXI B,0000
PUSH B
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP0'
// Translated: ArbNum$arrayAdd$WHILE_EXP0
ArbNum$arrayAdd$WHILE_EXP0:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: ArbNum$arrayAdd$WHILE_END0
POP H
MOV A,H
ORA L
JNZ ArbNum$arrayAdd$WHILE_END0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 9
LXI B,0009
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// if-goto 'IF_TRUE0'
// Translated: ArbNum$arrayAdd$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ ArbNum$arrayAdd$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: ArbNum$arrayAdd$IF_FALSE0
JMP ArbNum$arrayAdd$IF_FALSE0
// label 'IF_TRUE0'
// Translated: ArbNum$arrayAdd$IF_TRUE0
ArbNum$arrayAdd$IF_TRUE0:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 10
LXI B,000A
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push constant 1
LXI B,0001
PUSH B
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'IF_END0'
// Translated: ArbNum$arrayAdd$IF_END0
JMP ArbNum$arrayAdd$IF_END0
// label 'IF_FALSE0'
// Translated: ArbNum$arrayAdd$IF_FALSE0
ArbNum$arrayAdd$IF_FALSE0:
// push constant 0
LXI B,0000
PUSH B
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'IF_END0'
// Translated: ArbNum$arrayAdd$IF_END0
ArbNum$arrayAdd$IF_END0:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP0'
// Translated: ArbNum$arrayAdd$WHILE_EXP0
JMP ArbNum$arrayAdd$WHILE_EXP0
// label 'WHILE_END0'
// Translated: ArbNum$arrayAdd$WHILE_END0
ArbNum$arrayAdd$WHILE_END0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE1'
// Translated: ArbNum$arrayAdd$IF_TRUE1
POP H
MOV A,H
ORA L
JNZ ArbNum$arrayAdd$IF_TRUE1
// goto 'IF_FALSE1'
// Translated: ArbNum$arrayAdd$IF_FALSE1
JMP ArbNum$arrayAdd$IF_FALSE1
// label 'IF_TRUE1'
// Translated: ArbNum$arrayAdd$IF_TRUE1
ArbNum$arrayAdd$IF_TRUE1:
// goto 'IF_END1'
// Translated: ArbNum$arrayAdd$IF_END1
JMP ArbNum$arrayAdd$IF_END1
// label 'IF_FALSE1'
// Translated: ArbNum$arrayAdd$IF_FALSE1
ArbNum$arrayAdd$IF_FALSE1:
// push pointer 0
LHLD THIS
PUSH H
// call 'ArbNum$shiftRight':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$shiftRight
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// label 'IF_END1'
// Translated: ArbNum$arrayAdd$IF_END1
ArbNum$arrayAdd$IF_END1:
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$arraySub':3
// Translated: ArbNum$arraySub
ArbNum$arraySub:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push constant 0
LXI B,0000
PUSH B
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getDigits':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getDigits
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP0'
// Translated: ArbNum$arraySub$WHILE_EXP0
ArbNum$arraySub$WHILE_EXP0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: ArbNum$arraySub$WHILE_END0
POP H
MOV A,H
ORA L
JNZ ArbNum$arraySub$WHILE_END0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// if-goto 'IF_TRUE0'
// Translated: ArbNum$arraySub$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ ArbNum$arraySub$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: ArbNum$arraySub$IF_FALSE0
JMP ArbNum$arraySub$IF_FALSE0
// label 'IF_TRUE0'
// Translated: ArbNum$arraySub$IF_TRUE0
ArbNum$arraySub$IF_TRUE0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 10
LXI B,000A
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push constant 1
LXI B,0001
PUSH B
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'IF_END0'
// Translated: ArbNum$arraySub$IF_END0
JMP ArbNum$arraySub$IF_END0
// label 'IF_FALSE0'
// Translated: ArbNum$arraySub$IF_FALSE0
ArbNum$arraySub$IF_FALSE0:
// push constant 0
LXI B,0000
PUSH B
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'IF_END0'
// Translated: ArbNum$arraySub$IF_END0
ArbNum$arraySub$IF_END0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP0'
// Translated: ArbNum$arraySub$WHILE_EXP0
JMP ArbNum$arraySub$WHILE_EXP0
// label 'WHILE_END0'
// Translated: ArbNum$arraySub$WHILE_END0
ArbNum$arraySub$WHILE_END0:
// label 'WHILE_EXP1'
// Translated: ArbNum$arraySub$WHILE_EXP1
ArbNum$arraySub$WHILE_EXP1:
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// push this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// and
POP B
POP H
MOV A,L
ANA C
MOV L,A
MOV A,H
ANA B
MOV H,A
PUSH H
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END1'
// Translated: ArbNum$arraySub$WHILE_END1
POP H
MOV A,H
ORA L
JNZ ArbNum$arraySub$WHILE_END1
// push pointer 0
LHLD THIS
PUSH H
// call 'ArbNum$shiftLeft':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$shiftLeft
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// goto 'WHILE_EXP1'
// Translated: ArbNum$arraySub$WHILE_EXP1
JMP ArbNum$arraySub$WHILE_EXP1
// label 'WHILE_END1'
// Translated: ArbNum$arraySub$WHILE_END1
ArbNum$arraySub$WHILE_END1:
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$div10':1
// Translated: ArbNum$div10
ArbNum$div10:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push constant 0
LXI B,0000
PUSH B
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP0'
// Translated: ArbNum$div10$WHILE_EXP0
ArbNum$div10$WHILE_EXP0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: ArbNum$div10$WHILE_END0
POP H
MOV A,H
ORA L
JNZ ArbNum$div10$WHILE_END0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP0'
// Translated: ArbNum$div10$WHILE_EXP0
JMP ArbNum$div10$WHILE_EXP0
// label 'WHILE_END0'
// Translated: ArbNum$div10$WHILE_END0
ArbNum$div10$WHILE_END0:
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push constant 0
LXI B,0000
PUSH B
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$shiftRight':0
// Translated: ArbNum$shiftRight
ArbNum$shiftRight:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push pointer 0
LHLD THIS
PUSH H
// call 'ArbNum$div10':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$div10
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$mul10':1
// Translated: ArbNum$mul10
ArbNum$mul10:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP0'
// Translated: ArbNum$mul10$WHILE_EXP0
ArbNum$mul10$WHILE_EXP0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: ArbNum$mul10$WHILE_END0
POP H
MOV A,H
ORA L
JNZ ArbNum$mul10$WHILE_END0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP0'
// Translated: ArbNum$mul10$WHILE_EXP0
JMP ArbNum$mul10$WHILE_EXP0
// label 'WHILE_END0'
// Translated: ArbNum$mul10$WHILE_END0
ArbNum$mul10$WHILE_END0:
// push constant 0
LXI B,0000
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push constant 0
LXI B,0000
PUSH B
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$shiftLeft':0
// Translated: ArbNum$shiftLeft
ArbNum$shiftLeft:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push pointer 0
LHLD THIS
PUSH H
// call 'ArbNum$mul10':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$mul10
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$isWholeNum':2
// Translated: ArbNum$isWholeNum
ArbNum$isWholeNum:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
// push constant 0
LXI B,0000
PUSH B
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getDigits':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getDigits
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP0'
// Translated: ArbNum$isWholeNum$WHILE_EXP0
ArbNum$isWholeNum$WHILE_EXP0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: ArbNum$isWholeNum$WHILE_END0
POP H
MOV A,H
ORA L
JNZ ArbNum$isWholeNum$WHILE_END0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'IF_TRUE0'
// Translated: ArbNum$isWholeNum$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ ArbNum$isWholeNum$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: ArbNum$isWholeNum$IF_FALSE0
JMP ArbNum$isWholeNum$IF_FALSE0
// label 'IF_TRUE0'
// Translated: ArbNum$isWholeNum$IF_TRUE0
ArbNum$isWholeNum$IF_TRUE0:
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE0'
// Translated: ArbNum$isWholeNum$IF_FALSE0
ArbNum$isWholeNum$IF_FALSE0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP0'
// Translated: ArbNum$isWholeNum$WHILE_EXP0
JMP ArbNum$isWholeNum$WHILE_EXP0
// label 'WHILE_END0'
// Translated: ArbNum$isWholeNum$WHILE_END0
ArbNum$isWholeNum$WHILE_END0:
// push constant 0
LXI B,0000
PUSH B
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$isEven':2
// Translated: ArbNum$isEven
ArbNum$isEven:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
// push constant 0
LXI B,0000
PUSH B
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getDigits':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getDigits
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 2
LXI B,0002
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// or
POP B
POP H
MOV A,L
ORA C
MOV L,A
MOV A,H
ORA B
MOV H,A
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 4
LXI B,0004
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// or
POP B
POP H
MOV A,L
ORA C
MOV L,A
MOV A,H
ORA B
MOV H,A
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 6
LXI B,0006
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// or
POP B
POP H
MOV A,L
ORA C
MOV L,A
MOV A,H
ORA B
MOV H,A
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 8
LXI B,0008
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// or
POP B
POP H
MOV A,L
ORA C
MOV L,A
MOV A,H
ORA B
MOV H,A
PUSH H
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$toString':2
// Translated: ArbNum$toString
ArbNum$toString:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// push constant 6
LXI B,0006
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// call 'String$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push this 0
LXI B,0000
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// if-goto 'IF_TRUE0'
// Translated: ArbNum$toString$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ ArbNum$toString$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: ArbNum$toString$IF_FALSE0
JMP ArbNum$toString$IF_FALSE0
// label 'IF_TRUE0'
// Translated: ArbNum$toString$IF_TRUE0
ArbNum$toString$IF_TRUE0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 45
LXI B,002D
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// goto 'IF_END0'
// Translated: ArbNum$toString$IF_END0
JMP ArbNum$toString$IF_END0
// label 'IF_FALSE0'
// Translated: ArbNum$toString$IF_FALSE0
ArbNum$toString$IF_FALSE0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 32
LXI B,0020
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_END0'
// Translated: ArbNum$toString$IF_END0
ArbNum$toString$IF_END0:
// push this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE1'
// Translated: ArbNum$toString$IF_TRUE1
POP H
MOV A,H
ORA L
JNZ ArbNum$toString$IF_TRUE1
// goto 'IF_FALSE1'
// Translated: ArbNum$toString$IF_FALSE1
JMP ArbNum$toString$IF_FALSE1
// label 'IF_TRUE1'
// Translated: ArbNum$toString$IF_TRUE1
ArbNum$toString$IF_TRUE1:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 46
LXI B,002E
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// goto 'IF_END1'
// Translated: ArbNum$toString$IF_END1
JMP ArbNum$toString$IF_END1
// label 'IF_FALSE1'
// Translated: ArbNum$toString$IF_FALSE1
ArbNum$toString$IF_FALSE1:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 32
LXI B,0020
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_END1'
// Translated: ArbNum$toString$IF_END1
ArbNum$toString$IF_END1:
// label 'WHILE_EXP0'
// Translated: ArbNum$toString$WHILE_EXP0
ArbNum$toString$WHILE_EXP0:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: ArbNum$toString$WHILE_END0
POP H
MOV A,H
ORA L
JNZ ArbNum$toString$WHILE_END0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 48
LXI B,0030
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE2'
// Translated: ArbNum$toString$IF_TRUE2
POP H
MOV A,H
ORA L
JNZ ArbNum$toString$IF_TRUE2
// goto 'IF_FALSE2'
// Translated: ArbNum$toString$IF_FALSE2
JMP ArbNum$toString$IF_FALSE2
// label 'IF_TRUE2'
// Translated: ArbNum$toString$IF_TRUE2
ArbNum$toString$IF_TRUE2:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 46
LXI B,002E
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// goto 'IF_END2'
// Translated: ArbNum$toString$IF_END2
JMP ArbNum$toString$IF_END2
// label 'IF_FALSE2'
// Translated: ArbNum$toString$IF_FALSE2
ArbNum$toString$IF_FALSE2:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 32
LXI B,0020
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_END2'
// Translated: ArbNum$toString$IF_END2
ArbNum$toString$IF_END2:
// goto 'WHILE_EXP0'
// Translated: ArbNum$toString$WHILE_EXP0
JMP ArbNum$toString$WHILE_EXP0
// label 'WHILE_END0'
// Translated: ArbNum$toString$WHILE_END0
ArbNum$toString$WHILE_END0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 40
LXI B,0028
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 9
LXI B,0009
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// if-goto 'IF_TRUE3'
// Translated: ArbNum$toString$IF_TRUE3
POP H
MOV A,H
ORA L
JNZ ArbNum$toString$IF_TRUE3
// goto 'IF_FALSE3'
// Translated: ArbNum$toString$IF_FALSE3
JMP ArbNum$toString$IF_FALSE3
// label 'IF_TRUE3'
// Translated: ArbNum$toString$IF_TRUE3
ArbNum$toString$IF_TRUE3:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 49
LXI B,0031
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 38
LXI B,0026
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// goto 'IF_END3'
// Translated: ArbNum$toString$IF_END3
JMP ArbNum$toString$IF_END3
// label 'IF_FALSE3'
// Translated: ArbNum$toString$IF_FALSE3
ArbNum$toString$IF_FALSE3:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 48
LXI B,0030
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_END3'
// Translated: ArbNum$toString$IF_END3
ArbNum$toString$IF_END3:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 41
LXI B,0029
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'ArbNum$dispose':0
// Translated: ArbNum$dispose
ArbNum$dispose:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getDigits':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getDigits
POP H
SPHL
MOV M,D
INX H
MOV M,E
// call 'Memory$deAlloc':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Memory$deAlloc
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Memory$deAlloc':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Memory$deAlloc
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Array$new':0
// Translated: Array$new
Array$new:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'IF_TRUE0'
// Translated: Array$new$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ Array$new$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: Array$new$IF_FALSE0
JMP Array$new$IF_FALSE0
// label 'IF_TRUE0'
// Translated: Array$new$IF_TRUE0
Array$new$IF_TRUE0:
// push constant 2
LXI B,0002
PUSH B
// call 'Sys$error':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Sys$error
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE0'
// Translated: Array$new$IF_FALSE0
Array$new$IF_FALSE0:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Memory$alloc':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Memory$alloc
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Array$dispose':0
// Translated: Array$dispose
Array$dispose:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push pointer 0
LHLD THIS
PUSH H
// call 'Memory$deAlloc':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Memory$deAlloc
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Main$main':0
// Translated: Main$main
Main$main:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push constant 10
LXI B,000A
PUSH B
// call 'Array$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Array$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 0
// Translated: Main$0
POP H
SHLD Main$0
// push constant 0
LXI B,0000
PUSH B
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// call 'ArbNum$init':0
LXI H,FFFE
DAD SP
PUSH H
XCHG
CALL ArbNum$init
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// call 'ArbNum$getPrecision':0
LXI H,FFFE
DAD SP
PUSH H
XCHG
CALL ArbNum$getPrecision
POP H
SPHL
MOV M,D
INX H
MOV M,E
// call 'ArbNum$getPrecision':0
LXI H,FFFE
DAD SP
PUSH H
XCHG
CALL ArbNum$getPrecision
POP H
SPHL
MOV M,D
INX H
MOV M,E
// add
POP B
POP H
DAD B
PUSH H
// push constant 2
LXI B,0002
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// call 'String$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 3
// Translated: Main$3
POP H
SHLD Main$3
// push constant 1
LXI B,0001
PUSH B
// call 'String$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// call 'Output$printString':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Output$printString
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// call 'Output$println':0
LXI H,FFFE
DAD SP
PUSH H
XCHG
CALL Output$println
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'WHILE_EXP0'
// Translated: Main$main$WHILE_EXP0
Main$main$WHILE_EXP0:
// push constant 0
LXI B,0000
PUSH B
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: Main$main$WHILE_END0
POP H
MOV A,H
ORA L
JNZ Main$main$WHILE_END0
// call 'Keyboard$readChar':0
LXI H,FFFE
DAD SP
PUSH H
XCHG
CALL Keyboard$readChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 4
// Translated: Main$4
POP H
SHLD Main$4
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// call 'String$length':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$length
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 2
// Translated: Main$2
POP H
SHLD Main$2
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push constant 43
LXI B,002B
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE0'
// Translated: Main$main$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: Main$main$IF_FALSE0
JMP Main$main$IF_FALSE0
// label 'IF_TRUE0'
// Translated: Main$main$IF_TRUE0
Main$main$IF_TRUE0:
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 5
// Translated: Main$5
POP H
SHLD Main$5
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 6
// Translated: Main$6
POP H
SHLD Main$6
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// push static 6
// Translated: Main$6
LHLD Main$6
PUSH H
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 7
// Translated: Main$7
POP H
SHLD Main$7
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// push static 7
// Translated: Main$7
LHLD Main$7
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push static 6
// Translated: Main$6
LHLD Main$6
PUSH H
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE0'
// Translated: Main$main$IF_FALSE0
Main$main$IF_FALSE0:
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push constant 45
LXI B,002D
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE1'
// Translated: Main$main$IF_TRUE1
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE1
// goto 'IF_FALSE1'
// Translated: Main$main$IF_FALSE1
JMP Main$main$IF_FALSE1
// label 'IF_TRUE1'
// Translated: Main$main$IF_TRUE1
Main$main$IF_TRUE1:
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 5
// Translated: Main$5
POP H
SHLD Main$5
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 6
// Translated: Main$6
POP H
SHLD Main$6
// push static 6
// Translated: Main$6
LHLD Main$6
PUSH H
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// call 'Math$sub':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$sub
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 7
// Translated: Main$7
POP H
SHLD Main$7
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// push static 7
// Translated: Main$7
LHLD Main$7
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push static 6
// Translated: Main$6
LHLD Main$6
PUSH H
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE1'
// Translated: Main$main$IF_FALSE1
Main$main$IF_FALSE1:
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push constant 42
LXI B,002A
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE2'
// Translated: Main$main$IF_TRUE2
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE2
// goto 'IF_FALSE2'
// Translated: Main$main$IF_FALSE2
JMP Main$main$IF_FALSE2
// label 'IF_TRUE2'
// Translated: Main$main$IF_TRUE2
Main$main$IF_TRUE2:
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 5
// Translated: Main$5
POP H
SHLD Main$5
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 6
// Translated: Main$6
POP H
SHLD Main$6
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// push static 6
// Translated: Main$6
LHLD Main$6
PUSH H
// call 'Math$mul':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$mul
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 7
// Translated: Main$7
POP H
SHLD Main$7
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// push static 7
// Translated: Main$7
LHLD Main$7
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push static 6
// Translated: Main$6
LHLD Main$6
PUSH H
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE2'
// Translated: Main$main$IF_FALSE2
Main$main$IF_FALSE2:
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push constant 47
LXI B,002F
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE3'
// Translated: Main$main$IF_TRUE3
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE3
// goto 'IF_FALSE3'
// Translated: Main$main$IF_FALSE3
JMP Main$main$IF_FALSE3
// label 'IF_TRUE3'
// Translated: Main$main$IF_TRUE3
Main$main$IF_TRUE3:
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 6
// Translated: Main$6
POP H
SHLD Main$6
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 5
// Translated: Main$5
POP H
SHLD Main$5
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// push static 6
// Translated: Main$6
LHLD Main$6
PUSH H
// call 'Math$div':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$div
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 7
// Translated: Main$7
POP H
SHLD Main$7
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// push static 7
// Translated: Main$7
LHLD Main$7
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push static 6
// Translated: Main$6
LHLD Main$6
PUSH H
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE3'
// Translated: Main$main$IF_FALSE3
Main$main$IF_FALSE3:
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push constant 80
LXI B,0050
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE4'
// Translated: Main$main$IF_TRUE4
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE4
// goto 'IF_FALSE4'
// Translated: Main$main$IF_FALSE4
JMP Main$main$IF_FALSE4
// label 'IF_TRUE4'
// Translated: Main$main$IF_TRUE4
Main$main$IF_TRUE4:
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// call 'Math$getpi':0
LXI H,FFFE
DAD SP
PUSH H
XCHG
CALL Math$getpi
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// label 'IF_FALSE4'
// Translated: Main$main$IF_FALSE4
Main$main$IF_FALSE4:
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push constant 69
LXI B,0045
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE5'
// Translated: Main$main$IF_TRUE5
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE5
// goto 'IF_FALSE5'
// Translated: Main$main$IF_FALSE5
JMP Main$main$IF_FALSE5
// label 'IF_TRUE5'
// Translated: Main$main$IF_TRUE5
Main$main$IF_TRUE5:
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// call 'Math$gete':0
LXI H,FFFE
DAD SP
PUSH H
XCHG
CALL Math$gete
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// label 'IF_FALSE5'
// Translated: Main$main$IF_FALSE5
Main$main$IF_FALSE5:
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push constant 58
LXI B,003A
PUSH B
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push constant 47
LXI B,002F
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// and
POP B
POP H
MOV A,L
ANA C
MOV L,A
MOV A,H
ANA B
MOV H,A
PUSH H
// if-goto 'IF_TRUE6'
// Translated: Main$main$IF_TRUE6
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE6
// goto 'IF_FALSE6'
// Translated: Main$main$IF_FALSE6
JMP Main$main$IF_FALSE6
// label 'IF_TRUE6'
// Translated: Main$main$IF_TRUE6
Main$main$IF_TRUE6:
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 32
LXI B,0020
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE6'
// Translated: Main$main$IF_FALSE6
Main$main$IF_FALSE6:
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push constant 46
LXI B,002E
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE7'
// Translated: Main$main$IF_TRUE7
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE7
// goto 'IF_FALSE7'
// Translated: Main$main$IF_FALSE7
JMP Main$main$IF_FALSE7
// label 'IF_TRUE7'
// Translated: Main$main$IF_TRUE7
Main$main$IF_TRUE7:
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// call 'String$eraseLastChar':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$eraseLastChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE7'
// Translated: Main$main$IF_FALSE7
Main$main$IF_FALSE7:
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push constant 82
LXI B,0052
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE8'
// Translated: Main$main$IF_TRUE8
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE8
// goto 'IF_FALSE8'
// Translated: Main$main$IF_FALSE8
JMP Main$main$IF_FALSE8
// label 'IF_TRUE8'
// Translated: Main$main$IF_TRUE8
Main$main$IF_TRUE8:
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 6
// Translated: Main$6
POP H
SHLD Main$6
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 5
// Translated: Main$5
POP H
SHLD Main$5
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// push static 6
// Translated: Main$6
LHLD Main$6
PUSH H
// call 'Math$root':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$root
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 7
// Translated: Main$7
POP H
SHLD Main$7
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// push static 7
// Translated: Main$7
LHLD Main$7
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push static 6
// Translated: Main$6
LHLD Main$6
PUSH H
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE8'
// Translated: Main$main$IF_FALSE8
Main$main$IF_FALSE8:
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push constant 94
LXI B,005E
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE9'
// Translated: Main$main$IF_TRUE9
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE9
// goto 'IF_FALSE9'
// Translated: Main$main$IF_FALSE9
JMP Main$main$IF_FALSE9
// label 'IF_TRUE9'
// Translated: Main$main$IF_TRUE9
Main$main$IF_TRUE9:
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 6
// Translated: Main$6
POP H
SHLD Main$6
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 5
// Translated: Main$5
POP H
SHLD Main$5
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// push static 6
// Translated: Main$6
LHLD Main$6
PUSH H
// call 'Math$pow':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$pow
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 7
// Translated: Main$7
POP H
SHLD Main$7
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// push static 7
// Translated: Main$7
LHLD Main$7
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push static 6
// Translated: Main$6
LHLD Main$6
PUSH H
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE9'
// Translated: Main$main$IF_FALSE9
Main$main$IF_FALSE9:
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push constant 67
LXI B,0043
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE10'
// Translated: Main$main$IF_TRUE10
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE10
// goto 'IF_FALSE10'
// Translated: Main$main$IF_FALSE10
JMP Main$main$IF_FALSE10
// label 'IF_TRUE10'
// Translated: Main$main$IF_TRUE10
Main$main$IF_TRUE10:
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 5
// Translated: Main$5
POP H
SHLD Main$5
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// call 'Math$cos':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Math$cos
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 7
// Translated: Main$7
POP H
SHLD Main$7
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// push static 7
// Translated: Main$7
LHLD Main$7
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE10'
// Translated: Main$main$IF_FALSE10
Main$main$IF_FALSE10:
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push constant 83
LXI B,0053
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE11'
// Translated: Main$main$IF_TRUE11
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE11
// goto 'IF_FALSE11'
// Translated: Main$main$IF_FALSE11
JMP Main$main$IF_FALSE11
// label 'IF_TRUE11'
// Translated: Main$main$IF_TRUE11
Main$main$IF_TRUE11:
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 5
// Translated: Main$5
POP H
SHLD Main$5
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// call 'Math$sin':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Math$sin
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 7
// Translated: Main$7
POP H
SHLD Main$7
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// push static 7
// Translated: Main$7
LHLD Main$7
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE11'
// Translated: Main$main$IF_FALSE11
Main$main$IF_FALSE11:
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push constant 84
LXI B,0054
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE12'
// Translated: Main$main$IF_TRUE12
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE12
// goto 'IF_FALSE12'
// Translated: Main$main$IF_FALSE12
JMP Main$main$IF_FALSE12
// label 'IF_TRUE12'
// Translated: Main$main$IF_TRUE12
Main$main$IF_TRUE12:
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 5
// Translated: Main$5
POP H
SHLD Main$5
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// call 'Math$tan':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Math$tan
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 7
// Translated: Main$7
POP H
SHLD Main$7
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// push static 7
// Translated: Main$7
LHLD Main$7
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE12'
// Translated: Main$main$IF_FALSE12
Main$main$IF_FALSE12:
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push constant 128
LXI B,0080
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE13'
// Translated: Main$main$IF_TRUE13
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE13
// goto 'IF_FALSE13'
// Translated: Main$main$IF_FALSE13
JMP Main$main$IF_FALSE13
// label 'IF_TRUE13'
// Translated: Main$main$IF_TRUE13
Main$main$IF_TRUE13:
// push static 2
// Translated: Main$2
LHLD Main$2
PUSH H
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// if-goto 'IF_TRUE14'
// Translated: Main$main$IF_TRUE14
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE14
// goto 'IF_FALSE14'
// Translated: Main$main$IF_FALSE14
JMP Main$main$IF_FALSE14
// label 'IF_TRUE14'
// Translated: Main$main$IF_TRUE14
Main$main$IF_TRUE14:
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// call 'ArbNum$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop static 1
// Translated: Main$1
POP H
SHLD Main$1
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// call 'String$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// call 'ArbNum$getPrecision':0
LXI H,FFFE
DAD SP
PUSH H
XCHG
CALL ArbNum$getPrecision
POP H
SPHL
MOV M,D
INX H
MOV M,E
// call 'ArbNum$getPrecision':0
LXI H,FFFE
DAD SP
PUSH H
XCHG
CALL ArbNum$getPrecision
POP H
SPHL
MOV M,D
INX H
MOV M,E
// add
POP B
POP H
DAD B
PUSH H
// push constant 2
LXI B,0002
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// call 'String$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 3
// Translated: Main$3
POP H
SHLD Main$3
// label 'IF_FALSE14'
// Translated: Main$main$IF_FALSE14
Main$main$IF_FALSE14:
// label 'IF_FALSE13'
// Translated: Main$main$IF_FALSE13
Main$main$IF_FALSE13:
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push constant 129
LXI B,0081
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE15'
// Translated: Main$main$IF_TRUE15
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE15
// goto 'IF_FALSE15'
// Translated: Main$main$IF_FALSE15
JMP Main$main$IF_FALSE15
// label 'IF_TRUE15'
// Translated: Main$main$IF_TRUE15
Main$main$IF_TRUE15:
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// call 'String$eraseLastChar':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$eraseLastChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// call 'String$eraseLastChar':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$eraseLastChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE15'
// Translated: Main$main$IF_FALSE15
Main$main$IF_FALSE15:
// goto 'WHILE_EXP0'
// Translated: Main$main$WHILE_EXP0
JMP Main$main$WHILE_EXP0
// label 'WHILE_END0'
// Translated: Main$main$WHILE_END0
Main$main$WHILE_END0:
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Main$printNum':1
// Translated: Main$printNum
Main$printNum:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$toString':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$toString
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Output$printString':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Output$printString
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// call 'Output$println':0
LXI H,FFFE
DAD SP
PUSH H
XCHG
CALL Output$println
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'String$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Math$init':0
// Translated: Math$init
Math$init:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// call 'ArbNum$init':0
LXI H,FFFE
DAD SP
PUSH H
XCHG
CALL ArbNum$init
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push constant 33
LXI B,0021
PUSH B
// call 'String$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 51
LXI B,0033
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 46
LXI B,002E
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 49
LXI B,0031
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 52
LXI B,0034
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 49
LXI B,0031
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 53
LXI B,0035
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 57
LXI B,0039
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 50
LXI B,0032
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 54
LXI B,0036
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 53
LXI B,0035
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 51
LXI B,0033
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 53
LXI B,0035
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 56
LXI B,0038
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 57
LXI B,0039
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 55
LXI B,0037
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 57
LXI B,0039
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 51
LXI B,0033
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 50
LXI B,0032
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 51
LXI B,0033
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 56
LXI B,0038
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 52
LXI B,0034
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 54
LXI B,0036
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 50
LXI B,0032
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 54
LXI B,0036
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 52
LXI B,0034
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 51
LXI B,0033
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 51
LXI B,0033
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 56
LXI B,0038
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 51
LXI B,0033
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 50
LXI B,0032
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 55
LXI B,0037
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 57
LXI B,0039
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 53
LXI B,0035
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// call 'ArbNum$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 0
// Translated: Math$0
POP H
SHLD Math$0
// push constant 17
LXI B,0011
PUSH B
// call 'String$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 50
LXI B,0032
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 46
LXI B,002E
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 55
LXI B,0037
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 49
LXI B,0031
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 56
LXI B,0038
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 50
LXI B,0032
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 56
LXI B,0038
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 49
LXI B,0031
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 56
LXI B,0038
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 50
LXI B,0032
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 56
LXI B,0038
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 52
LXI B,0034
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 53
LXI B,0035
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 57
LXI B,0039
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 52
LXI B,0034
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 53
LXI B,0035
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// call 'ArbNum$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 1
// Translated: Math$1
POP H
SHLD Math$1
// push constant 14
LXI B,000E
PUSH B
// call 'String$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 46
LXI B,002E
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 49
LXI B,0031
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// call 'ArbNum$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 6
// Translated: Math$6
POP H
SHLD Math$6
// push constant 3
LXI B,0003
PUSH B
// call 'String$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 46
LXI B,002E
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// call 'ArbNum$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 2
// Translated: Math$2
POP H
SHLD Math$2
// push constant 3
LXI B,0003
PUSH B
// call 'String$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 49
LXI B,0031
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 46
LXI B,002E
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// call 'ArbNum$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 3
// Translated: Math$3
POP H
SHLD Math$3
// push constant 3
LXI B,0003
PUSH B
// call 'String$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 50
LXI B,0032
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 46
LXI B,002E
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// call 'ArbNum$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 4
// Translated: Math$4
POP H
SHLD Math$4
// push constant 3
LXI B,0003
PUSH B
// call 'String$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL String$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 51
LXI B,0033
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 46
LXI B,002E
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 48
LXI B,0030
PUSH B
// call 'String$appendChar':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL String$appendChar
POP H
SPHL
MOV M,D
INX H
MOV M,E
// call 'ArbNum$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 5
// Translated: Math$5
POP H
SHLD Math$5
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Math$getpi':0
// Translated: Math$getpi
Math$getpi:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push static 0
// Translated: Math$0
LHLD Math$0
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Math$gete':0
// Translated: Math$gete
Math$gete:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push static 1
// Translated: Math$1
LHLD Math$1
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Math$getdelta':0
// Translated: Math$getdelta
Math$getdelta:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push static 6
// Translated: Math$6
LHLD Math$6
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Math$add':4
// Translated: Math$add
Math$add:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
PUSH H
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push constant 0
LXI B,0000
PUSH B
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// and
POP B
POP H
MOV A,L
ANA C
MOV L,A
MOV A,H
ANA B
MOV H,A
PUSH H
// if-goto 'IF_TRUE0'
// Translated: Math$add$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ Math$add$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: Math$add$IF_FALSE0
JMP Math$add$IF_FALSE0
// label 'IF_TRUE0'
// Translated: Math$add$IF_TRUE0
Math$add$IF_TRUE0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE0'
// Translated: Math$add$IF_FALSE0
Math$add$IF_FALSE0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// and
POP B
POP H
MOV A,L
ANA C
MOV L,A
MOV A,H
ANA B
MOV H,A
PUSH H
// if-goto 'IF_TRUE1'
// Translated: Math$add$IF_TRUE1
POP H
MOV A,H
ORA L
JNZ Math$add$IF_TRUE1
// goto 'IF_FALSE1'
// Translated: Math$add$IF_FALSE1
JMP Math$add$IF_FALSE1
// label 'IF_TRUE1'
// Translated: Math$add$IF_TRUE1
Math$add$IF_TRUE1:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$sub':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$sub
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE1'
// Translated: Math$add$IF_FALSE1
Math$add$IF_FALSE1:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// and
POP B
POP H
MOV A,L
ANA C
MOV L,A
MOV A,H
ANA B
MOV H,A
PUSH H
// if-goto 'IF_TRUE2'
// Translated: Math$add$IF_TRUE2
POP H
MOV A,H
ORA L
JNZ Math$add$IF_TRUE2
// goto 'IF_FALSE2'
// Translated: Math$add$IF_FALSE2
JMP Math$add$IF_FALSE2
// label 'IF_TRUE2'
// Translated: Math$add$IF_TRUE2
Math$add$IF_TRUE2:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$sub':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$sub
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE2'
// Translated: Math$add$IF_FALSE2
Math$add$IF_FALSE2:
// label 'WHILE_EXP0'
// Translated: Math$add$WHILE_EXP0
Math$add$WHILE_EXP0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: Math$add$WHILE_END0
POP H
MOV A,H
ORA L
JNZ Math$add$WHILE_END0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$shiftRight':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$shiftRight
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// goto 'WHILE_EXP0'
// Translated: Math$add$WHILE_EXP0
JMP Math$add$WHILE_EXP0
// label 'WHILE_END0'
// Translated: Math$add$WHILE_END0
Math$add$WHILE_END0:
// label 'WHILE_EXP1'
// Translated: Math$add$WHILE_EXP1
Math$add$WHILE_EXP1:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END1'
// Translated: Math$add$WHILE_END1
POP H
MOV A,H
ORA L
JNZ Math$add$WHILE_END1
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$shiftRight':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$shiftRight
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// goto 'WHILE_EXP1'
// Translated: Math$add$WHILE_EXP1
JMP Math$add$WHILE_EXP1
// label 'WHILE_END1'
// Translated: Math$add$WHILE_END1
Math$add$WHILE_END1:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$arrayAdd':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$arrayAdd
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// if-goto 'IF_TRUE3'
// Translated: Math$add$IF_TRUE3
POP H
MOV A,H
ORA L
JNZ Math$add$IF_TRUE3
// goto 'IF_FALSE3'
// Translated: Math$add$IF_FALSE3
JMP Math$add$IF_FALSE3
// label 'IF_TRUE3'
// Translated: Math$add$IF_TRUE3
Math$add$IF_TRUE3:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE3'
// Translated: Math$add$IF_FALSE3
Math$add$IF_FALSE3:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Math$sub':4
// Translated: Math$sub
Math$sub:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
PUSH H
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push constant 0
LXI B,0000
PUSH B
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// and
POP B
POP H
MOV A,L
ANA C
MOV L,A
MOV A,H
ANA B
MOV H,A
PUSH H
// if-goto 'IF_TRUE0'
// Translated: Math$sub$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ Math$sub$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: Math$sub$IF_FALSE0
JMP Math$sub$IF_FALSE0
// label 'IF_TRUE0'
// Translated: Math$sub$IF_TRUE0
Math$sub$IF_TRUE0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$sub':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$sub
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE0'
// Translated: Math$sub$IF_FALSE0
Math$sub$IF_FALSE0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE1'
// Translated: Math$sub$IF_TRUE1
POP H
MOV A,H
ORA L
JNZ Math$sub$IF_TRUE1
// goto 'IF_FALSE1'
// Translated: Math$sub$IF_FALSE1
JMP Math$sub$IF_FALSE1
// label 'IF_TRUE1'
// Translated: Math$sub$IF_TRUE1
Math$sub$IF_TRUE1:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE1'
// Translated: Math$sub$IF_FALSE1
Math$sub$IF_FALSE1:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE2'
// Translated: Math$sub$IF_TRUE2
POP H
MOV A,H
ORA L
JNZ Math$sub$IF_TRUE2
// goto 'IF_FALSE2'
// Translated: Math$sub$IF_FALSE2
JMP Math$sub$IF_FALSE2
// label 'IF_TRUE2'
// Translated: Math$sub$IF_TRUE2
Math$sub$IF_TRUE2:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE2'
// Translated: Math$sub$IF_FALSE2
Math$sub$IF_FALSE2:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$isGreater':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isGreater
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE3'
// Translated: Math$sub$IF_TRUE3
POP H
MOV A,H
ORA L
JNZ Math$sub$IF_TRUE3
// goto 'IF_FALSE3'
// Translated: Math$sub$IF_FALSE3
JMP Math$sub$IF_FALSE3
// label 'IF_TRUE3'
// Translated: Math$sub$IF_TRUE3
Math$sub$IF_TRUE3:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$sub':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$sub
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE3'
// Translated: Math$sub$IF_FALSE3
Math$sub$IF_FALSE3:
// label 'WHILE_EXP0'
// Translated: Math$sub$WHILE_EXP0
Math$sub$WHILE_EXP0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: Math$sub$WHILE_END0
POP H
MOV A,H
ORA L
JNZ Math$sub$WHILE_END0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$shiftRight':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$shiftRight
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// goto 'WHILE_EXP0'
// Translated: Math$sub$WHILE_EXP0
JMP Math$sub$WHILE_EXP0
// label 'WHILE_END0'
// Translated: Math$sub$WHILE_END0
Math$sub$WHILE_END0:
// label 'WHILE_EXP1'
// Translated: Math$sub$WHILE_EXP1
Math$sub$WHILE_EXP1:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END1'
// Translated: Math$sub$WHILE_END1
POP H
MOV A,H
ORA L
JNZ Math$sub$WHILE_END1
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$shiftRight':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$shiftRight
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// goto 'WHILE_EXP1'
// Translated: Math$sub$WHILE_EXP1
JMP Math$sub$WHILE_EXP1
// label 'WHILE_END1'
// Translated: Math$sub$WHILE_END1
Math$sub$WHILE_END1:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$arraySub':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$arraySub
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// if-goto 'IF_TRUE4'
// Translated: Math$sub$IF_TRUE4
POP H
MOV A,H
ORA L
JNZ Math$sub$IF_TRUE4
// goto 'IF_FALSE4'
// Translated: Math$sub$IF_FALSE4
JMP Math$sub$IF_FALSE4
// label 'IF_TRUE4'
// Translated: Math$sub$IF_TRUE4
Math$sub$IF_TRUE4:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE4'
// Translated: Math$sub$IF_FALSE4
Math$sub$IF_FALSE4:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Math$mul':6
// Translated: Math$mul
Math$mul:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
PUSH H
PUSH H
PUSH H
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// or
POP B
POP H
MOV A,L
ORA C
MOV L,A
MOV A,H
ORA B
MOV H,A
PUSH H
// if-goto 'IF_TRUE0'
// Translated: Math$mul$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ Math$mul$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: Math$mul$IF_FALSE0
JMP Math$mul$IF_FALSE0
// label 'IF_TRUE0'
// Translated: Math$mul$IF_TRUE0
Math$mul$IF_TRUE0:
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE0'
// Translated: Math$mul$IF_FALSE0
Math$mul$IF_FALSE0:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getDigits':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getDigits
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 5
LXI B,FFF6
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// call 'ArbNum$getPrecision':0
LXI H,FFFE
DAD SP
PUSH H
XCHG
CALL ArbNum$getPrecision
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 4
LXI B,FFF8
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// add
POP B
POP H
DAD B
PUSH H
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// call 'ArbNum$setOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'WHILE_EXP0'
// Translated: Math$mul$WHILE_EXP0
Math$mul$WHILE_EXP0:
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: Math$mul$WHILE_END0
POP H
MOV A,H
ORA L
JNZ Math$mul$WHILE_END0
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop local 4
LXI B,FFF8
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP1'
// Translated: Math$mul$WHILE_EXP1
Math$mul$WHILE_EXP1:
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END1'
// Translated: Math$mul$WHILE_END1
POP H
MOV A,H
ORA L
JNZ Math$mul$WHILE_END1
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP1'
// Translated: Math$mul$WHILE_EXP1
JMP Math$mul$WHILE_EXP1
// label 'WHILE_END1'
// Translated: Math$mul$WHILE_END1
Math$mul$WHILE_END1:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$div10':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$div10
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// goto 'WHILE_EXP0'
// Translated: Math$mul$WHILE_EXP0
JMP Math$mul$WHILE_EXP0
// label 'WHILE_END0'
// Translated: Math$mul$WHILE_END0
Math$mul$WHILE_END0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Math$div':9
// Translated: Math$div
Math$div:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
PUSH H
PUSH H
PUSH H
PUSH H
PUSH H
PUSH H
PUSH H
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE0'
// Translated: Math$div$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ Math$div$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: Math$div$IF_FALSE0
JMP Math$div$IF_FALSE0
// label 'IF_TRUE0'
// Translated: Math$div$IF_TRUE0
Math$div$IF_TRUE0:
// push constant 3
LXI B,0003
PUSH B
// call 'Sys$error':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Sys$error
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE0'
// Translated: Math$div$IF_FALSE0
Math$div$IF_FALSE0:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE1'
// Translated: Math$div$IF_TRUE1
POP H
MOV A,H
ORA L
JNZ Math$div$IF_TRUE1
// goto 'IF_FALSE1'
// Translated: Math$div$IF_FALSE1
JMP Math$div$IF_FALSE1
// label 'IF_TRUE1'
// Translated: Math$div$IF_TRUE1
Math$div$IF_TRUE1:
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE1'
// Translated: Math$div$IF_FALSE1
Math$div$IF_FALSE1:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getDigits':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getDigits
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 8
LXI B,FFF0
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// call 'ArbNum$getPrecision':0
LXI H,FFFE
DAD SP
PUSH H
XCHG
CALL ArbNum$getPrecision
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// or
POP B
POP H
MOV A,L
ORA C
MOV L,A
MOV A,H
ORA B
MOV H,A
PUSH H
// if-goto 'IF_TRUE2'
// Translated: Math$div$IF_TRUE2
POP H
MOV A,H
ORA L
JNZ Math$div$IF_TRUE2
// goto 'IF_FALSE2'
// Translated: Math$div$IF_FALSE2
JMP Math$div$IF_FALSE2
// label 'IF_TRUE2'
// Translated: Math$div$IF_TRUE2
Math$div$IF_TRUE2:
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// call 'ArbNum$setOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// call 'ArbNum$setOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE2'
// Translated: Math$div$IF_FALSE2
Math$div$IF_FALSE2:
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP0'
// Translated: Math$div$WHILE_EXP0
Math$div$WHILE_EXP0:
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// and
POP B
POP H
MOV A,L
ANA C
MOV L,A
MOV A,H
ANA B
MOV H,A
PUSH H
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: Math$div$WHILE_END0
POP H
MOV A,H
ORA L
JNZ Math$div$WHILE_END0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// call 'ArbNum$setOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// call 'ArbNum$setOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// goto 'WHILE_EXP0'
// Translated: Math$div$WHILE_EXP0
JMP Math$div$WHILE_EXP0
// label 'WHILE_END0'
// Translated: Math$div$WHILE_END0
Math$div$WHILE_END0:
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getDigits':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getDigits
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 7
LXI B,FFF2
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP1'
// Translated: Math$div$WHILE_EXP1
Math$div$WHILE_EXP1:
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 7
LXI B,FFF2
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END1'
// Translated: Math$div$WHILE_END1
POP H
MOV A,H
ORA L
JNZ Math$div$WHILE_END1
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$mul10':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$mul10
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// call 'ArbNum$setOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// goto 'WHILE_EXP1'
// Translated: Math$div$WHILE_EXP1
JMP Math$div$WHILE_EXP1
// label 'WHILE_END1'
// Translated: Math$div$WHILE_END1
Math$div$WHILE_END1:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// call 'ArbNum$setOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$setOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getDigits':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getDigits
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 7
LXI B,FFF2
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getDigits':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getDigits
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 8
LXI B,FFF0
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop local 4
LXI B,FFF8
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP2'
// Translated: Math$div$WHILE_EXP2
Math$div$WHILE_EXP2:
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END2'
// Translated: Math$div$WHILE_END2
POP H
MOV A,H
ORA L
JNZ Math$div$WHILE_END2
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop local 4
LXI B,FFF8
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP3'
// Translated: Math$div$WHILE_EXP3
Math$div$WHILE_EXP3:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$isGreater':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isGreater
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// or
POP B
POP H
MOV A,L
ORA C
MOV L,A
MOV A,H
ORA B
MOV H,A
PUSH H
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END3'
// Translated: Math$div$WHILE_END3
POP H
MOV A,H
ORA L
JNZ Math$div$WHILE_END3
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$sub':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$sub
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getDigits':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getDigits
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 7
LXI B,FFF2
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 8
LXI B,FFF0
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 8
LXI B,FFF0
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP3'
// Translated: Math$div$WHILE_EXP3
JMP Math$div$WHILE_EXP3
// label 'WHILE_END3'
// Translated: Math$div$WHILE_END3
Math$div$WHILE_END3:
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 7
LXI B,FFF2
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE3'
// Translated: Math$div$IF_TRUE3
POP H
MOV A,H
ORA L
JNZ Math$div$IF_TRUE3
// goto 'IF_FALSE3'
// Translated: Math$div$IF_FALSE3
JMP Math$div$IF_FALSE3
// label 'IF_TRUE3'
// Translated: Math$div$IF_TRUE3
Math$div$IF_TRUE3:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$shiftLeft':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$shiftLeft
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE3'
// Translated: Math$div$IF_FALSE3
Math$div$IF_FALSE3:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// call 'ArbNum$setOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 8
LXI B,FFF0
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// and
POP B
POP H
MOV A,L
ANA C
MOV L,A
MOV A,H
ANA B
MOV H,A
PUSH H
// if-goto 'IF_TRUE4'
// Translated: Math$div$IF_TRUE4
POP H
MOV A,H
ORA L
JNZ Math$div$IF_TRUE4
// goto 'IF_FALSE4'
// Translated: Math$div$IF_FALSE4
JMP Math$div$IF_FALSE4
// label 'IF_TRUE4'
// Translated: Math$div$IF_TRUE4
Math$div$IF_TRUE4:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// call 'ArbNum$setOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop local 4
LXI B,FFF8
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'IF_FALSE4'
// Translated: Math$div$IF_FALSE4
Math$div$IF_FALSE4:
// goto 'WHILE_EXP2'
// Translated: Math$div$WHILE_EXP2
JMP Math$div$WHILE_EXP2
// label 'WHILE_END2'
// Translated: Math$div$WHILE_END2
Math$div$WHILE_END2:
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP4'
// Translated: Math$div$WHILE_EXP4
Math$div$WHILE_EXP4:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END4'
// Translated: Math$div$WHILE_END4
POP H
MOV A,H
ORA L
JNZ Math$div$WHILE_END4
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$shiftRight':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$shiftRight
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// goto 'WHILE_EXP4'
// Translated: Math$div$WHILE_EXP4
JMP Math$div$WHILE_EXP4
// label 'WHILE_END4'
// Translated: Math$div$WHILE_END4
Math$div$WHILE_END4:
// label 'WHILE_EXP5'
// Translated: Math$div$WHILE_EXP5
Math$div$WHILE_EXP5:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getOffset':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// push local 8
LXI B,FFF0
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// and
POP B
POP H
MOV A,L
ANA C
MOV L,A
MOV A,H
ANA B
MOV H,A
PUSH H
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END5'
// Translated: Math$div$WHILE_END5
POP H
MOV A,H
ORA L
JNZ Math$div$WHILE_END5
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$shiftLeft':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$shiftLeft
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// goto 'WHILE_EXP5'
// Translated: Math$div$WHILE_EXP5
JMP Math$div$WHILE_EXP5
// label 'WHILE_END5'
// Translated: Math$div$WHILE_END5
Math$div$WHILE_END5:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Math$exp':5
// Translated: Math$exp
Math$exp:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
PUSH H
PUSH H
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE0'
// Translated: Math$exp$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ Math$exp$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: Math$exp$IF_FALSE0
JMP Math$exp$IF_FALSE0
// label 'IF_TRUE0'
// Translated: Math$exp$IF_TRUE0
Math$exp$IF_TRUE0:
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE0'
// Translated: Math$exp$IF_FALSE0
Math$exp$IF_FALSE0:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE1'
// Translated: Math$exp$IF_TRUE1
POP H
MOV A,H
ORA L
JNZ Math$exp$IF_TRUE1
// goto 'IF_FALSE1'
// Translated: Math$exp$IF_FALSE1
JMP Math$exp$IF_FALSE1
// label 'IF_TRUE1'
// Translated: Math$exp$IF_TRUE1
Math$exp$IF_TRUE1:
// push static 1
// Translated: Math$1
LHLD Math$1
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE1'
// Translated: Math$exp$IF_FALSE1
Math$exp$IF_FALSE1:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP0'
// Translated: Math$exp$WHILE_EXP0
Math$exp$WHILE_EXP0:
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 6
// Translated: Math$6
LHLD Math$6
PUSH H
// call 'ArbNum$isGreater':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isGreater
POP H
SPHL
MOV M,D
INX H
MOV M,E
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: Math$exp$WHILE_END0
POP H
MOV A,H
ORA L
JNZ Math$exp$WHILE_END0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$div':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$div
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 4
LXI B,FFF8
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$mul':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$mul
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP0'
// Translated: Math$exp$WHILE_EXP0
JMP Math$exp$WHILE_EXP0
// label 'WHILE_END0'
// Translated: Math$exp$WHILE_END0
Math$exp$WHILE_END0:
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Math$ln':8
// Translated: Math$ln
Math$ln:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
PUSH H
PUSH H
PUSH H
PUSH H
PUSH H
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// or
POP B
POP H
MOV A,L
ORA C
MOV L,A
MOV A,H
ORA B
MOV H,A
PUSH H
// if-goto 'IF_TRUE0'
// Translated: Math$ln$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ Math$ln$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: Math$ln$IF_FALSE0
JMP Math$ln$IF_FALSE0
// label 'IF_TRUE0'
// Translated: Math$ln$IF_TRUE0
Math$ln$IF_TRUE0:
// push constant 22
LXI B,0016
PUSH B
// call 'Sys$error':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Sys$error
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE0'
// Translated: Math$ln$IF_FALSE0
Math$ln$IF_FALSE0:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE1'
// Translated: Math$ln$IF_TRUE1
POP H
MOV A,H
ORA L
JNZ Math$ln$IF_TRUE1
// goto 'IF_FALSE1'
// Translated: Math$ln$IF_FALSE1
JMP Math$ln$IF_FALSE1
// label 'IF_TRUE1'
// Translated: Math$ln$IF_TRUE1
Math$ln$IF_TRUE1:
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE1'
// Translated: Math$ln$IF_FALSE1
Math$ln$IF_FALSE1:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 1
// Translated: Math$1
LHLD Math$1
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE2'
// Translated: Math$ln$IF_TRUE2
POP H
MOV A,H
ORA L
JNZ Math$ln$IF_TRUE2
// goto 'IF_FALSE2'
// Translated: Math$ln$IF_FALSE2
JMP Math$ln$IF_FALSE2
// label 'IF_TRUE2'
// Translated: Math$ln$IF_TRUE2
Math$ln$IF_TRUE2:
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE2'
// Translated: Math$ln$IF_FALSE2
Math$ln$IF_FALSE2:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 7
LXI B,FFF2
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP0'
// Translated: Math$ln$WHILE_EXP0
Math$ln$WHILE_EXP0:
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 1
// Translated: Math$1
LHLD Math$1
PUSH H
// call 'ArbNum$isGreater':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isGreater
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 1
// Translated: Math$1
LHLD Math$1
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// or
POP B
POP H
MOV A,L
ORA C
MOV L,A
MOV A,H
ORA B
MOV H,A
PUSH H
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: Math$ln$WHILE_END0
POP H
MOV A,H
ORA L
JNZ Math$ln$WHILE_END0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 1
// Translated: Math$1
LHLD Math$1
PUSH H
// call 'Math$div':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$div
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 4
LXI B,FFF8
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 7
LXI B,FFF2
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 4
LXI B,FFF8
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 7
LXI B,FFF2
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 7
LXI B,FFF2
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP0'
// Translated: Math$ln$WHILE_EXP0
JMP Math$ln$WHILE_EXP0
// label 'WHILE_END0'
// Translated: Math$ln$WHILE_END0
Math$ln$WHILE_END0:
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'Math$sub':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$sub
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 4
LXI B,FFF8
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$div':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$div
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$mul':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$mul
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 5
LXI B,FFF6
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP1'
// Translated: Math$ln$WHILE_EXP1
Math$ln$WHILE_EXP1:
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 6
// Translated: Math$6
LHLD Math$6
PUSH H
// call 'ArbNum$isGreater':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isGreater
POP H
SPHL
MOV M,D
INX H
MOV M,E
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END1'
// Translated: Math$ln$WHILE_END1
POP H
MOV A,H
ORA L
JNZ Math$ln$WHILE_END1
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 4
// Translated: Math$4
LHLD Math$4
PUSH H
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 4
LXI B,FFF8
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 5
LXI B,FFF6
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$mul':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$mul
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 4
LXI B,FFF8
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$div':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$div
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 4
LXI B,FFF8
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP1'
// Translated: Math$ln$WHILE_EXP1
JMP Math$ln$WHILE_EXP1
// label 'WHILE_END1'
// Translated: Math$ln$WHILE_END1
Math$ln$WHILE_END1:
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 4
// Translated: Math$4
LHLD Math$4
PUSH H
// call 'Math$mul':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$mul
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 7
LXI B,FFF2
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 4
LXI B,FFF8
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 7
LXI B,FFF2
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Math$pow':4
// Translated: Math$pow
Math$pow:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
PUSH H
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE0'
// Translated: Math$pow$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ Math$pow$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: Math$pow$IF_FALSE0
JMP Math$pow$IF_FALSE0
// label 'IF_TRUE0'
// Translated: Math$pow$IF_TRUE0
Math$pow$IF_TRUE0:
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE0'
// Translated: Math$pow$IF_FALSE0
Math$pow$IF_FALSE0:
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE1'
// Translated: Math$pow$IF_TRUE1
POP H
MOV A,H
ORA L
JNZ Math$pow$IF_TRUE1
// goto 'IF_FALSE1'
// Translated: Math$pow$IF_FALSE1
JMP Math$pow$IF_FALSE1
// label 'IF_TRUE1'
// Translated: Math$pow$IF_TRUE1
Math$pow$IF_TRUE1:
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE1'
// Translated: Math$pow$IF_FALSE1
Math$pow$IF_FALSE1:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE2'
// Translated: Math$pow$IF_TRUE2
POP H
MOV A,H
ORA L
JNZ Math$pow$IF_TRUE2
// goto 'IF_FALSE2'
// Translated: Math$pow$IF_FALSE2
JMP Math$pow$IF_FALSE2
// label 'IF_TRUE2'
// Translated: Math$pow$IF_TRUE2
Math$pow$IF_TRUE2:
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE2'
// Translated: Math$pow$IF_FALSE2
Math$pow$IF_FALSE2:
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE3'
// Translated: Math$pow$IF_TRUE3
POP H
MOV A,H
ORA L
JNZ Math$pow$IF_TRUE3
// goto 'IF_FALSE3'
// Translated: Math$pow$IF_FALSE3
JMP Math$pow$IF_FALSE3
// label 'IF_TRUE3'
// Translated: Math$pow$IF_TRUE3
Math$pow$IF_TRUE3:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE3'
// Translated: Math$pow$IF_FALSE3
Math$pow$IF_FALSE3:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE4'
// Translated: Math$pow$IF_TRUE4
POP H
MOV A,H
ORA L
JNZ Math$pow$IF_TRUE4
// goto 'IF_FALSE4'
// Translated: Math$pow$IF_FALSE4
JMP Math$pow$IF_FALSE4
// label 'IF_TRUE4'
// Translated: Math$pow$IF_TRUE4
Math$pow$IF_TRUE4:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$isWholeNum':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$isWholeNum
POP H
SPHL
MOV M,D
INX H
MOV M,E
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'IF_TRUE5'
// Translated: Math$pow$IF_TRUE5
POP H
MOV A,H
ORA L
JNZ Math$pow$IF_TRUE5
// goto 'IF_FALSE5'
// Translated: Math$pow$IF_FALSE5
JMP Math$pow$IF_FALSE5
// label 'IF_TRUE5'
// Translated: Math$pow$IF_TRUE5
Math$pow$IF_TRUE5:
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE5'
// Translated: Math$pow$IF_FALSE5
Math$pow$IF_FALSE5:
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$isEven':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$isEven
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE6'
// Translated: Math$pow$IF_TRUE6
POP H
MOV A,H
ORA L
JNZ Math$pow$IF_TRUE6
// goto 'IF_FALSE6'
// Translated: Math$pow$IF_FALSE6
JMP Math$pow$IF_FALSE6
// label 'IF_TRUE6'
// Translated: Math$pow$IF_TRUE6
Math$pow$IF_TRUE6:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$pow':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$pow
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE6'
// Translated: Math$pow$IF_FALSE6
Math$pow$IF_FALSE6:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$pow':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$pow
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE4'
// Translated: Math$pow$IF_FALSE4
Math$pow$IF_FALSE4:
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE7'
// Translated: Math$pow$IF_TRUE7
POP H
MOV A,H
ORA L
JNZ Math$pow$IF_TRUE7
// goto 'IF_FALSE7'
// Translated: Math$pow$IF_FALSE7
JMP Math$pow$IF_FALSE7
// label 'IF_TRUE7'
// Translated: Math$pow$IF_TRUE7
Math$pow$IF_TRUE7:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$pow':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$pow
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$div':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$div
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE7'
// Translated: Math$pow$IF_FALSE7
Math$pow$IF_FALSE7:
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP0'
// Translated: Math$pow$WHILE_EXP0
Math$pow$WHILE_EXP0:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$isGreater':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isGreater
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// or
POP B
POP H
MOV A,L
ORA C
MOV L,A
MOV A,H
ORA B
MOV H,A
PUSH H
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: Math$pow$WHILE_END0
POP H
MOV A,H
ORA L
JNZ Math$pow$WHILE_END0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$mul':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$mul
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'Math$sub':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$sub
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP0'
// Translated: Math$pow$WHILE_EXP0
JMP Math$pow$WHILE_EXP0
// label 'WHILE_END0'
// Translated: Math$pow$WHILE_END0
Math$pow$WHILE_END0:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$ln':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Math$ln
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$mul':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$mul
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$exp':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Math$exp
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$mul':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$mul
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Math$root':2
// Translated: Math$root
Math$root:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// and
POP B
POP H
MOV A,L
ANA C
MOV L,A
MOV A,H
ANA B
MOV H,A
PUSH H
// if-goto 'IF_TRUE0'
// Translated: Math$root$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ Math$root$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: Math$root$IF_FALSE0
JMP Math$root$IF_FALSE0
// label 'IF_TRUE0'
// Translated: Math$root$IF_TRUE0
Math$root$IF_TRUE0:
// push constant 4
LXI B,0004
PUSH B
// call 'Sys$error':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Sys$error
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE0'
// Translated: Math$root$IF_FALSE0
Math$root$IF_FALSE0:
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$div':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$div
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$pow':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$pow
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Math$cos':7
// Translated: Math$cos
Math$cos:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
PUSH H
PUSH H
PUSH H
PUSH H
PUSH H
// push static 0
// Translated: Math$0
LHLD Math$0
PUSH H
// push static 4
// Translated: Math$4
LHLD Math$4
PUSH H
// call 'Math$mul':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$mul
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP0'
// Translated: Math$cos$WHILE_EXP0
Math$cos$WHILE_EXP0:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$isGreater':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isGreater
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// or
POP B
POP H
MOV A,L
ORA C
MOV L,A
MOV A,H
ORA B
MOV H,A
PUSH H
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: Math$cos$WHILE_END0
POP H
MOV A,H
ORA L
JNZ Math$cos$WHILE_END0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$sub':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$sub
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP0'
// Translated: Math$cos$WHILE_EXP0
JMP Math$cos$WHILE_EXP0
// label 'WHILE_END0'
// Translated: Math$cos$WHILE_END0
Math$cos$WHILE_END0:
// push static 0
// Translated: Math$0
LHLD Math$0
PUSH H
// push static 4
// Translated: Math$4
LHLD Math$4
PUSH H
// call 'Math$div':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$div
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$div':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$div
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 5
// Translated: Math$5
LHLD Math$5
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// or
POP B
POP H
MOV A,L
ORA C
MOV L,A
MOV A,H
ORA B
MOV H,A
PUSH H
// if-goto 'IF_TRUE0'
// Translated: Math$cos$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ Math$cos$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: Math$cos$IF_FALSE0
JMP Math$cos$IF_FALSE0
// label 'IF_TRUE0'
// Translated: Math$cos$IF_TRUE0
Math$cos$IF_TRUE0:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE0'
// Translated: Math$cos$IF_FALSE0
Math$cos$IF_FALSE0:
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 4
// Translated: Math$4
LHLD Math$4
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE1'
// Translated: Math$cos$IF_TRUE1
POP H
MOV A,H
ORA L
JNZ Math$cos$IF_TRUE1
// goto 'IF_FALSE1'
// Translated: Math$cos$IF_FALSE1
JMP Math$cos$IF_FALSE1
// label 'IF_TRUE1'
// Translated: Math$cos$IF_TRUE1
Math$cos$IF_TRUE1:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'Math$sub':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$sub
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE1'
// Translated: Math$cos$IF_FALSE1
Math$cos$IF_FALSE1:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE2'
// Translated: Math$cos$IF_TRUE2
POP H
MOV A,H
ORA L
JNZ Math$cos$IF_TRUE2
// goto 'IF_FALSE2'
// Translated: Math$cos$IF_FALSE2
JMP Math$cos$IF_FALSE2
// label 'IF_TRUE2'
// Translated: Math$cos$IF_TRUE2
Math$cos$IF_TRUE2:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE2'
// Translated: Math$cos$IF_FALSE2
Math$cos$IF_FALSE2:
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$mul':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$mul
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 4
LXI B,FFF8
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 5
LXI B,FFF6
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP1'
// Translated: Math$cos$WHILE_EXP1
Math$cos$WHILE_EXP1:
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 6
// Translated: Math$6
LHLD Math$6
PUSH H
// call 'ArbNum$isGreater':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isGreater
POP H
SPHL
MOV M,D
INX H
MOV M,E
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 6
// Translated: Math$6
LHLD Math$6
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// or
POP B
POP H
MOV A,L
ORA C
MOV L,A
MOV A,H
ORA B
MOV H,A
PUSH H
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END1'
// Translated: Math$cos$WHILE_END1
POP H
MOV A,H
ORA L
JNZ Math$cos$WHILE_END1
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$div':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$div
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$div':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$div
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$mul':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$mul
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 4
LXI B,FFF8
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 5
LXI B,FFF6
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP1'
// Translated: Math$cos$WHILE_EXP1
JMP Math$cos$WHILE_EXP1
// label 'WHILE_END1'
// Translated: Math$cos$WHILE_END1
Math$cos$WHILE_END1:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$div':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$div
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$div':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$div
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$mul':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$mul
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 4
LXI B,FFF8
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$add':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$add
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 6
LXI B,FFF4
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 5
LXI B,FFF6
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Math$sin':2
// Translated: Math$sin
Math$sin:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE0'
// Translated: Math$sin$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ Math$sin$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: Math$sin$IF_FALSE0
JMP Math$sin$IF_FALSE0
// label 'IF_TRUE0'
// Translated: Math$sin$IF_TRUE0
Math$sin$IF_TRUE0:
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$copy':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$copy
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE0'
// Translated: Math$sin$IF_FALSE0
Math$sin$IF_FALSE0:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 0
// Translated: Math$0
LHLD Math$0
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE1'
// Translated: Math$sin$IF_TRUE1
POP H
MOV A,H
ORA L
JNZ Math$sin$IF_TRUE1
// goto 'IF_FALSE1'
// Translated: Math$sin$IF_FALSE1
JMP Math$sin$IF_FALSE1
// label 'IF_TRUE1'
// Translated: Math$sin$IF_TRUE1
Math$sin$IF_TRUE1:
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// call 'Math$sub':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$sub
POP H
SPHL
MOV M,D
INX H
MOV M,E
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// label 'IF_FALSE1'
// Translated: Math$sin$IF_FALSE1
Math$sin$IF_FALSE1:
// push static 0
// Translated: Math$0
LHLD Math$0
PUSH H
// push static 4
// Translated: Math$4
LHLD Math$4
PUSH H
// call 'Math$div':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$div
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$sub':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$sub
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$cos':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Math$cos
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$getSign':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$getSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE2'
// Translated: Math$sin$IF_TRUE2
POP H
MOV A,H
ORA L
JNZ Math$sin$IF_TRUE2
// goto 'IF_FALSE2'
// Translated: Math$sin$IF_FALSE2
JMP Math$sin$IF_FALSE2
// label 'IF_TRUE2'
// Translated: Math$sin$IF_TRUE2
Math$sin$IF_TRUE2:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// call 'ArbNum$setSign':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$setSign
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE2'
// Translated: Math$sin$IF_FALSE2
Math$sin$IF_FALSE2:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Math$tan':3
// Translated: Math$tan
Math$tan:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$cos':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Math$cos
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 2
// Translated: Math$2
LHLD Math$2
PUSH H
// call 'ArbNum$isEqual':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$isEqual
POP H
SPHL
MOV M,D
INX H
MOV M,E
// if-goto 'IF_TRUE0'
// Translated: Math$tan$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ Math$tan$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: Math$tan$IF_FALSE0
JMP Math$tan$IF_FALSE0
// label 'IF_TRUE0'
// Translated: Math$tan$IF_TRUE0
Math$tan$IF_TRUE0:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push constant 3
LXI B,0003
PUSH B
// call 'Sys$error':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Sys$error
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE0'
// Translated: Math$tan$IF_FALSE0
Math$tan$IF_FALSE0:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$sin':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Math$sin
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$div':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$div
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop local 2
LXI B,FFFC
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'ArbNum$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL ArbNum$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Memory$init':0
// Translated: Memory$init
Memory$init:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push constant 0
LXI B,0000
PUSH B
// pop static 0
// Translated: Memory$0
POP H
SHLD Memory$0
// push constant 2048
LXI B,0800
PUSH B
// push static 0
// Translated: Memory$0
LHLD Memory$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// push constant 14334
LXI B,37FE
PUSH B
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push constant 2049
LXI B,0801
PUSH B
// push static 0
// Translated: Memory$0
LHLD Memory$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// push constant 2050
LXI B,0802
PUSH B
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Memory$alloc':2
// Translated: Memory$alloc
Memory$alloc:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// if-goto 'IF_TRUE0'
// Translated: Memory$alloc$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ Memory$alloc$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: Memory$alloc$IF_FALSE0
JMP Memory$alloc$IF_FALSE0
// label 'IF_TRUE0'
// Translated: Memory$alloc$IF_TRUE0
Memory$alloc$IF_TRUE0:
// push constant 5
LXI B,0005
PUSH B
// call 'Sys$error':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Sys$error
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE0'
// Translated: Memory$alloc$IF_FALSE0
Memory$alloc$IF_FALSE0:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE1'
// Translated: Memory$alloc$IF_TRUE1
POP H
MOV A,H
ORA L
JNZ Memory$alloc$IF_TRUE1
// goto 'IF_FALSE1'
// Translated: Memory$alloc$IF_FALSE1
JMP Memory$alloc$IF_FALSE1
// label 'IF_TRUE1'
// Translated: Memory$alloc$IF_TRUE1
Memory$alloc$IF_TRUE1:
// push constant 1
LXI B,0001
PUSH B
// pop argument 0
LXI B,0000
LHLD ARG
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'IF_FALSE1'
// Translated: Memory$alloc$IF_FALSE1
Memory$alloc$IF_FALSE1:
// push constant 2048
LXI B,0800
PUSH B
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP0'
// Translated: Memory$alloc$WHILE_EXP0
Memory$alloc$WHILE_EXP0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 16383
LXI B,3FFF
PUSH B
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// push constant 0
LXI B,0000
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// and
POP B
POP H
MOV A,L
ANA C
MOV L,A
MOV A,H
ANA B
MOV H,A
PUSH H
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// if-goto 'WHILE_END0'
// Translated: Memory$alloc$WHILE_END0
POP H
MOV A,H
ORA L
JNZ Memory$alloc$WHILE_END0
// push constant 1
LXI B,0001
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push constant 0
LXI B,0000
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 16382
LXI B,3FFE
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// or
POP B
POP H
MOV A,L
ORA C
MOV L,A
MOV A,H
ORA B
MOV H,A
PUSH H
// push constant 0
LXI B,0000
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// or
POP B
POP H
MOV A,L
ORA C
MOV L,A
MOV A,H
ORA B
MOV H,A
PUSH H
// if-goto 'IF_TRUE2'
// Translated: Memory$alloc$IF_TRUE2
POP H
MOV A,H
ORA L
JNZ Memory$alloc$IF_TRUE2
// goto 'IF_FALSE2'
// Translated: Memory$alloc$IF_FALSE2
JMP Memory$alloc$IF_FALSE2
// label 'IF_TRUE2'
// Translated: Memory$alloc$IF_TRUE2
Memory$alloc$IF_TRUE2:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'IF_END2'
// Translated: Memory$alloc$IF_END2
JMP Memory$alloc$IF_END2
// label 'IF_FALSE2'
// Translated: Memory$alloc$IF_FALSE2
Memory$alloc$IF_FALSE2:
// push constant 0
LXI B,0000
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push constant 1
LXI B,0001
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// push constant 0
LXI B,0000
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push constant 1
LXI B,0001
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 2
LXI B,0002
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE3'
// Translated: Memory$alloc$IF_TRUE3
POP H
MOV A,H
ORA L
JNZ Memory$alloc$IF_TRUE3
// goto 'IF_FALSE3'
// Translated: Memory$alloc$IF_FALSE3
JMP Memory$alloc$IF_FALSE3
// label 'IF_TRUE3'
// Translated: Memory$alloc$IF_TRUE3
Memory$alloc$IF_TRUE3:
// push constant 1
LXI B,0001
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 2
LXI B,0002
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// goto 'IF_END3'
// Translated: Memory$alloc$IF_END3
JMP Memory$alloc$IF_END3
// label 'IF_FALSE3'
// Translated: Memory$alloc$IF_FALSE3
Memory$alloc$IF_FALSE3:
// push constant 1
LXI B,0001
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push constant 1
LXI B,0001
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// label 'IF_END3'
// Translated: Memory$alloc$IF_END3
Memory$alloc$IF_END3:
// label 'IF_END2'
// Translated: Memory$alloc$IF_END2
Memory$alloc$IF_END2:
// goto 'WHILE_EXP0'
// Translated: Memory$alloc$WHILE_EXP0
JMP Memory$alloc$WHILE_EXP0
// label 'WHILE_END0'
// Translated: Memory$alloc$WHILE_END0
Memory$alloc$WHILE_END0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push constant 16379
LXI B,3FFB
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// if-goto 'IF_TRUE4'
// Translated: Memory$alloc$IF_TRUE4
POP H
MOV A,H
ORA L
JNZ Memory$alloc$IF_TRUE4
// goto 'IF_FALSE4'
// Translated: Memory$alloc$IF_FALSE4
JMP Memory$alloc$IF_FALSE4
// label 'IF_TRUE4'
// Translated: Memory$alloc$IF_TRUE4
Memory$alloc$IF_TRUE4:
// push constant 6
LXI B,0006
PUSH B
// call 'Sys$error':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Sys$error
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE4'
// Translated: Memory$alloc$IF_FALSE4
Memory$alloc$IF_FALSE4:
// push constant 0
LXI B,0000
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 2
LXI B,0002
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// if-goto 'IF_TRUE5'
// Translated: Memory$alloc$IF_TRUE5
POP H
MOV A,H
ORA L
JNZ Memory$alloc$IF_TRUE5
// goto 'IF_FALSE5'
// Translated: Memory$alloc$IF_FALSE5
JMP Memory$alloc$IF_FALSE5
// label 'IF_TRUE5'
// Translated: Memory$alloc$IF_TRUE5
Memory$alloc$IF_TRUE5:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 2
LXI B,0002
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push constant 0
LXI B,0000
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// push constant 2
LXI B,0002
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push constant 1
LXI B,0001
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 2
LXI B,0002
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE6'
// Translated: Memory$alloc$IF_TRUE6
POP H
MOV A,H
ORA L
JNZ Memory$alloc$IF_TRUE6
// goto 'IF_FALSE6'
// Translated: Memory$alloc$IF_FALSE6
JMP Memory$alloc$IF_FALSE6
// label 'IF_TRUE6'
// Translated: Memory$alloc$IF_TRUE6
Memory$alloc$IF_TRUE6:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 3
LXI B,0003
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push constant 4
LXI B,0004
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// goto 'IF_END6'
// Translated: Memory$alloc$IF_END6
JMP Memory$alloc$IF_END6
// label 'IF_FALSE6'
// Translated: Memory$alloc$IF_FALSE6
Memory$alloc$IF_FALSE6:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 3
LXI B,0003
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push constant 1
LXI B,0001
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// label 'IF_END6'
// Translated: Memory$alloc$IF_END6
Memory$alloc$IF_END6:
// push constant 1
LXI B,0001
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push constant 2
LXI B,0002
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// label 'IF_FALSE5'
// Translated: Memory$alloc$IF_FALSE5
Memory$alloc$IF_FALSE5:
// push constant 0
LXI B,0000
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push constant 0
LXI B,0000
PUSH B
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 2
LXI B,0002
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'Memory$deAlloc':2
// Translated: Memory$deAlloc
Memory$deAlloc:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
LXI H,0000
PUSH H
PUSH H
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 2
LXI B,0002
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push constant 1
LXI B,0001
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push constant 0
LXI B,0000
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE0'
// Translated: Memory$deAlloc$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ Memory$deAlloc$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: Memory$deAlloc$IF_FALSE0
JMP Memory$deAlloc$IF_FALSE0
// label 'IF_TRUE0'
// Translated: Memory$deAlloc$IF_TRUE0
Memory$deAlloc$IF_TRUE0:
// push constant 0
LXI B,0000
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push constant 1
LXI B,0001
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// push constant 2
LXI B,0002
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// goto 'IF_END0'
// Translated: Memory$deAlloc$IF_END0
JMP Memory$deAlloc$IF_END0
// label 'IF_FALSE0'
// Translated: Memory$deAlloc$IF_FALSE0
Memory$deAlloc$IF_FALSE0:
// push constant 0
LXI B,0000
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push constant 1
LXI B,0001
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// push constant 0
LXI B,0000
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push constant 1
LXI B,0001
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 2
LXI B,0002
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE1'
// Translated: Memory$deAlloc$IF_TRUE1
POP H
MOV A,H
ORA L
JNZ Memory$deAlloc$IF_TRUE1
// goto 'IF_FALSE1'
// Translated: Memory$deAlloc$IF_FALSE1
JMP Memory$deAlloc$IF_FALSE1
// label 'IF_TRUE1'
// Translated: Memory$deAlloc$IF_TRUE1
Memory$deAlloc$IF_TRUE1:
// push constant 1
LXI B,0001
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 2
LXI B,0002
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// goto 'IF_END1'
// Translated: Memory$deAlloc$IF_END1
JMP Memory$deAlloc$IF_END1
// label 'IF_FALSE1'
// Translated: Memory$deAlloc$IF_FALSE1
Memory$deAlloc$IF_FALSE1:
// push constant 1
LXI B,0001
PUSH B
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push constant 1
LXI B,0001
PUSH B
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// label 'IF_END1'
// Translated: Memory$deAlloc$IF_END1
Memory$deAlloc$IF_END1:
// label 'IF_END0'
// Translated: Memory$deAlloc$IF_END0
Memory$deAlloc$IF_END0:
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'String$new':0
// Translated: String$new
String$new:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push constant 3
LXI B,0003
PUSH B
// call 'Memory$alloc':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Memory$alloc
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop pointer 0
POP H
SHLD THIS
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// if-goto 'IF_TRUE0'
// Translated: String$new$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ String$new$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: String$new$IF_FALSE0
JMP String$new$IF_FALSE0
// label 'IF_TRUE0'
// Translated: String$new$IF_TRUE0
String$new$IF_TRUE0:
// push constant 14
LXI B,000E
PUSH B
// call 'Sys$error':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Sys$error
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE0'
// Translated: String$new$IF_FALSE0
String$new$IF_FALSE0:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// if-goto 'IF_TRUE1'
// Translated: String$new$IF_TRUE1
POP H
MOV A,H
ORA L
JNZ String$new$IF_TRUE1
// goto 'IF_FALSE1'
// Translated: String$new$IF_FALSE1
JMP String$new$IF_FALSE1
// label 'IF_TRUE1'
// Translated: String$new$IF_TRUE1
String$new$IF_TRUE1:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Array$new':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Array$new
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// label 'IF_FALSE1'
// Translated: String$new$IF_FALSE1
String$new$IF_FALSE1:
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop this 0
LXI B,0000
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push constant 0
LXI B,0000
PUSH B
// pop this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push pointer 0
LHLD THIS
PUSH H
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'String$dispose':0
// Translated: String$dispose
String$dispose:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push this 0
LXI B,0000
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// if-goto 'IF_TRUE0'
// Translated: String$dispose$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ String$dispose$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: String$dispose$IF_FALSE0
JMP String$dispose$IF_FALSE0
// label 'IF_TRUE0'
// Translated: String$dispose$IF_TRUE0
String$dispose$IF_TRUE0:
// push this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Array$dispose':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Array$dispose
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE0'
// Translated: String$dispose$IF_FALSE0
String$dispose$IF_FALSE0:
// push pointer 0
LHLD THIS
PUSH H
// call 'Memory$deAlloc':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Memory$deAlloc
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'String$length':0
// Translated: String$length
String$length:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'String$charAt':0
// Translated: String$charAt
String$charAt:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// lt (inequality # 0)
POP H
POP B
CALL VM$gt
PUSH D
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// gt (inequality # 0)
POP B
POP H
CALL VM$gt
PUSH D
// or
POP B
POP H
MOV A,L
ORA C
MOV L,A
MOV A,H
ORA B
MOV H,A
PUSH H
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// or
POP B
POP H
MOV A,L
ORA C
MOV L,A
MOV A,H
ORA B
MOV H,A
PUSH H
// if-goto 'IF_TRUE0'
// Translated: String$charAt$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ String$charAt$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: String$charAt$IF_FALSE0
JMP String$charAt$IF_FALSE0
// label 'IF_TRUE0'
// Translated: String$charAt$IF_TRUE0
String$charAt$IF_TRUE0:
// push constant 15
LXI B,000F
PUSH B
// call 'Sys$error':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Sys$error
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE0'
// Translated: String$charAt$IF_FALSE0
String$charAt$IF_FALSE0:
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop pointer 1
POP H
SHLD THAT
// push that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'String$appendChar':0
// Translated: String$appendChar
String$appendChar:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push this 0
LXI B,0000
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE0'
// Translated: String$appendChar$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ String$appendChar$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: String$appendChar$IF_FALSE0
JMP String$appendChar$IF_FALSE0
// label 'IF_TRUE0'
// Translated: String$appendChar$IF_TRUE0
String$appendChar$IF_TRUE0:
// push constant 17
LXI B,0011
PUSH B
// call 'Sys$error':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Sys$error
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE0'
// Translated: String$appendChar$IF_FALSE0
String$appendChar$IF_FALSE0:
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push this 1
LXI B,0001
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop temp 0
POP H
SHLD TEMP0
// pop pointer 1
POP H
SHLD THAT
// push temp 0
LHLD TEMP0
PUSH H
// pop that 0
LXI B,0000
LHLD THAT
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// pop this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push pointer 0
LHLD THIS
PUSH H
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
// function 'String$eraseLastChar':0
// Translated: String$eraseLastChar
String$eraseLastChar:
LHLD LCL
PUSH H
LHLD ARG
PUSH H
LHLD THIS
PUSH H
LHLD THAT
PUSH H
XCHG
SHLD ARG
LXI H,FFFE
DAD SP
SHLD LCL
// push argument 0
LXI B,0000
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// pop pointer 0
POP H
SHLD THIS
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 0)
POP B
POP H
CALL VM$eq
PUSH D
// if-goto 'IF_TRUE0'
// Translated: String$eraseLastChar$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ String$eraseLastChar$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: String$eraseLastChar$IF_FALSE0
JMP String$eraseLastChar$IF_FALSE0
// label 'IF_TRUE0'
// Translated: String$eraseLastChar$IF_TRUE0
String$eraseLastChar$IF_TRUE0:
// push constant 18
LXI B,0012
PUSH B
// call 'Sys$error':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Sys$error
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// label 'IF_FALSE0'
// Translated: String$eraseLastChar$IF_FALSE0
String$eraseLastChar$IF_FALSE0:
// push this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// sub
POP B
POP H
MOV A,L
SUB C
MOV L,A
MOV A,H
SBB B
MOV H,A
PUSH H
// pop this 2
LXI B,0002
LHLD THIS
DAD B
CALL VM$memory
POP B
MOV M,C
INX H
MOV M,B
// push constant 0
LXI B,0000
PUSH B
// return
POP D
LHLD LCL
INX H
INX H
SPHL
POP H
SHLD THAT
POP H
SHLD THIS
POP H
SHLD ARG
POP H
SHLD LCL
RET
