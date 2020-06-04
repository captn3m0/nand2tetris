(SimpleFunction.test) // function SimpleFunction.test 2
@SP
A=M
M=0
@SP
AM=M+1
M=0
@SP
AM=M+1
@LCL
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
@LCL // local 1
D=M
@1 // write 1 to A
D=D+A // D = segment+index
@R13 // save it to R13
M=D // write @LCL+1 to R13
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
@SP // ==== not ====
A=M-1
D=M
M=!M // end not
@ARG
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
@SP // ==== sub ====
A=M-1
D=M
A=A-1
M=M-D
@SP
M=M-1 // end sub
@SP // return for SimpleFunction.test starts
A=M-1
D=M
@ARG
A=M
M=D
@ARG
D=M+1
@SP
M=D // @SP = ARG+1
@LCL
D=M
@R13
M=D // Save LCL to R13 = FRAME
A=D-1 // A=*LCL-1
D=M // D=*(*LCL-1)
@THAT // A=THAT
M=D   // *that = *(*lcl-1)
@R13
A=M-1
A=A-1 // A=*LCL-2
D=M // D=*(*LCL-2)
@THIS // A=THIS
M=D   // *THIS = *(*lcl-2)
@R13
A=M-1
A=A-1
A=A-1 // A=*LCL-3
D=M // D=*(*LCL-3)
@ARG // A=ARG
M=D   // *ARG = *(*lcl-3)
@R13
A=M-1
A=A-1
A=A-1
A=A-1 // A=*LCL-4
D=M // D=*(*LCL-4)
@LCL // A=LCL
M=D   // *LCL = *(*lcl-4)
@R13
A=M-1
A=A-1
A=A-1
A=A-1
A=A-1 // A=*LCL-5
A=M  // A now holds the return address
0;JMP // HyperJump to *(LCL-5)
@125
0;JMP
