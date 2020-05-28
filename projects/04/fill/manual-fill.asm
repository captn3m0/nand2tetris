// This program does a manual fill for the entire screen
// Loops over all rows (255) and calls
// a screen write operation 32 times for each row
// each row has 512 pixels = 16 * 32 bits = 32 registers
// so each row takes 32 memory addresses in the RAM, starting from @SCREEN

// The program uses the following:
// @i : A counter that goes from 255->0
//    : program ends when it reaches 0
//    : this keeps track of how many rows have we covered

// @R0: This stores the address of the first memory address for the
//    : row of the screen that we are filling right now
//    : Initialized by setting it to @SCREEN

// @color: Stores -1, since we can't use that as a constant.
//       : Copied to D register before being written to screen
@0
D=A
D=D-1
@color
M=D
// Now color holds -1

// Set counter to 255
@255
D=A
@i
M=D

// Store our initial screen row address in D
@SCREEN
D=A
// And then save it in R0
@R0
M=D

// This is our screen/row writing loop
(WRITE_COMPLETE_ROW)
// Read color in D
@color
D=M
// Load the value in R0 to A
@R0
A=M
// And off we go hunting
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D
A=A+1
M=D

// Bump A by 1 and write it to R0
A=A+1
D=A
@R0
M=D

// Reduce i by 1
@i
M=M-1

// Jump to ENDIF if @i>0
@i
D=M
@ENDIF
D;JGT

// If i==0, jump to end
@END
0;JMP
(ENDIF)

@WRITE_COMPLETE_ROW
0;JMP

(END)
@END
0;JMP
