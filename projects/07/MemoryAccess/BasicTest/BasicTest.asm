@10 // push constant 10
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 10
@SP // pop
A=M-1
D=M
@LCL
A=M // Read @LCL to A
M=D // Write D to *A
@21 // push constant 21
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 21
@22 // push constant 22
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 22
@ARG // argument 2
D=M
@2 // write 2 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+2 to R13
@SP // pop
A=M-1
D=M
@R13
A=M // Read @R13 to A
M=D // Write D to *A
@ARG // argument 1
D=M
@1 // write 1 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @ARG+1 to R13
@SP // pop
A=M-1
D=M
@R13
A=M // Read @R13 to A
M=D // Write D to *A
@36 // push constant 36
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 36
@THIS // this 6
D=M
@6 // write 6 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THIS+6 to R13
@SP // pop
A=M-1
D=M
@R13
A=M // Read @R13 to A
M=D // Write D to *A
@42 // push constant 42
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 42
@45 // push constant 45
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 45
@THAT // that 5
D=M
@5 // write 5 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+5 to R13
@SP // pop
A=M-1
D=M
@R13
A=M // Read @R13 to A
M=D // Write D to *A
@THAT // that 2
D=M
@2 // write 2 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+2 to R13
@SP // pop
A=M-1
D=M
@R13
A=M // Read @R13 to A
M=D // Write D to *A
@510 // push constant 510
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 510
@LCL // local 0
D=M
@0 // write 0 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+0 to R13
@R13
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push local 0
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
M=M+1 // end push that 5
@SP // ==== add ====
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1
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
M=M+1 // end push argument 1
@SP // ==== sub ====
A=M-1
D=M
A=A-1
M=M-D
@SP
M=M-1
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
M=M+1 // end push this 6
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
M=M+1 // end push this 6
@SP // ==== add ====
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1
@SP // ==== sub ====
A=M-1
D=M
A=A-1
M=M-D
@SP
M=M-1
@R11 // temp 6
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push temp 6
@SP // ==== add ====
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1
@223
0;JMP
