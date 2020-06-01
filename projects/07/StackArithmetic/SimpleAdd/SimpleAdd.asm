// push constant 7
@7
D=A
@SP
A=M
M=D
@SP
M=M+1
// end push constant 7
// push constant 8
@8
D=A
@SP
A=M
M=D
@SP
M=M+1
// end push constant 8
// ==== add ====
// pop starts
@SP
A=M-1
D=M
// pop ends
// inner add starts
A=A-1
M=D+M
@SP
M=M-1
