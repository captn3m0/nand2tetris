@99 // push constant 99
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 99 (L0)
@98 // push constant 98
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 98 (L1)
@97 // push constant 97
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 97 (L2)
@96 // push constant 96
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 96 (L3)
@95 // push constant 95
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 95 (L4)
@94 // push constant 94
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 94 (L5)
@93 // push constant 93
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 93 (L6)
@92 // push constant 92
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 92 (L7)
@91 // push constant 91
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 91 (L8)
@SP // pop
AM=M-1
D=M
@LCL
A=M // Read @LCL to A (for local 0)
M=D // end pop local 0 (L9)
@LCL // local 1
D=M
@1 // write 1 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+1 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for local 1)
M=D // end pop local 1 (L10)
@LCL // local 2
D=M
@2 // write 2 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+2 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for local 2)
M=D // end pop local 2 (L11)
@LCL // local 3
D=M
@3 // write 3 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+3 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for local 3)
M=D // end pop local 3 (L12)
@LCL // local 4
D=M
@4 // write 4 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+4 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for local 4)
M=D // end pop local 4 (L13)
@LCL // local 5
D=M
@5 // write 5 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+5 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for local 5)
M=D // end pop local 5 (L14)
@LCL // local 6
D=M
@6 // write 6 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+6 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for local 6)
M=D // end pop local 6 (L15)
@LCL // local 7
D=M
@7 // write 7 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+7 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for local 7)
M=D // end pop local 7 (L16)
@LCL // local 8
D=M
@8 // write 8 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+8 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for local 8)
M=D // end pop local 8 (L17)
@LCL // local 8
D=M
@8 // write 8 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+8 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push local 8 (L18)
@LCL // local 7
D=M
@7 // write 7 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+7 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push local 7 (L19)
@LCL // local 6
D=M
@6 // write 6 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+6 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push local 6 (L20)
@LCL // local 5
D=M
@5 // write 5 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+5 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push local 5 (L21)
@LCL // local 4
D=M
@4 // write 4 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+4 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push local 4 (L22)
@LCL // local 3
D=M
@3 // write 3 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+3 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push local 3 (L23)
@LCL // local 2
D=M
@2 // write 2 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+2 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push local 2 (L24)
@LCL // local 1
D=M
@1 // write 1 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+1 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push local 1 (L25)
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push local 0 (L26)
@SP // pop
AM=M-1
D=M
@ARG
A=M // Read @ARG to A (for argument 0)
M=D // end pop argument 0 (L27)
@ARG // argument 1
D=M
@1 // write 1 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+1 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for argument 1)
M=D // end pop argument 1 (L28)
@ARG // argument 2
D=M
@2 // write 2 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+2 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for argument 2)
M=D // end pop argument 2 (L29)
@ARG // argument 3
D=M
@3 // write 3 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+3 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for argument 3)
M=D // end pop argument 3 (L30)
@ARG // argument 4
D=M
@4 // write 4 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+4 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for argument 4)
M=D // end pop argument 4 (L31)
@ARG // argument 5
D=M
@5 // write 5 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+5 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for argument 5)
M=D // end pop argument 5 (L32)
@ARG // argument 6
D=M
@6 // write 6 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+6 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for argument 6)
M=D // end pop argument 6 (L33)
@ARG // argument 7
D=M
@7 // write 7 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+7 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for argument 7)
M=D // end pop argument 7 (L34)
@ARG // argument 8
D=M
@8 // write 8 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+8 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for argument 8)
M=D // end pop argument 8 (L35)
@ARG // argument 8
D=M
@8 // write 8 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+8 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 8 (L36)
@ARG // argument 7
D=M
@7 // write 7 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+7 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 7 (L37)
@ARG // argument 6
D=M
@6 // write 6 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+6 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 6 (L38)
@ARG // argument 5
D=M
@5 // write 5 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+5 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 5 (L39)
@ARG // argument 4
D=M
@4 // write 4 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+4 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 4 (L40)
@ARG // argument 3
D=M
@3 // write 3 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+3 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 3 (L41)
@ARG // argument 2
D=M
@2 // write 2 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+2 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 2 (L42)
@ARG // argument 1
D=M
@1 // write 1 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+1 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 1 (L43)
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 0 (L44)
@SP // pop
AM=M-1
D=M
@THIS
A=M // Read @THIS to A (for this 0)
M=D // end pop this 0 (L45)
@THIS // this 1
D=M
@1 // write 1 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+1 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for this 1)
M=D // end pop this 1 (L46)
@THIS // this 2
D=M
@2 // write 2 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+2 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for this 2)
M=D // end pop this 2 (L47)
@THIS // this 3
D=M
@3 // write 3 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+3 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for this 3)
M=D // end pop this 3 (L48)
@THIS // this 4
D=M
@4 // write 4 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+4 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for this 4)
M=D // end pop this 4 (L49)
@THIS // this 5
D=M
@5 // write 5 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+5 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for this 5)
M=D // end pop this 5 (L50)
@THIS // this 6
D=M
@6 // write 6 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+6 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for this 6)
M=D // end pop this 6 (L51)
@THIS // this 7
D=M
@7 // write 7 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+7 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for this 7)
M=D // end pop this 7 (L52)
@THIS // this 8
D=M
@8 // write 8 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+8 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for this 8)
M=D // end pop this 8 (L53)
@THIS // this 8
D=M
@8 // write 8 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+8 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push this 8 (L54)
@THIS // this 7
D=M
@7 // write 7 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+7 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push this 7 (L55)
@THIS // this 6
D=M
@6 // write 6 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+6 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push this 6 (L56)
@THIS // this 5
D=M
@5 // write 5 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+5 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push this 5 (L57)
@THIS // this 4
D=M
@4 // write 4 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+4 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push this 4 (L58)
@THIS // this 3
D=M
@3 // write 3 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+3 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push this 3 (L59)
@THIS // this 2
D=M
@2 // write 2 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+2 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push this 2 (L60)
@THIS // this 1
D=M
@1 // write 1 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+1 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push this 1 (L61)
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push this 0 (L62)
@SP // pop
AM=M-1
D=M
@THAT
A=M // Read @THAT to A (for that 0)
M=D // end pop that 0 (L63)
@THAT // that 1
D=M
@1 // write 1 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+1 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for that 1)
M=D // end pop that 1 (L64)
@THAT // that 2
D=M
@2 // write 2 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+2 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for that 2)
M=D // end pop that 2 (L65)
@THAT // that 3
D=M
@3 // write 3 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+3 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for that 3)
M=D // end pop that 3 (L66)
@THAT // that 4
D=M
@4 // write 4 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+4 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for that 4)
M=D // end pop that 4 (L67)
@THAT // that 5
D=M
@5 // write 5 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+5 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for that 5)
M=D // end pop that 5 (L68)
@THAT // that 6
D=M
@6 // write 6 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+6 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for that 6)
M=D // end pop that 6 (L69)
@THAT // that 7
D=M
@7 // write 7 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+7 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for that 7)
M=D // end pop that 7 (L70)
@THAT // that 8
D=M
@8 // write 8 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+8 to R13
@SP // pop
AM=M-1
D=M
@R13
A=M // Read @R13 to A (for that 8)
M=D // end pop that 8 (L71)
@THAT // that 8
D=M
@8 // write 8 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+8 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push that 8 (L72)
@THAT // that 7
D=M
@7 // write 7 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+7 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push that 7 (L73)
@THAT // that 6
D=M
@6 // write 6 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+6 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push that 6 (L74)
@THAT // that 5
D=M
@5 // write 5 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+5 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push that 5 (L75)
@THAT // that 4
D=M
@4 // write 4 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+4 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push that 4 (L76)
@THAT // that 3
D=M
@3 // write 3 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+3 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push that 3 (L77)
@THAT // that 2
D=M
@2 // write 2 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+2 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push that 2 (L78)
@THAT // that 1
D=M
@1 // write 1 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+1 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push that 1 (L79)
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push that 0 (L80)
@916
0;JMP
