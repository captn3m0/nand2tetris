@i
M=1

@sum
M=0

(LOOP)

@i
D=M
@10
D=D-A
@END // refers to the instruction memory location for END label and puts that in A
D;JGT
@i
D=M

@sum
M=D+M

@i
M=M+1
@LOOP // Put the instruction memory location for LOOP in A
0;JMP // Jump to A

(END)

@sum
D=M

@R0
M=D

@END
0;JMP
