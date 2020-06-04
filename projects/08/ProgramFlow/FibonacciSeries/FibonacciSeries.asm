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
M=M+1
@SP // pop
AM=M-1
D=M
@THAT
M=D //
@0 // push constant 0
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
A=M // Read @THAT to A (for that 0)
M=D // end pop that 0
@1 // push constant 1
D=A
@SP
A=M
M=D
@SP
M=M+1
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
M=D // end pop that 1
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
@2 // push constant 2
D=A
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
@SP // pop
AM=M-1
D=M
@ARG
A=M // Read @ARG to A (for argument 0)
M=D // end pop argument 0
(__GLOBAL__.MAIN_LOOP_START) // end label MAIN_LOOP_START
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP
AM=M-1
D=M
@__GLOBAL__.COMPUTE_ELEMENT
D;JNE // end if-goto COMPUTE_ELEMENT
@__GLOBAL__.END_PROGRAM
0;JMP // end goto END_PROGRAM
(__GLOBAL__.COMPUTE_ELEMENT) // end label COMPUTE_ELEMENT
@THAT
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT // that 1
D=M
@1 // write 1 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @THAT+1 to R13
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
M=D // end pop that 2
@THAT // pointer 1
D=M
@SP
A=M
M=D
@SP
M=M+1
@1 // push constant 1
D=A
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
@SP // pop
AM=M-1
D=M
@THAT
M=D //
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
@1 // push constant 1
D=A
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
@SP // pop
AM=M-1
D=M
@ARG
A=M // Read @ARG to A (for argument 0)
M=D // end pop argument 0
@__GLOBAL__.MAIN_LOOP_START
0;JMP // end goto MAIN_LOOP_START
(__GLOBAL__.END_PROGRAM) // end label END_PROGRAM
@192
0;JMP
