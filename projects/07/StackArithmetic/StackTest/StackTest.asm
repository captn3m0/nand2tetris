@17 // push constant 17
D=A
@SP
A=M
M=D
@SP
M=M+1
@17 // push constant 17
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP // ==== eq ====
A=M-1
D=M
A=A-1
D=M-D
M=0
M=M-1
@27
D;JEQ
@SP
A=M-1
A=A-1
M=0
@SP
M=M-1 // end eq
@17 // push constant 17
D=A
@SP
A=M
M=D
@SP
M=M+1
@16 // push constant 16
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP // ==== eq ====
A=M-1
D=M
A=A-1
D=M-D
M=0
M=M-1
@56
D;JEQ
@SP
A=M-1
A=A-1
M=0
@SP
M=M-1 // end eq
@16 // push constant 16
D=A
@SP
A=M
M=D
@SP
M=M+1
@17 // push constant 17
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP // ==== eq ====
A=M-1
D=M
A=A-1
D=M-D
M=0
M=M-1
@85
D;JEQ
@SP
A=M-1
A=A-1
M=0
@SP
M=M-1 // end eq
@892 // push constant 892
D=A
@SP
A=M
M=D
@SP
M=M+1
@891 // push constant 891
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP // ==== lt ====
A=M-1
D=M
A=A-1
D=M-D
M=0
M=M-1
@114
D;JLT
@SP
A=M-1
A=A-1
M=0
@SP
M=M-1 // end lt
@891 // push constant 891
D=A
@SP
A=M
M=D
@SP
M=M+1
@892 // push constant 892
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP // ==== lt ====
A=M-1
D=M
A=A-1
D=M-D
M=0
M=M-1
@143
D;JLT
@SP
A=M-1
A=A-1
M=0
@SP
M=M-1 // end lt
@891 // push constant 891
D=A
@SP
A=M
M=D
@SP
M=M+1
@891 // push constant 891
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP // ==== lt ====
A=M-1
D=M
A=A-1
D=M-D
M=0
M=M-1
@172
D;JLT
@SP
A=M-1
A=A-1
M=0
@SP
M=M-1 // end lt
@32767 // push constant 32767
D=A
@SP
A=M
M=D
@SP
M=M+1
@32766 // push constant 32766
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP // ==== gt ====
A=M-1
D=M
A=A-1
D=M-D
M=0
M=M-1
@201
D;JGT
@SP
A=M-1
A=A-1
M=0
@SP
M=M-1 // end gt
@32766 // push constant 32766
D=A
@SP
A=M
M=D
@SP
M=M+1
@32767 // push constant 32767
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP // ==== gt ====
A=M-1
D=M
A=A-1
D=M-D
M=0
M=M-1
@230
D;JGT
@SP
A=M-1
A=A-1
M=0
@SP
M=M-1 // end gt
@32766 // push constant 32766
D=A
@SP
A=M
M=D
@SP
M=M+1
@32766 // push constant 32766
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP // ==== gt ====
A=M-1
D=M
A=A-1
D=M-D
M=0
M=M-1
@259
D;JGT
@SP
A=M-1
A=A-1
M=0
@SP
M=M-1 // end gt
@57 // push constant 57
D=A
@SP
A=M
M=D
@SP
M=M+1
@31 // push constant 31
D=A
@SP
A=M
M=D
@SP
M=M+1
@53 // push constant 53
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
@112 // push constant 112
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
@SP // ==== neg ====
A=M-1
D=M
M=-M // end neg
@SP // ==== and ====
A=M-1
D=M
A=A-1
M=D&M
@SP
M=M-1 // end and
@82 // push constant 82
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP // ==== or ====
A=M-1
D=M
A=A-1
M=D|M
@SP
M=M-1 // end or
@SP // ==== not ====
A=M-1
D=M
M=!M // end not
@333
0;JMP
