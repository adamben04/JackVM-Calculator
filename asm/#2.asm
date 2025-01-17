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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
DCX H
DCX H
MOV D,M
DCX H
MOV E,M
XCHG
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// function 'ArbNum$changeOffset':0
// Translated: ArbNum$changeOffset
ArbNum$changeOffset:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// add
POP B
POP H
DAD B
PUSH H
// pop this 1
LXI B,0001
LHLD THIS
DAD B
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// function 'ArbNum$new':4
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
// pop local 2
LXI B,FFFC
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
POP B
MOV M,C
INX H
MOV M,B
// push constant 0
LXI B,0000
PUSH B
// pop this 1
LXI B,0001
LHLD THIS
DAD B
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// push constant 45
LXI B,002D
PUSH B
// eq (inequality # 0)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false0
MOV A,B
CMP H
JNZ VM$false0
LXI D,FFFF
JMP VM$end0
VM$false0:
LXI D,0000
VM$end0:
PUSH D
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
// not
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
PUSH H
// pop this 0
LXI B,0000
LHLD THIS
DAD B
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// goto 'IF_END0'
// Translated: ArbNum$new$IF_END0
JMP ArbNum$new$IF_END0
// label 'IF_FALSE0'
// Translated: ArbNum$new$IF_FALSE0
ArbNum$new$IF_FALSE0:
// push constant 0
LXI B,0000
PUSH B
// pop this 0
LXI B,0000
LHLD THIS
DAD B
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
POP B
MOV M,C
INX H
MOV M,B
// label 'IF_END0'
// Translated: ArbNum$new$IF_END0
ArbNum$new$IF_END0:
// label 'WHILE_EXP0'
// Translated: ArbNum$new$WHILE_EXP0
ArbNum$new$WHILE_EXP0:
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
// eq (inequality # 1)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false1
MOV A,B
CMP H
JNZ VM$false1
LXI D,FFFF
JMP VM$end1
VM$false1:
LXI D,0000
VM$end1:
PUSH D
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
// lt (inequality # 2)
POP H
POP B
MOV A,B
CMP H
JC VM$true2
MOV A,C
CMP L
JC VM$true2
LXI D,0000
JMP VM$end2
VM$true2:
LXI D,FFFF
VM$end2:
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
// label 'WHILE_EXP1'
// Translated: ArbNum$new$WHILE_EXP1
ArbNum$new$WHILE_EXP1:
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
// lt (inequality # 3)
POP H
POP B
MOV A,B
CMP H
JC VM$true3
MOV A,C
CMP L
JC VM$true3
LXI D,0000
JMP VM$end3
VM$true3:
LXI D,FFFF
VM$end3:
PUSH D
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
// gt (inequality # 4)
POP B
POP H
MOV A,B
CMP H
JC VM$true4
MOV A,C
CMP L
JC VM$true4
LXI D,0000
JMP VM$end4
VM$true4:
LXI D,FFFF
VM$end4:
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
// push constant 46
LXI B,002E
PUSH B
// eq (inequality # 5)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false5
MOV A,B
CMP H
JNZ VM$false5
LXI D,FFFF
JMP VM$end5
VM$false5:
LXI D,0000
VM$end5:
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
// push local 1
LXI B,FFFE
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// push local 3
LXI B,FFFA
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 32
LXI B,0020
PUSH B
// eq (inequality # 6)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false6
MOV A,B
CMP H
JNZ VM$false6
LXI D,FFFF
JMP VM$end6
VM$false6:
LXI D,0000
VM$end6:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// add
POP B
POP H
DAD B
PUSH H
// push local 3
LXI B,FFFA
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// goto 'WHILE_EXP1'
// Translated: ArbNum$new$WHILE_EXP1
JMP ArbNum$new$WHILE_EXP1
// label 'WHILE_END1'
// Translated: ArbNum$new$WHILE_END1
ArbNum$new$WHILE_END1:
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
// gt (inequality # 7)
POP B
POP H
MOV A,B
CMP H
JC VM$true7
MOV A,C
CMP L
JC VM$true7
LXI D,0000
JMP VM$end7
VM$true7:
LXI D,FFFF
VM$end7:
PUSH D
// push this 1
LXI B,0001
LHLD THIS
DAD B
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 8)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false8
MOV A,B
CMP H
JNZ VM$false8
LXI D,FFFF
JMP VM$end8
VM$false8:
LXI D,0000
VM$end8:
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
// if-goto 'IF_TRUE3'
// Translated: ArbNum$new$IF_TRUE3
POP H
MOV A,H
ORA L
JNZ ArbNum$new$IF_TRUE3
// goto 'IF_FALSE3'
// Translated: ArbNum$new$IF_FALSE3
JMP ArbNum$new$IF_FALSE3
// label 'IF_TRUE3'
// Translated: ArbNum$new$IF_TRUE3
ArbNum$new$IF_TRUE3:
// push local 1
LXI B,FFFE
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
POP B
MOV M,C
INX H
MOV M,B
// label 'IF_FALSE3'
// Translated: ArbNum$new$IF_FALSE3
ArbNum$new$IF_FALSE3:
// label 'WHILE_EXP2'
// Translated: ArbNum$new$WHILE_EXP2
ArbNum$new$WHILE_EXP2:
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
// gt (inequality # 9)
POP B
POP H
MOV A,B
CMP H
JC VM$true9
MOV A,C
CMP L
JC VM$true9
LXI D,0000
JMP VM$end9
VM$true9:
LXI D,FFFF
VM$end9:
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
// Translated: ArbNum$new$WHILE_END2
POP H
MOV A,H
ORA L
JNZ ArbNum$new$WHILE_END2
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// label 'WHILE_EXP3'
// Translated: ArbNum$new$WHILE_EXP3
ArbNum$new$WHILE_EXP3:
// push this 1
LXI B,0001
LHLD THIS
DAD B
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// lt (inequality # 10)
POP H
POP B
MOV A,B
CMP H
JC VM$true10
MOV A,C
CMP L
JC VM$true10
LXI D,0000
JMP VM$end10
VM$true10:
LXI D,FFFF
VM$end10:
PUSH D
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 11)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false11
MOV A,B
CMP H
JNZ VM$false11
LXI D,FFFF
JMP VM$end11
VM$false11:
LXI D,0000
VM$end11:
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
// if-goto 'WHILE_END3'
// Translated: ArbNum$new$WHILE_END3
POP H
MOV A,H
ORA L
JNZ ArbNum$new$WHILE_END3
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
// goto 'WHILE_EXP3'
// Translated: ArbNum$new$WHILE_EXP3
JMP ArbNum$new$WHILE_EXP3
// label 'WHILE_END3'
// Translated: ArbNum$new$WHILE_END3
ArbNum$new$WHILE_END3:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// gt (inequality # 12)
POP B
POP H
MOV A,B
CMP H
JC VM$true12
MOV A,C
CMP L
JC VM$true12
LXI D,0000
JMP VM$end12
VM$true12:
LXI D,FFFF
VM$end12:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// eq (inequality # 13)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false13
MOV A,B
CMP H
JNZ VM$false13
LXI D,FFFF
JMP VM$end13
VM$false13:
LXI D,0000
VM$end13:
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
// gt (inequality # 14)
POP B
POP H
MOV A,B
CMP H
JC VM$true14
MOV A,C
CMP L
JC VM$true14
LXI D,0000
JMP VM$end14
VM$true14:
LXI D,FFFF
VM$end14:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// eq (inequality # 15)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false15
MOV A,B
CMP H
JNZ VM$false15
LXI D,FFFF
JMP VM$end15
VM$false15:
LXI D,0000
VM$end15:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 9
LXI B,0009
PUSH B
// gt (inequality # 16)
POP B
POP H
MOV A,B
CMP H
JC VM$true16
MOV A,C
CMP L
JC VM$true16
LXI D,0000
JMP VM$end16
VM$true16:
LXI D,FFFF
VM$end16:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP0'
// Translated: ArbNum$arrayAdd$WHILE_EXP0
ArbNum$arrayAdd$WHILE_EXP0:
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
// lt (inequality # 17)
POP H
POP B
MOV A,B
CMP H
JC VM$true17
MOV A,C
CMP L
JC VM$true17
LXI D,0000
JMP VM$end17
VM$true17:
LXI D,FFFF
VM$end17:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 9
LXI B,0009
PUSH B
// gt (inequality # 18)
POP B
POP H
MOV A,B
CMP H
JC VM$true18
MOV A,C
CMP L
JC VM$true18
LXI D,0000
JMP VM$end18
VM$true18:
LXI D,FFFF
VM$end18:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// Translated: ArbNum$arrayAdd$IF_END0
JMP ArbNum$arrayAdd$IF_END0
// label 'IF_FALSE0'
// Translated: ArbNum$arrayAdd$IF_FALSE0
ArbNum$arrayAdd$IF_FALSE0:
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
// Translated: ArbNum$arrayAdd$IF_END0
ArbNum$arrayAdd$IF_END0:
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
// Translated: ArbNum$arrayAdd$WHILE_EXP0
JMP ArbNum$arrayAdd$WHILE_EXP0
// label 'WHILE_END0'
// Translated: ArbNum$arrayAdd$WHILE_END0
ArbNum$arrayAdd$WHILE_END0:
// push local 1
LXI B,FFFE
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
POP B
MOV M,C
INX H
MOV M,B
// label 'IF_FALSE1'
// Translated: ArbNum$arrayAdd$IF_FALSE1
ArbNum$arrayAdd$IF_FALSE1:
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
// pop local 1
LXI B,FFFE
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
// lt (inequality # 19)
POP H
POP B
MOV A,B
CMP H
JC VM$true19
MOV A,C
CMP L
JC VM$true19
LXI D,0000
JMP VM$end19
VM$true19:
LXI D,FFFF
VM$end19:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// lt (inequality # 20)
POP H
POP B
MOV A,B
CMP H
JC VM$true20
MOV A,C
CMP L
JC VM$true20
LXI D,0000
JMP VM$end20
VM$true20:
LXI D,FFFF
VM$end20:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 21)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false21
MOV A,B
CMP H
JNZ VM$false21
LXI D,FFFF
JMP VM$end21
VM$false21:
LXI D,0000
VM$end21:
PUSH D
// push this 1
LXI B,0001
LHLD THIS
DAD B
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// push static 0
// Translated: ArbNum$0
LHLD ArbNum$0
PUSH H
// lt (inequality # 22)
POP H
POP B
MOV A,B
CMP H
JC VM$true22
MOV A,C
CMP L
JC VM$true22
LXI D,0000
JMP VM$end22
VM$true22:
LXI D,FFFF
VM$end22:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// lt (inequality # 23)
POP H
POP B
MOV A,B
CMP H
JC VM$true23
MOV A,C
CMP L
JC VM$true23
LXI D,0000
JMP VM$end23
VM$true23:
LXI D,FFFF
VM$end23:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// push constant 1
LXI B,0001
PUSH B
// gt (inequality # 24)
POP B
POP H
MOV A,B
CMP H
JC VM$true24
MOV A,C
CMP L
JC VM$true24
LXI D,0000
JMP VM$end24
VM$true24:
LXI D,FFFF
VM$end24:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// eq (inequality # 25)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false25
MOV A,B
CMP H
JNZ VM$false25
LXI D,FFFF
JMP VM$end25
VM$false25:
LXI D,0000
VM$end25:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// lt (inequality # 26)
POP H
POP B
MOV A,B
CMP H
JC VM$true26
MOV A,C
CMP L
JC VM$true26
LXI D,0000
JMP VM$end26
VM$true26:
LXI D,FFFF
VM$end26:
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
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 27)
POP B
POP H
MOV A,B
CMP H
JC VM$true27
MOV A,C
CMP L
JC VM$true27
LXI D,0000
JMP VM$end27
VM$true27:
LXI D,FFFF
VM$end27:
PUSH D
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// eq (inequality # 28)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false28
MOV A,B
CMP H
JNZ VM$false28
LXI D,FFFF
JMP VM$end28
VM$false28:
LXI D,0000
VM$end28:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// gt (inequality # 29)
POP B
POP H
MOV A,B
CMP H
JC VM$true29
MOV A,C
CMP L
JC VM$true29
LXI D,0000
JMP VM$end29
VM$true29:
LXI D,FFFF
VM$end29:
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
// push this 1
LXI B,0001
LHLD THIS
DAD B
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// eq (inequality # 30)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false30
MOV A,B
CMP H
JNZ VM$false30
LXI D,FFFF
JMP VM$end30
VM$false30:
LXI D,0000
VM$end30:
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
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 31)
POP B
POP H
MOV A,B
CMP H
JC VM$true31
MOV A,C
CMP L
JC VM$true31
LXI D,0000
JMP VM$end31
VM$true31:
LXI D,FFFF
VM$end31:
PUSH D
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// eq (inequality # 32)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false32
MOV A,B
CMP H
JNZ VM$false32
LXI D,FFFF
JMP VM$end32
VM$false32:
LXI D,0000
VM$end32:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// eq (inequality # 33)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false33
MOV A,B
CMP H
JNZ VM$false33
LXI D,FFFF
JMP VM$end33
VM$false33:
LXI D,0000
VM$end33:
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
// push constant 20
LXI B,0014
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
// pop static 2
// Translated: Main$2
POP H
SHLD Main$2
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
// call 'Main$debugPrint':0
LXI H,FFFE
DAD SP
PUSH H
XCHG
CALL Main$debugPrint
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// push static 2
// Translated: Main$2
LHLD Main$2
PUSH H
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
// pop static 3
// Translated: Main$3
POP H
SHLD Main$3
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 140
LXI B,008C
PUSH B
// eq (inequality # 34)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false34
MOV A,B
CMP H
JNZ VM$false34
LXI D,FFFF
JMP VM$end34
VM$false34:
LXI D,0000
VM$end34:
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
// label 'WHILE_EXP1'
// Translated: Main$main$WHILE_EXP1
Main$main$WHILE_EXP1:
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 35)
POP B
POP H
MOV A,B
CMP H
JC VM$true35
MOV A,C
CMP L
JC VM$true35
LXI D,0000
JMP VM$end35
VM$true35:
LXI D,FFFF
VM$end35:
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
// Translated: Main$main$WHILE_END1
POP H
MOV A,H
ORA L
JNZ Main$main$WHILE_END1
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// goto 'WHILE_EXP1'
// Translated: Main$main$WHILE_EXP1
JMP Main$main$WHILE_EXP1
// label 'WHILE_END1'
// Translated: Main$main$WHILE_END1
Main$main$WHILE_END1:
// push static 2
// Translated: Main$2
LHLD Main$2
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
// push constant 20
LXI B,0014
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
// pop static 2
// Translated: Main$2
POP H
SHLD Main$2
// label 'IF_FALSE0'
// Translated: Main$main$IF_FALSE0
Main$main$IF_FALSE0:
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 128
LXI B,0080
PUSH B
// eq (inequality # 36)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false36
MOV A,B
CMP H
JNZ VM$false36
LXI D,FFFF
JMP VM$end36
VM$false36:
LXI D,0000
VM$end36:
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
// push static 0
// Translated: Main$0
LHLD Main$0
PUSH H
// add
POP B
POP H
DAD B
PUSH H
// push static 2
// Translated: Main$2
LHLD Main$2
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
POP B
MOV M,C
INX H
MOV M,B
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Main$printNum':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Main$printNum
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
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
// push constant 20
LXI B,0014
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
// pop static 2
// Translated: Main$2
POP H
SHLD Main$2
// label 'IF_FALSE1'
// Translated: Main$main$IF_FALSE1
Main$main$IF_FALSE1:
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 58
LXI B,003A
PUSH B
// lt (inequality # 37)
POP H
POP B
MOV A,B
CMP H
JC VM$true37
MOV A,C
CMP L
JC VM$true37
LXI D,0000
JMP VM$end37
VM$true37:
LXI D,FFFF
VM$end37:
PUSH D
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 47
LXI B,002F
PUSH B
// gt (inequality # 38)
POP B
POP H
MOV A,B
CMP H
JC VM$true38
MOV A,C
CMP L
JC VM$true38
LXI D,0000
JMP VM$end38
VM$true38:
LXI D,FFFF
VM$end38:
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
// push static 2
// Translated: Main$2
LHLD Main$2
PUSH H
// push static 3
// Translated: Main$3
LHLD Main$3
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
// label 'IF_FALSE2'
// Translated: Main$main$IF_FALSE2
Main$main$IF_FALSE2:
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 46
LXI B,002E
PUSH B
// eq (inequality # 39)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false39
MOV A,B
CMP H
JNZ VM$false39
LXI D,FFFF
JMP VM$end39
VM$false39:
LXI D,0000
VM$end39:
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
// push static 2
// Translated: Main$2
LHLD Main$2
PUSH H
// push static 3
// Translated: Main$3
LHLD Main$3
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
// label 'IF_FALSE3'
// Translated: Main$main$IF_FALSE3
Main$main$IF_FALSE3:
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 129
LXI B,0081
PUSH B
// eq (inequality # 40)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false40
MOV A,B
CMP H
JNZ VM$false40
LXI D,FFFF
JMP VM$end40
VM$false40:
LXI D,0000
VM$end40:
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
// push static 2
// Translated: Main$2
LHLD Main$2
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
// label 'IF_FALSE4'
// Translated: Main$main$IF_FALSE4
Main$main$IF_FALSE4:
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 76
LXI B,004C
PUSH B
// eq (inequality # 41)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false41
MOV A,B
CMP H
JNZ VM$false41
LXI D,FFFF
JMP VM$end41
VM$false41:
LXI D,0000
VM$end41:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 4
// Translated: Main$4
POP H
SHLD Main$4
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
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
// pop static 6
// Translated: Main$6
POP H
SHLD Main$6
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
// push static 6
// Translated: Main$6
LHLD Main$6
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// push static 4
// Translated: Main$4
LHLD Main$4
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
// label 'IF_FALSE5'
// Translated: Main$main$IF_FALSE5
Main$main$IF_FALSE5:
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 87
LXI B,0057
PUSH B
// eq (inequality # 42)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false42
MOV A,B
CMP H
JNZ VM$false42
LXI D,FFFF
JMP VM$end42
VM$false42:
LXI D,0000
VM$end42:
PUSH D
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 4
// Translated: Main$4
POP H
SHLD Main$4
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
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
// pop static 6
// Translated: Main$6
POP H
SHLD Main$6
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
// push static 6
// Translated: Main$6
LHLD Main$6
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// push static 4
// Translated: Main$4
LHLD Main$4
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
// label 'IF_FALSE6'
// Translated: Main$main$IF_FALSE6
Main$main$IF_FALSE6:
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 80
LXI B,0050
PUSH B
// eq (inequality # 43)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false43
MOV A,B
CMP H
JNZ VM$false43
LXI D,FFFF
JMP VM$end43
VM$false43:
LXI D,0000
VM$end43:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// label 'IF_FALSE7'
// Translated: Main$main$IF_FALSE7
Main$main$IF_FALSE7:
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 69
LXI B,0045
PUSH B
// eq (inequality # 44)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false44
MOV A,B
CMP H
JNZ VM$false44
LXI D,FFFF
JMP VM$end44
VM$false44:
LXI D,0000
VM$end44:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// label 'IF_FALSE8'
// Translated: Main$main$IF_FALSE8
Main$main$IF_FALSE8:
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 43
LXI B,002B
PUSH B
// eq (inequality # 45)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false45
MOV A,B
CMP H
JNZ VM$false45
LXI D,FFFF
JMP VM$end45
VM$false45:
LXI D,0000
VM$end45:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 4
// Translated: Main$4
POP H
SHLD Main$4
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push static 5
// Translated: Main$5
LHLD Main$5
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
// pop static 6
// Translated: Main$6
POP H
SHLD Main$6
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
// push static 6
// Translated: Main$6
LHLD Main$6
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// push static 4
// Translated: Main$4
LHLD Main$4
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
// label 'IF_FALSE9'
// Translated: Main$main$IF_FALSE9
Main$main$IF_FALSE9:
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 45
LXI B,002D
PUSH B
// eq (inequality # 46)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false46
MOV A,B
CMP H
JNZ VM$false46
LXI D,FFFF
JMP VM$end46
VM$false46:
LXI D,0000
VM$end46:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 4
// Translated: Main$4
POP H
SHLD Main$4
// push static 4
// Translated: Main$4
LHLD Main$4
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
// pop static 6
// Translated: Main$6
POP H
SHLD Main$6
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
// push static 6
// Translated: Main$6
LHLD Main$6
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// push static 4
// Translated: Main$4
LHLD Main$4
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
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 42
LXI B,002A
PUSH B
// eq (inequality # 47)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false47
MOV A,B
CMP H
JNZ VM$false47
LXI D,FFFF
JMP VM$end47
VM$false47:
LXI D,0000
VM$end47:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 4
// Translated: Main$4
POP H
SHLD Main$4
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push static 5
// Translated: Main$5
LHLD Main$5
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
// pop static 6
// Translated: Main$6
POP H
SHLD Main$6
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
// push static 6
// Translated: Main$6
LHLD Main$6
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// push static 4
// Translated: Main$4
LHLD Main$4
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
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 47
LXI B,002F
PUSH B
// eq (inequality # 48)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false48
MOV A,B
CMP H
JNZ VM$false48
LXI D,FFFF
JMP VM$end48
VM$false48:
LXI D,0000
VM$end48:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 4
// Translated: Main$4
POP H
SHLD Main$4
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push static 5
// Translated: Main$5
LHLD Main$5
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
// pop static 6
// Translated: Main$6
POP H
SHLD Main$6
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
// push static 6
// Translated: Main$6
LHLD Main$6
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// push static 4
// Translated: Main$4
LHLD Main$4
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
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 94
LXI B,005E
PUSH B
// eq (inequality # 49)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false49
MOV A,B
CMP H
JNZ VM$false49
LXI D,FFFF
JMP VM$end49
VM$false49:
LXI D,0000
VM$end49:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 4
// Translated: Main$4
POP H
SHLD Main$4
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push static 5
// Translated: Main$5
LHLD Main$5
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
// pop static 6
// Translated: Main$6
POP H
SHLD Main$6
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
// push static 6
// Translated: Main$6
LHLD Main$6
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// push static 4
// Translated: Main$4
LHLD Main$4
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
// label 'IF_FALSE13'
// Translated: Main$main$IF_FALSE13
Main$main$IF_FALSE13:
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 82
LXI B,0052
PUSH B
// eq (inequality # 50)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false50
MOV A,B
CMP H
JNZ VM$false50
LXI D,FFFF
JMP VM$end50
VM$false50:
LXI D,0000
VM$end50:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 4
// Translated: Main$4
POP H
SHLD Main$4
// push static 4
// Translated: Main$4
LHLD Main$4
PUSH H
// push static 5
// Translated: Main$5
LHLD Main$5
PUSH H
// call 'Math$nroot':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$nroot
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop static 6
// Translated: Main$6
POP H
SHLD Main$6
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
// push static 6
// Translated: Main$6
LHLD Main$6
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// push static 4
// Translated: Main$4
LHLD Main$4
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
// label 'IF_FALSE14'
// Translated: Main$main$IF_FALSE14
Main$main$IF_FALSE14:
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 83
LXI B,0053
PUSH B
// eq (inequality # 51)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false51
MOV A,B
CMP H
JNZ VM$false51
LXI D,FFFF
JMP VM$end51
VM$false51:
LXI D,0000
VM$end51:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 4
// Translated: Main$4
POP H
SHLD Main$4
// push static 4
// Translated: Main$4
LHLD Main$4
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
// pop static 6
// Translated: Main$6
POP H
SHLD Main$6
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
// push static 6
// Translated: Main$6
LHLD Main$6
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// push static 4
// Translated: Main$4
LHLD Main$4
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
// label 'IF_FALSE15'
// Translated: Main$main$IF_FALSE15
Main$main$IF_FALSE15:
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 67
LXI B,0043
PUSH B
// eq (inequality # 52)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false52
MOV A,B
CMP H
JNZ VM$false52
LXI D,FFFF
JMP VM$end52
VM$false52:
LXI D,0000
VM$end52:
PUSH D
// if-goto 'IF_TRUE16'
// Translated: Main$main$IF_TRUE16
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE16
// goto 'IF_FALSE16'
// Translated: Main$main$IF_FALSE16
JMP Main$main$IF_FALSE16
// label 'IF_TRUE16'
// Translated: Main$main$IF_TRUE16
Main$main$IF_TRUE16:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 4
// Translated: Main$4
POP H
SHLD Main$4
// push static 4
// Translated: Main$4
LHLD Main$4
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
// pop static 6
// Translated: Main$6
POP H
SHLD Main$6
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
// push static 6
// Translated: Main$6
LHLD Main$6
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// push static 4
// Translated: Main$4
LHLD Main$4
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
// label 'IF_FALSE16'
// Translated: Main$main$IF_FALSE16
Main$main$IF_FALSE16:
// push static 3
// Translated: Main$3
LHLD Main$3
PUSH H
// push constant 84
LXI B,0054
PUSH B
// eq (inequality # 53)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false53
MOV A,B
CMP H
JNZ VM$false53
LXI D,FFFF
JMP VM$end53
VM$false53:
LXI D,0000
VM$end53:
PUSH D
// if-goto 'IF_TRUE17'
// Translated: Main$main$IF_TRUE17
POP H
MOV A,H
ORA L
JNZ Main$main$IF_TRUE17
// goto 'IF_FALSE17'
// Translated: Main$main$IF_FALSE17
JMP Main$main$IF_FALSE17
// label 'IF_TRUE17'
// Translated: Main$main$IF_TRUE17
Main$main$IF_TRUE17:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// pop static 4
// Translated: Main$4
POP H
SHLD Main$4
// push static 4
// Translated: Main$4
LHLD Main$4
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
// pop static 6
// Translated: Main$6
POP H
SHLD Main$6
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
// push static 6
// Translated: Main$6
LHLD Main$6
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// push static 4
// Translated: Main$4
LHLD Main$4
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
// label 'IF_FALSE17'
// Translated: Main$main$IF_FALSE17
Main$main$IF_FALSE17:
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
// function 'Main$debugPrint':1
// Translated: Main$debugPrint
Main$debugPrint:
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
// call 'Screen$clearScreen':0
LXI H,FFFE
DAD SP
PUSH H
XCHG
CALL Screen$clearScreen
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
// push constant 0
LXI B,0000
PUSH B
// call 'Output$moveCursor':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Output$moveCursor
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
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP0'
// Translated: Main$debugPrint$WHILE_EXP0
Main$debugPrint$WHILE_EXP0:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push static 1
// Translated: Main$1
LHLD Main$1
PUSH H
// lt (inequality # 54)
POP H
POP B
MOV A,B
CMP H
JC VM$true54
MOV A,C
CMP L
JC VM$true54
LXI D,0000
JMP VM$end54
VM$true54:
LXI D,FFFF
VM$end54:
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
// Translated: Main$debugPrint$WHILE_END0
POP H
MOV A,H
ORA L
JNZ Main$debugPrint$WHILE_END0
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Main$printNum':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Main$printNum
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
// Translated: Main$debugPrint$WHILE_EXP0
JMP Main$debugPrint$WHILE_EXP0
// label 'WHILE_END0'
// Translated: Main$debugPrint$WHILE_END0
Main$debugPrint$WHILE_END0:
// label 'WHILE_EXP1'
// Translated: Main$debugPrint$WHILE_EXP1
Main$debugPrint$WHILE_EXP1:
// push local 0
LXI B,0000
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 10
LXI B,000A
PUSH B
// lt (inequality # 55)
POP H
POP B
MOV A,B
CMP H
JC VM$true55
MOV A,C
CMP L
JC VM$true55
LXI D,0000
JMP VM$end55
VM$true55:
LXI D,FFFF
VM$end55:
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
// Translated: Main$debugPrint$WHILE_END1
POP H
MOV A,H
ORA L
JNZ Main$debugPrint$WHILE_END1
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
// goto 'WHILE_EXP1'
// Translated: Main$debugPrint$WHILE_EXP1
JMP Main$debugPrint$WHILE_EXP1
// label 'WHILE_END1'
// Translated: Main$debugPrint$WHILE_END1
Main$debugPrint$WHILE_END1:
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
// label 'WHILE_EXP2'
// Translated: Main$debugPrint$WHILE_EXP2
Main$debugPrint$WHILE_EXP2:
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
// lt (inequality # 56)
POP H
POP B
MOV A,B
CMP H
JC VM$true56
MOV A,C
CMP L
JC VM$true56
LXI D,0000
JMP VM$end56
VM$true56:
LXI D,FFFF
VM$end56:
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
// Translated: Main$debugPrint$WHILE_END2
POP H
MOV A,H
ORA L
JNZ Main$debugPrint$WHILE_END2
// push constant 45
LXI B,002D
PUSH B
// call 'Output$printChar':1
LXI H,0000
DAD SP
PUSH H
XCHG
CALL Output$printChar
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
// Translated: Main$debugPrint$WHILE_EXP2
JMP Main$debugPrint$WHILE_EXP2
// label 'WHILE_END2'
// Translated: Main$debugPrint$WHILE_END2
Main$debugPrint$WHILE_END2:
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
// pop static 5
// Translated: Math$5
POP H
SHLD Math$5
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
// pop static 2
// Translated: Math$2
POP H
SHLD Math$2
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
// function 'Math$add':3
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
// eq (inequality # 57)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false57
MOV A,B
CMP H
JNZ VM$false57
LXI D,FFFF
JMP VM$end57
VM$false57:
LXI D,0000
VM$end57:
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
// goto 'IF_END1'
// Translated: Math$add$IF_END1
JMP Math$add$IF_END1
// label 'IF_FALSE1'
// Translated: Math$add$IF_FALSE1
Math$add$IF_FALSE1:
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
// label 'IF_END1'
// Translated: Math$add$IF_END1
Math$add$IF_END1:
// label 'IF_FALSE0'
// Translated: Math$add$IF_FALSE0
Math$add$IF_FALSE0:
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
// eq (inequality # 58)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false58
MOV A,B
CMP H
JNZ VM$false58
LXI D,FFFF
JMP VM$end58
VM$false58:
LXI D,0000
VM$end58:
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
// gt (inequality # 59)
POP B
POP H
MOV A,B
CMP H
JC VM$true59
MOV A,C
CMP L
JC VM$true59
LXI D,0000
JMP VM$end59
VM$true59:
LXI D,FFFF
VM$end59:
PUSH D
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
// goto 'IF_END2'
// Translated: Math$add$IF_END2
JMP Math$add$IF_END2
// label 'IF_FALSE2'
// Translated: Math$add$IF_FALSE2
Math$add$IF_FALSE2:
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
// label 'IF_END2'
// Translated: Math$add$IF_END2
Math$add$IF_END2:
// goto 'WHILE_EXP0'
// Translated: Math$add$WHILE_EXP0
JMP Math$add$WHILE_EXP0
// label 'WHILE_END0'
// Translated: Math$add$WHILE_END0
Math$add$WHILE_END0:
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
// function 'Math$sub':3
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
// eq (inequality # 60)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false60
MOV A,B
CMP H
JNZ VM$false60
LXI D,FFFF
JMP VM$end60
VM$false60:
LXI D,0000
VM$end60:
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
// gt (inequality # 61)
POP B
POP H
MOV A,B
CMP H
JC VM$true61
MOV A,C
CMP L
JC VM$true61
LXI D,0000
JMP VM$end61
VM$true61:
LXI D,FFFF
VM$end61:
PUSH D
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
// goto 'IF_END4'
// Translated: Math$sub$IF_END4
JMP Math$sub$IF_END4
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
// label 'IF_END4'
// Translated: Math$sub$IF_END4
Math$sub$IF_END4:
// goto 'WHILE_EXP0'
// Translated: Math$sub$WHILE_EXP0
JMP Math$sub$WHILE_EXP0
// label 'WHILE_END0'
// Translated: Math$sub$WHILE_END0
Math$sub$WHILE_END0:
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
// eq (inequality # 62)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false62
MOV A,B
CMP H
JNZ VM$false62
LXI D,FFFF
JMP VM$end62
VM$false62:
LXI D,0000
VM$end62:
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
// gt (inequality # 63)
POP B
POP H
MOV A,B
CMP H
JC VM$true63
MOV A,C
CMP L
JC VM$true63
LXI D,0000
JMP VM$end63
VM$true63:
LXI D,FFFF
VM$end63:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
// gt (inequality # 64)
POP B
POP H
MOV A,B
CMP H
JC VM$true64
MOV A,C
CMP L
JC VM$true64
LXI D,0000
JMP VM$end64
VM$true64:
LXI D,FFFF
VM$end64:
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
// pop local 5
LXI B,FFF6
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP2'
// Translated: Math$mul$WHILE_EXP2
Math$mul$WHILE_EXP2:
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 65)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false65
MOV A,B
CMP H
JNZ VM$false65
LXI D,FFFF
JMP VM$end65
VM$false65:
LXI D,0000
VM$end65:
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
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// lt (inequality # 66)
POP H
POP B
MOV A,B
CMP H
JC VM$true66
MOV A,C
CMP L
JC VM$true66
LXI D,0000
JMP VM$end66
VM$true66:
LXI D,FFFF
VM$end66:
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
// Translated: Math$mul$WHILE_END2
POP H
MOV A,H
ORA L
JNZ Math$mul$WHILE_END2
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
// goto 'WHILE_EXP2'
// Translated: Math$mul$WHILE_EXP2
JMP Math$mul$WHILE_EXP2
// label 'WHILE_END2'
// Translated: Math$mul$WHILE_END2
Math$mul$WHILE_END2:
// label 'WHILE_EXP3'
// Translated: Math$mul$WHILE_EXP3
Math$mul$WHILE_EXP3:
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
// push local 4
LXI B,FFF8
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// gt (inequality # 67)
POP B
POP H
MOV A,B
CMP H
JC VM$true67
MOV A,C
CMP L
JC VM$true67
LXI D,0000
JMP VM$end67
VM$true67:
LXI D,FFFF
VM$end67:
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
// if-goto 'WHILE_END3'
// Translated: Math$mul$WHILE_END3
POP H
MOV A,H
ORA L
JNZ Math$mul$WHILE_END3
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
// goto 'WHILE_EXP3'
// Translated: Math$mul$WHILE_EXP3
JMP Math$mul$WHILE_EXP3
// label 'WHILE_END3'
// Translated: Math$mul$WHILE_END3
Math$mul$WHILE_END3:
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
// function 'Math$div':8
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
// push constant 21
LXI B,0015
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
// Translated: Math$div$IF_FALSE1
Math$div$IF_FALSE1:
// push argument 1
LXI B,FFFE
LHLD ARG
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
// push static 4
// Translated: Math$4
LHLD Math$4
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
// Translated: Math$div$IF_FALSE2
Math$div$IF_FALSE2:
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
// push local 2
LXI B,FFFC
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
// eq (inequality # 68)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false68
MOV A,B
CMP H
JNZ VM$false68
LXI D,FFFF
JMP VM$end68
VM$false68:
LXI D,0000
VM$end68:
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
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// eq (inequality # 69)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false69
MOV A,B
CMP H
JNZ VM$false69
LXI D,FFFF
JMP VM$end69
VM$false69:
LXI D,0000
VM$end69:
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
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// eq (inequality # 70)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false70
MOV A,B
CMP H
JNZ VM$false70
LXI D,FFFF
JMP VM$end70
VM$false70:
LXI D,0000
VM$end70:
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
// neg
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
INX H
PUSH H
// call 'ArbNum$changeOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$changeOffset
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
// push constant 1
LXI B,0001
PUSH B
// neg
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
INX H
PUSH H
// call 'ArbNum$changeOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$changeOffset
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
// push local 5
LXI B,FFF6
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
// pop local 5
LXI B,FFF6
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
// push local 5
LXI B,FFF6
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 71)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false71
MOV A,B
CMP H
JNZ VM$false71
LXI D,FFFF
JMP VM$end71
VM$false71:
LXI D,0000
VM$end71:
PUSH D
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
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 72)
POP B
POP H
MOV A,B
CMP H
JC VM$true72
MOV A,C
CMP L
JC VM$true72
LXI D,0000
JMP VM$end72
VM$true72:
LXI D,FFFF
VM$end72:
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
// push local 1
LXI B,FFFE
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
// neg
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
INX H
PUSH H
// call 'ArbNum$changeOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$changeOffset
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
// pop local 6
LXI B,FFF4
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP1'
// Translated: Math$div$WHILE_EXP1
Math$div$WHILE_EXP1:
// push local 5
LXI B,FFF6
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 73)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false73
MOV A,B
CMP H
JNZ VM$false73
LXI D,FFFF
JMP VM$end73
VM$false73:
LXI D,0000
VM$end73:
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
// push constant 0
LXI B,0000
PUSH B
// gt (inequality # 74)
POP B
POP H
MOV A,B
CMP H
JC VM$true74
MOV A,C
CMP L
JC VM$true74
LXI D,0000
JMP VM$end74
VM$true74:
LXI D,FFFF
VM$end74:
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
// Translated: Math$div$WHILE_END1
POP H
MOV A,H
ORA L
JNZ Math$div$WHILE_END1
// push local 0
LXI B,0000
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
// push constant 1
LXI B,0001
PUSH B
// neg
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
INX H
PUSH H
// call 'ArbNum$changeOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$changeOffset
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
// label 'WHILE_EXP2'
// Translated: Math$div$WHILE_EXP2
Math$div$WHILE_EXP2:
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
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// lt (inequality # 75)
POP H
POP B
MOV A,B
CMP H
JC VM$true75
MOV A,C
CMP L
JC VM$true75
LXI D,0000
JMP VM$end75
VM$true75:
LXI D,FFFF
VM$end75:
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
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// lt (inequality # 76)
POP H
POP B
MOV A,B
CMP H
JC VM$true76
MOV A,C
CMP L
JC VM$true76
LXI D,0000
JMP VM$end76
VM$true76:
LXI D,FFFF
VM$end76:
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
// Translated: Math$div$WHILE_END2
POP H
MOV A,H
ORA L
JNZ Math$div$WHILE_END2
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
// call 'ArbNum$changeOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$changeOffset
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
// push constant 1
LXI B,0001
PUSH B
// call 'ArbNum$changeOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$changeOffset
POP H
SPHL
MOV M,D
INX H
MOV M,E
// pop temp 0
POP H
SHLD TEMP0
// goto 'WHILE_EXP2'
// Translated: Math$div$WHILE_EXP2
JMP Math$div$WHILE_EXP2
// label 'WHILE_END2'
// Translated: Math$div$WHILE_END2
Math$div$WHILE_END2:
// push local 2
LXI B,FFFC
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
// push local 5
LXI B,FFF6
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
// label 'WHILE_EXP3'
// Translated: Math$div$WHILE_EXP3
Math$div$WHILE_EXP3:
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
// gt (inequality # 77)
POP B
POP H
MOV A,B
CMP H
JC VM$true77
MOV A,C
CMP L
JC VM$true77
LXI D,0000
JMP VM$end77
VM$true77:
LXI D,FFFF
VM$end77:
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
// if-goto 'WHILE_END3'
// Translated: Math$div$WHILE_END3
POP H
MOV A,H
ORA L
JNZ Math$div$WHILE_END3
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
// push local 1
LXI B,FFFE
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
// push local 3
LXI B,FFFA
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
// push local 4
LXI B,FFF8
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP4'
// Translated: Math$div$WHILE_EXP4
JMP Math$div$WHILE_EXP4
// label 'WHILE_END4'
// Translated: Math$div$WHILE_END4
Math$div$WHILE_END4:
// push local 5
LXI B,FFF6
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 78)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false78
MOV A,B
CMP H
JNZ VM$false78
LXI D,FFFF
JMP VM$end78
VM$false78:
LXI D,0000
VM$end78:
PUSH D
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
// label 'IF_FALSE4'
// Translated: Math$div$IF_FALSE4
Math$div$IF_FALSE4:
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
// neg
POP H
MOV A,L
CMA
MOV L,A
MOV A,H
CMA
MOV H,A
INX H
PUSH H
// call 'ArbNum$changeOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$changeOffset
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
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// eq (inequality # 79)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false79
MOV A,B
CMP H
JNZ VM$false79
LXI D,FFFF
JMP VM$end79
VM$false79:
LXI D,0000
VM$end79:
PUSH D
// push local 4
LXI B,FFF8
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 80)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false80
MOV A,B
CMP H
JNZ VM$false80
LXI D,FFFF
JMP VM$end80
VM$false80:
LXI D,0000
VM$end80:
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
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// lt (inequality # 81)
POP H
POP B
MOV A,B
CMP H
JC VM$true81
MOV A,C
CMP L
JC VM$true81
LXI D,0000
JMP VM$end81
VM$true81:
LXI D,FFFF
VM$end81:
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
// if-goto 'IF_TRUE5'
// Translated: Math$div$IF_TRUE5
POP H
MOV A,H
ORA L
JNZ Math$div$IF_TRUE5
// goto 'IF_FALSE5'
// Translated: Math$div$IF_FALSE5
JMP Math$div$IF_FALSE5
// label 'IF_TRUE5'
// Translated: Math$div$IF_TRUE5
Math$div$IF_TRUE5:
// push local 2
LXI B,FFFC
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 1
LXI B,0001
PUSH B
// call 'ArbNum$changeOffset':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL ArbNum$changeOffset
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
// label 'IF_FALSE5'
// Translated: Math$div$IF_FALSE5
Math$div$IF_FALSE5:
// goto 'WHILE_EXP3'
// Translated: Math$div$WHILE_EXP3
JMP Math$div$WHILE_EXP3
// label 'WHILE_END3'
// Translated: Math$div$WHILE_END3
Math$div$WHILE_END3:
// push local 5
LXI B,FFF6
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
// pop local 5
LXI B,FFF6
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP5'
// Translated: Math$div$WHILE_EXP5
Math$div$WHILE_EXP5:
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
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// gt (inequality # 82)
POP B
POP H
MOV A,B
CMP H
JC VM$true82
MOV A,C
CMP L
JC VM$true82
LXI D,0000
JMP VM$end82
VM$true82:
LXI D,FFFF
VM$end82:
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
// if-goto 'WHILE_END5'
// Translated: Math$div$WHILE_END5
POP H
MOV A,H
ORA L
JNZ Math$div$WHILE_END5
// push local 2
LXI B,FFFC
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
// goto 'WHILE_EXP5'
// Translated: Math$div$WHILE_EXP5
JMP Math$div$WHILE_EXP5
// label 'WHILE_END5'
// Translated: Math$div$WHILE_END5
Math$div$WHILE_END5:
// label 'WHILE_EXP6'
// Translated: Math$div$WHILE_EXP6
Math$div$WHILE_EXP6:
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
// push local 5
LXI B,FFF6
LHLD LCL
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// lt (inequality # 83)
POP H
POP B
MOV A,B
CMP H
JC VM$true83
MOV A,C
CMP L
JC VM$true83
LXI D,0000
JMP VM$end83
VM$true83:
LXI D,FFFF
VM$end83:
PUSH D
// push local 5
LXI B,FFF6
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
XRA A
MOV A,L
CMA
RAL
MOV L,A
MOV A,H
CMA
RAL
MOV H,A
MOV C,M
INX H
MOV B,M
PUSH B
// push constant 0
LXI B,0000
PUSH B
// eq (inequality # 84)
POP B
POP H
MOV A,C
CMP L
JNZ VM$false84
MOV A,B
CMP H
JNZ VM$false84
LXI D,FFFF
JMP VM$end84
VM$false84:
LXI D,0000
VM$end84:
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
// if-goto 'WHILE_END6'
// Translated: Math$div$WHILE_END6
POP H
MOV A,H
ORA L
JNZ Math$div$WHILE_END6
// push local 2
LXI B,FFFC
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
// goto 'WHILE_EXP6'
// Translated: Math$div$WHILE_EXP6
JMP Math$div$WHILE_EXP6
// label 'WHILE_END6'
// Translated: Math$div$WHILE_END6
Math$div$WHILE_END6:
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
// push static 4
// Translated: Math$4
LHLD Math$4
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
// pop local 1
LXI B,FFFE
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push static 4
// Translated: Math$4
LHLD Math$4
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
// push local 1
LXI B,FFFE
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
// push local 3
LXI B,FFFA
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
// push static 4
// Translated: Math$4
LHLD Math$4
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
// pop local 7
LXI B,FFF2
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
// push local 7
LXI B,FFF2
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
// pop local 7
LXI B,FFF2
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
// push local 7
LXI B,FFF2
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
// pop local 3
LXI B,FFFA
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
// push static 4
// Translated: Math$4
LHLD Math$4
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
// pop local 7
LXI B,FFF2
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
// push local 3
LXI B,FFFA
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
// push static 4
// Translated: Math$4
LHLD Math$4
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
// push static 4
// Translated: Math$4
LHLD Math$4
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
// label 'WHILE_EXP1'
// Translated: Math$ln$WHILE_EXP1
Math$ln$WHILE_EXP1:
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
// push static 5
// Translated: Math$5
LHLD Math$5
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
// pop local 7
LXI B,FFF2
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
// push local 7
LXI B,FFF2
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
// pop local 7
LXI B,FFF2
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
// push local 7
LXI B,FFF2
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
// pop local 0
LXI B,0000
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
// push local 0
LXI B,0000
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
// push local 5
LXI B,FFF6
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
// pop local 7
LXI B,FFF2
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
// push local 7
LXI B,FFF2
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
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// push static 4
// Translated: Math$4
LHLD Math$4
PUSH H
// push local 3
LXI B,FFFA
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
// label 'IF_FALSE0'
// Translated: Math$pow$IF_FALSE0
Math$pow$IF_FALSE0:
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
// push static 4
// Translated: Math$4
LHLD Math$4
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
// push argument 1
LXI B,FFFE
LHLD ARG
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
// push static 4
// Translated: Math$4
LHLD Math$4
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
// label 'IF_FALSE5'
// Translated: Math$pow$IF_FALSE5
Math$pow$IF_FALSE5:
// push static 4
// Translated: Math$4
LHLD Math$4
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
// push static 4
// Translated: Math$4
LHLD Math$4
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
// push local 3
LXI B,FFFA
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
// push local 1
LXI B,FFFE
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
// push local 2
LXI B,FFFC
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
// function 'Math$nroot':2
// Translated: Math$nroot
Math$nroot:
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
// if-goto 'IF_TRUE0'
// Translated: Math$nroot$IF_TRUE0
POP H
MOV A,H
ORA L
JNZ Math$nroot$IF_TRUE0
// goto 'IF_FALSE0'
// Translated: Math$nroot$IF_FALSE0
JMP Math$nroot$IF_FALSE0
// label 'IF_TRUE0'
// Translated: Math$nroot$IF_TRUE0
Math$nroot$IF_TRUE0:
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
// push argument 1
LXI B,FFFE
LHLD ARG
DAD B
MOV C,M
INX H
MOV B,M
PUSH B
// call 'Math$nroot':2
LXI H,0002
DAD SP
PUSH H
XCHG
CALL Math$nroot
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
// push static 4
// Translated: Math$4
LHLD Math$4
PUSH H
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
// Translated: Math$nroot$IF_FALSE0
Math$nroot$IF_FALSE0:
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
// Translated: Math$nroot$IF_TRUE1
POP H
MOV A,H
ORA L
JNZ Math$nroot$IF_TRUE1
// goto 'IF_FALSE1'
// Translated: Math$nroot$IF_FALSE1
JMP Math$nroot$IF_FALSE1
// label 'IF_TRUE1'
// Translated: Math$nroot$IF_TRUE1
Math$nroot$IF_TRUE1:
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
// Translated: Math$nroot$IF_FALSE1
Math$nroot$IF_FALSE1:
// push argument 0
LXI B,0000
LHLD ARG
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
// if-goto 'IF_TRUE2'
// Translated: Math$nroot$IF_TRUE2
POP H
MOV A,H
ORA L
JNZ Math$nroot$IF_TRUE2
// goto 'IF_FALSE2'
// Translated: Math$nroot$IF_FALSE2
JMP Math$nroot$IF_FALSE2
// label 'IF_TRUE2'
// Translated: Math$nroot$IF_TRUE2
Math$nroot$IF_TRUE2:
// push static 4
// Translated: Math$4
LHLD Math$4
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
// Translated: Math$nroot$IF_FALSE2
Math$nroot$IF_FALSE2:
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
// Translated: Math$nroot$IF_TRUE3
POP H
MOV A,H
ORA L
JNZ Math$nroot$IF_TRUE3
// goto 'IF_FALSE3'
// Translated: Math$nroot$IF_FALSE3
JMP Math$nroot$IF_FALSE3
// label 'IF_TRUE3'
// Translated: Math$nroot$IF_TRUE3
Math$nroot$IF_TRUE3:
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
// label 'IF_FALSE3'
// Translated: Math$nroot$IF_FALSE3
Math$nroot$IF_FALSE3:
// push argument 1
LXI B,FFFE
LHLD ARG
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
// if-goto 'IF_TRUE4'
// Translated: Math$nroot$IF_TRUE4
POP H
MOV A,H
ORA L
JNZ Math$nroot$IF_TRUE4
// goto 'IF_FALSE4'
// Translated: Math$nroot$IF_FALSE4
JMP Math$nroot$IF_FALSE4
// label 'IF_TRUE4'
// Translated: Math$nroot$IF_TRUE4
Math$nroot$IF_TRUE4:
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
// label 'IF_FALSE4'
// Translated: Math$nroot$IF_FALSE4
Math$nroot$IF_FALSE4:
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
// Translated: Math$sin$IF_FALSE0
Math$sin$IF_FALSE0:
// push static 0
// Translated: Math$0
LHLD Math$0
PUSH H
// push static 5
// Translated: Math$5
LHLD Math$5
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
// function 'Math$cos':6
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
// push static 0
// Translated: Math$0
LHLD Math$0
PUSH H
// push static 5
// Translated: Math$5
LHLD Math$5
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
// goto 'WHILE_EXP0'
// Translated: Math$cos$WHILE_EXP0
JMP Math$cos$WHILE_EXP0
// label 'WHILE_END0'
// Translated: Math$cos$WHILE_END0
Math$cos$WHILE_END0:
// label 'WHILE_EXP1'
// Translated: Math$cos$WHILE_EXP1
Math$cos$WHILE_EXP1:
// push static 3
// Translated: Math$3
LHLD Math$3
PUSH H
// push local 1
LXI B,FFFE
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
// Translated: Math$cos$WHILE_EXP1
JMP Math$cos$WHILE_EXP1
// label 'WHILE_END1'
// Translated: Math$cos$WHILE_END1
Math$cos$WHILE_END1:
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
// push static 4
// Translated: Math$4
LHLD Math$4
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
// push local 1
LXI B,FFFE
LHLD LCL
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
// push static 4
// Translated: Math$4
LHLD Math$4
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
// push static 4
// Translated: Math$4
LHLD Math$4
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
// push static 4
// Translated: Math$4
LHLD Math$4
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
// push static 4
// Translated: Math$4
LHLD Math$4
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
// pop local 3
LXI B,FFFA
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// label 'WHILE_EXP2'
// Translated: Math$cos$WHILE_EXP2
Math$cos$WHILE_EXP2:
// push local 3
LXI B,FFFA
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
// if-goto 'WHILE_END2'
// Translated: Math$cos$WHILE_END2
POP H
MOV A,H
ORA L
JNZ Math$cos$WHILE_END2
// push local 1
LXI B,FFFE
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
// pop local 2
LXI B,FFFC
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
// push local 2
LXI B,FFFC
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
// push local 2
LXI B,FFFC
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
// pop local 2
LXI B,FFFC
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
// push local 2
LXI B,FFFC
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
// pop local 0
LXI B,0000
LHLD LCL
DAD B
POP B
MOV M,C
INX H
MOV M,B
// goto 'WHILE_EXP2'
// Translated: Math$cos$WHILE_EXP2
JMP Math$cos$WHILE_EXP2
// label 'WHILE_END2'
// Translated: Math$cos$WHILE_END2
Math$cos$WHILE_END2:
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
