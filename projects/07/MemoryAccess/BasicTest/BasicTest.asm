@10 // push constant 10
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 10 (L0)
@SP // pop
AM=M-1
D=M
@LCL
A=M // Read @LCL to A (for local 0)
M=D // end pop local 0 (L1)
@21 // push constant 21
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 21 (L2)
@22 // push constant 22
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 22 (L3)
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
M=D // end pop argument 2 (L4)
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
M=D // end pop argument 1 (L5)
@36 // push constant 36
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 36 (L6)
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
M=D // end pop this 6 (L7)
@42 // push constant 42
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 42 (L8)
@45 // push constant 45
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 45 (L9)
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
M=D // end pop that 5 (L10)
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
M=D // end pop that 2 (L11)
@510 // push constant 510
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 510 (L12)
@SP
AM=M-1
D=M
@R11
M=D // end pop temp 6 (L13)
@LCL
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push local 0 (L14)
@THAT // that 5
D=M
@5 // write 5 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+5 to R13
@R13
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push that 5 (L15)
@SP // ==== add ====
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1 // end add (L16)
@ARG // argument 1
D=M
@1 // write 1 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+1 to R13
@R13
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 1 (L17)
@SP // ==== sub ====
A=M-1
D=M
A=A-1
M=M-D
@SP
M=M-1 // end sub (L18)
@THIS // this 6
D=M
@6 // write 6 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+6 to R13
@R13
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push this 6 (L19)
@THIS // this 6
D=M
@6 // write 6 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+6 to R13
@R13
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push this 6 (L20)
@SP // ==== add ====
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1 // end add (L21)
@SP // ==== sub ====
A=M-1
D=M
A=A-1
M=M-D
@SP
M=M-1 // end sub (L22)
@R11 // temp 6
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push temp 6 (L23)
@SP // ==== add ====
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1 // end add (L24)
@227
0;JMP
