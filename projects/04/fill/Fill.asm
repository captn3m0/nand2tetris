// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// See NOTES.md for details on how this works

(PROGRAM_START)
// Set R0 to SCREEN
@SCREEN
D=A
@R0
M=D

(KEYBOARD_LOOP)

// Read the Keyboard and set color
@color
M=0
@KBD
D=M
@ENDKBDIF
D;JEQ
// If keyboard is pressed
@0
D=A
D=D-1
@color
M=D
(ENDKBDIF)

// At this point @color = 0|-1 depending on whether a key is pressed

// coloring code goes here

// Read color to D

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

// Keyboard Loop ending

// Bump A by 1 and write it to R0
A=A+1
D=A
@R0
M=D

// If R0-24575 <= 0, then jump to program start
@24575
D=A
@R0
D=M-D // (D=R0-24575)
@ENDIF
D;JLE

// Here, R1 is negative
// set R0=@SCREEN and let the loop continue
@SCREEN
D=A
@R0
M=D


(ENDIF)

// OTHERWISE, we just restart the keyboard loop
@KEYBOARD_LOOP
0;JMP
