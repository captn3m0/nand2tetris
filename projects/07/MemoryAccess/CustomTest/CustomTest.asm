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
@SP // pop
AM=M-1
D=M
@THIS
A=M // Read @THIS to A (for this 0)
M=D // end pop this 0 (L10)
@SP // pop
AM=M-1
D=M
@THAT
A=M // Read @THAT to A (for that 0)
M=D // end pop that 0 (L11)
@SP // pop
AM=M-1
D=M
@ARG
A=M // Read @ARG to A (for argument 0)
M=D // end pop argument 0 (L12)
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
M=D // end pop local 1 (L13)
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
M=D // end pop this 1 (L14)
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
M=D // end pop that 1 (L15)
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
M=D // end pop argument 1 (L16)
@136
0;JMP
