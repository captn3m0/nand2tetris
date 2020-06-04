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
@LCL
A=M // Read @LCL to A (for local 0)
M=D // end pop local 0
(__GLOBAL__.LOOP_START) // end label LOOP_START
@ARG
A=M
D=M
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
@LCL
A=M // Read @LCL to A (for local 0)
M=D // end pop local 0
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
@__GLOBAL__.LOOP_START
D;JNE // end if-goto LOOP_START
@LCL
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
@92
0;JMP
