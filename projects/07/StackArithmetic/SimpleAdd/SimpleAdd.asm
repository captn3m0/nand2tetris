@7 // push constant 7 				// (L0:0)
D=A 				// (L0:1)
@SP 				// (L0:2)
A=M 				// (L0:3)
M=D 				// (L0:4)
@SP 				// (L0:5)
M=M+1 				// (L0:6)
@8 // push constant 8 				// (L1:7)
D=A 				// (L1:8)
@SP 				// (L1:9)
A=M 				// (L1:10)
M=D 				// (L1:11)
@SP 				// (L1:12)
M=M+1 				// (L1:13)
@SP // ==== add ==== 				// (L2:14)
A=M-1 				// (L2:15)
D=M 				// (L2:16)
A=A-1 				// (L2:17)
M=D+M 				// (L2:18)
@SP 				// (L2:19)
M=M-1 // end add 				// (L2:20)
@22 				// (L3:21)
0;JMP 				// (L3:22)
