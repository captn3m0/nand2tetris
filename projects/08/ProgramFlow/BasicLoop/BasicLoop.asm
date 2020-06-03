@0 // push constant 0
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 0 (L0)
@SP // pop
AM=M-1
D=M
@LCL
A=M // Read @LCL to A (for local 0)
M=D // end pop local 0 (L1)
(__GLOBAL__.LOOP_START) // end label LOOP_START (L2)
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 0 (L3)
@LCL
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push local 0 (L4)
@SP // ==== add ====
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1 // end add (L5)
@SP // pop
AM=M-1
D=M
@LCL
A=M // Read @LCL to A (for local 0)
M=D // end pop local 0 (L6)
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 0 (L7)
@1 // push constant 1
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 1 (L8)
@SP // ==== sub ====
A=M-1
D=M
A=A-1
M=M-D
@SP
M=M-1 // end sub (L9)
@SP // pop
AM=M-1
D=M
@ARG
A=M // Read @ARG to A (for argument 0)
M=D // end pop argument 0 (L10)
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
@__GLOBAL__.LOOP_START
D;JNE // end if-goto LOOP_START (L12)
@LCL
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push local 0 (L13)
@93
0;JMP
