@111 // push constant 111
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 111 (L0)
@333 // push constant 333
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 333 (L1)
@888 // push constant 888
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 888 (L2)
@SP //pop static 8
AM=M-1
D=M
@StaticTest.8
M=D // end pop static 8 (L3)
@SP //pop static 3
AM=M-1
D=M
@StaticTest.3
M=D // end pop static 3 (L4)
@SP //pop static 1
AM=M-1
D=M
@StaticTest.1
M=D // end pop static 1 (L5)
@StaticTest.3
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push static 3 (L6)
@StaticTest.1
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push static 1 (L7)
@SP // ==== sub ====
A=M-1
D=M
A=A-1
M=M-D
@SP
M=M-1 // end sub (L8)
@StaticTest.8
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push static 8 (L9)
@SP // ==== add ====
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1 // end add (L10)
@72
0;JMP
