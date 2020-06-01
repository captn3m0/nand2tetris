// push constant 7
@7
D=A
@SP
A=M
M=D
A=A+1
D=A
@SP
M=D
// end push constant 7
// push constant 8
@8
D=A
@SP
A=M
M=D
A=A+1
D=A
@SP
M=D
// end push constant 8
// ==== add ====
// pop starts
@SP
A=M
A=A-1
D=M
// pop ends
// inner add starts
A=A-1
D=D+M
// inner add ends
M=D
A=A+1
D=A
@SP
M=D
// ==== add ====
