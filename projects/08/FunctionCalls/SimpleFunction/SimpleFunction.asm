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
@ARG
D=M+1
@SP
M=D // @SP = ARG+1
@LCL
D=M // D=@LCL
@THAT
MD=D-1 // THAT = LCL-1
@THIS
MD=D-1 // THIS = LCL-2
@ARG
MD=D-1 // ARG  = LCL-3
@LCL
MD=D-1 // LCL = LCL-4
A=D-1 // A = LCL-5
0;JMP // Jump to *(LCL-5)
@97
0;JMP
