(SimpleFunction.test) // function SimpleFunction.test 2
@SP
A=M
M=D
@SP
M=M+1
@SP
A=M
M=D
@SP
M=M+1
@LCL
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push local 0 (L1)
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
M=M+1 // end push local 1 (L2)
@SP // ==== add ====
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1 // end add (L3)
@SP // ==== not ====
A=M-1
D=M
M=!M // end not (L4)
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 0 (L5)
@SP // ==== add ====
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1 // end add (L6)
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
M=M+1 // end push argument 1 (L7)
@SP // ==== sub ====
A=M-1
D=M
A=A-1
M=M-D
@SP
M=M-1 // end sub (L8)
@SP
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
M=D // Save LCL to R13
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
A=M  // A=*(*LCL-5)
0;JMP // Jump to *(LCL-5)
@128
0;JMP
