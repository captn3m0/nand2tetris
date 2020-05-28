@i
M=255

@j
M=32

@i
D=M
@OUTERLOOPENDS
D;JEQ

// Set j=0
@j
M=0

@j
D=M
@INNERLOOPENDS
D;JEQ

// INNER LOOP

// Set R0=i
@i
D=M
@R0
M=D

// Set R1=32
@32
D=A
@R1
M=D

@after_multiply
0;JMP

(after_multiply)


// INNER LOOP


(INNERLOOPENDS)

@i
M=M-1

(OUTERLOOPENDS)

// SET A to return address
// Multiplies R0 with R1 and sets it to R2
(MULTIPLY_WITH_32)
// Save return address to R3
D=A
@R3
M=D

@R2
M=0

// Put your code here.
(MLOOP)

@R0
D=M
// Jump to end if R0 = 0
@END
D;JEQ

@R2
D=M

@R1
// Increase D by R1
D=D+M

// Save final value back to result

@R2
M=D

// R0=R0-1
@R0
M=M-1

// Otherwise, go to loop
@LOOP
0;JMP

// AFTER we're done
// We do an unconditional jump to A
@R3
0;JMP
