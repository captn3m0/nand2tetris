@3030 // push constant 3030
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP // pop
AM=M-1
D=M
@THIS
M=D //
@3040 // push constant 3040
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP // pop
AM=M-1
D=M
@THAT
M=D //
@32 // push constant 32
D=A
@SP
A=M
M=D
@SP
M=M+1
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
M=D // end pop this 2
@46 // push constant 46
D=A
@SP
A=M
M=D
@SP
M=M+1
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
M=D // end pop that 6
@THIS // pointer 0
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT // pointer 1
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP // ==== add ====
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1 // end add
@THIS // this 2
D=M
@2 // write 2 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+2 to R13
@R13
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP // ==== sub ====
A=M-1
D=M
A=A-1
M=M-D
@SP
M=M-1 // end sub
@THAT // that 6
D=M
@6 // write 6 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+6 to R13
@R13
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP // ==== add ====
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1 // end add
@126
0;JMP
