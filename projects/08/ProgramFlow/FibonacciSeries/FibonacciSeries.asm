@256 // init starts
D=A
@SP
M=D // initialized SP to 256
@300
D=A
@LCL
M=D // initialized @LCL to 300
@400
D=A
@ARG
M=D // initialized @ARG to 400, init ends
@Sys.init
0;JMP
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
M=M+1 // end push argument 1 (L0)
@SP // pop
AM=M-1
D=M
@THAT
M=D // (L1)
@0 // push constant 0
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 0 (L2)
@SP // pop
AM=M-1
D=M
@THAT
A=M // Read @THAT to A (for that 0)
M=D // end pop that 0 (L3)
@1 // push constant 1
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 1 (L4)
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
M=D // end pop that 1 (L5)
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 0 (L6)
@2 // push constant 2
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 2 (L7)
@SP // ==== sub ====
A=M-1
D=M
A=A-1
M=M-D
@SP
M=M-1 // end sub (L8)
@SP // pop
AM=M-1
D=M
@ARG
A=M // Read @ARG to A (for argument 0)
M=D // end pop argument 0 (L9)
(__GLOBAL__.MAIN_LOOP_START) // end label MAIN_LOOP_START (L10)
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 0 (L11)
@SP
AM=M-1
D=M
@__GLOBAL__.COMPUTE_ELEMENT
D;JNE // end if-goto COMPUTE_ELEMENT (L12)
@__GLOBAL__.END_PROGRAM
0;JMP // end goto END_PROGRAM (L13)
(__GLOBAL__.COMPUTE_ELEMENT) // end label COMPUTE_ELEMENT (L14)
@THAT
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push that 0 (L15)
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
M=M+1 // end push that 1 (L16)
@SP // ==== add ====
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1 // end add (L17)
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
M=D // end pop that 2 (L18)
@THAT // pointer 1
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push pointer 1 (L19)
@1 // push constant 1
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 1 (L20)
@SP // ==== add ====
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1 // end add (L21)
@SP // pop
AM=M-1
D=M
@THAT
M=D // (L22)
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 0 (L23)
@1 // push constant 1
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 1 (L24)
@SP // ==== sub ====
A=M-1
D=M
A=A-1
M=M-D
@SP
M=M-1 // end sub (L25)
@SP // pop
AM=M-1
D=M
@ARG
A=M // Read @ARG to A (for argument 0)
M=D // end pop argument 0 (L26)
@__GLOBAL__.MAIN_LOOP_START
0;JMP // end goto MAIN_LOOP_START (L27)
(__GLOBAL__.END_PROGRAM) // end label END_PROGRAM (L28)
@209
0;JMP
