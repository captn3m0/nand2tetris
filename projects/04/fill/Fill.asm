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

// Set i to 255
@255
D=A
@i
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

// This is adapted from manual-fill.asm


// coloring code goes here


@color
D=M

@SCREEN
M=D


// Keyboard Loop ending

// Reduce i by 1
@i
M=M-1

// Jump to ENDIF if @i>0
@i
D=M
@ENDIF
D;JGT

// Here i==0, so we reset it to 255
@255
D=A
@i
M=D

(ENDIF)


@KEYBOARD_LOOP
0;JMP


// @WRITE_COMPLETE_ROW
// 0;JMP

(END)
@END
0;JMP
