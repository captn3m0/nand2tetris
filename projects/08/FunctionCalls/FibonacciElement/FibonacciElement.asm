@256 // init starts
D=A
@SP
M=D // initialized SP to 256
@300
D=A
@LCL
M=D // initialized @LCL to 300
@400
D=A
@ARG
M=D // initialized @ARG to 400, init ends
@Sys.init
0;JMP
(Main.fibonacci) // function Main.fibonacci 0
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 0 (L1)
@2 // push constant 2
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 2 (L2)
@SP // ==== lt ====
A=M-1
D=M
A=A-1
D=M-D
M=0
M=M-1
@43
D;JLT
@SP
A=M-1
A=A-1
M=0
@SP
M=M-1 // end lt (L3)
@SP
AM=M-1
D=M
@Main.fibonacciIF_TRUE
D;JNE // end if-goto IF_TRUE (L4)
@Main.fibonacciIF_FALSE
0;JMP // end goto IF_FALSE (L5)
(Main.fibonacciIF_TRUE) // end label IF_TRUE (L6)
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 0 (L7)
@SP
A=M-1
D=M
@ARG
A=M
M=D
@ARG
D=M+1
@SP
M=D // @SP = ARG+1
@LCL
D=M
@R13
M=D // Save LCL to R13
A=D-1 // A=*LCL-1
D=M // D=*(*LCL-1)
@THAT // A=THAT
M=D   // *that = *(*lcl-1)
@R13
A=M-1
A=A-1 // A=*LCL-2
D=M // D=*(*LCL-2)
@THIS // A=THIS
M=D   // *THIS = *(*lcl-2)
@R13
A=M-1
A=A-1
A=A-1 // A=*LCL-3
D=M // D=*(*LCL-3)
@ARG // A=ARG
M=D   // *ARG = *(*lcl-3)
@R13
A=M-1
A=A-1
A=A-1
A=A-1 // A=*LCL-4
D=M // D=*(*LCL-4)
@LCL // A=LCL
M=D   // *LCL = *(*lcl-4)
@R13
A=M-1
A=A-1
A=A-1
A=A-1
A=A-1 // A=*LCL-5
A=M  // A=*(*LCL-5)
0;JMP // Jump to *(LCL-5)
(Main.fibonacciIF_FALSE) // end label IF_FALSE (L9)
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 0 (L10)
@2 // push constant 2
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 2 (L11)
@SP // ==== sub ====
A=M-1
D=M
A=A-1
M=M-D
@SP
M=M-1 // end sub (L12)
@5fd25fdab54b4bfd5a91536ecfd6806e
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL // Read @LCL to A
D=M // Put @LCL to D
@SP
A=M
M=D // Save @LCL to SP
@SP
M=M+1
@ARG // Read @ARG to A
D=M // Put @ARG to D
@SP
A=M
M=D // Save @ARG to SP
@SP
M=M+1
@THIS // Read @THIS to A
D=M // Put @THIS to D
@SP
A=M
M=D // Save @THIS to SP
@SP
M=M+1
@THAT // Read @THAT to A
D=M // Put @THAT to D
@SP
A=M
M=D // Save @THAT to SP
@SP
M=M+1
@SP
D=M
@LCL
M=D
D=D-1
D=D-1
D=D-1
D=D-1
D=D-1
D=D-1
@ARG
M=D
@Main.fibonacci // Jump to Main.fibonacci
0;JMP
(5fd25fdab54b4bfd5a91536ecfd6806e) // return back from function here
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1 // end push argument 0 (L14)
@1 // push constant 1
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 1 (L15)
@SP // ==== sub ====
A=M-1
D=M
A=A-1
M=M-D
@SP
M=M-1 // end sub (L16)
@a954c9cff71cdccc09f4338e60df6394
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL // Read @LCL to A
D=M // Put @LCL to D
@SP
A=M
M=D // Save @LCL to SP
@SP
M=M+1
@ARG // Read @ARG to A
D=M // Put @ARG to D
@SP
A=M
M=D // Save @ARG to SP
@SP
M=M+1
@THIS // Read @THIS to A
D=M // Put @THIS to D
@SP
A=M
M=D // Save @THIS to SP
@SP
M=M+1
@THAT // Read @THAT to A
D=M // Put @THAT to D
@SP
A=M
M=D // Save @THAT to SP
@SP
M=M+1
@SP
D=M
@LCL
M=D
D=D-1
D=D-1
D=D-1
D=D-1
D=D-1
D=D-1
@ARG
M=D
@Main.fibonacci // Jump to Main.fibonacci
0;JMP
(a954c9cff71cdccc09f4338e60df6394) // return back from function here
@SP // ==== add ====
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1 // end add (L18)
@SP
A=M-1
D=M
@ARG
A=M
M=D
@ARG
D=M+1
@SP
M=D // @SP = ARG+1
@LCL
D=M
@R13
M=D // Save LCL to R13
A=D-1 // A=*LCL-1
D=M // D=*(*LCL-1)
@THAT // A=THAT
M=D   // *that = *(*lcl-1)
@R13
A=M-1
A=A-1 // A=*LCL-2
D=M // D=*(*LCL-2)
@THIS // A=THIS
M=D   // *THIS = *(*lcl-2)
@R13
A=M-1
A=A-1
A=A-1 // A=*LCL-3
D=M // D=*(*LCL-3)
@ARG // A=ARG
M=D   // *ARG = *(*lcl-3)
@R13
A=M-1
A=A-1
A=A-1
A=A-1 // A=*LCL-4
D=M // D=*(*LCL-4)
@LCL // A=LCL
M=D   // *LCL = *(*lcl-4)
@R13
A=M-1
A=A-1
A=A-1
A=A-1
A=A-1 // A=*LCL-5
A=M  // A=*(*LCL-5)
0;JMP // Jump to *(LCL-5)
(Sys.init) // function Sys.init 0
@4 // push constant 4
D=A
@SP
A=M
M=D
@SP
M=M+1 // end push constant 4 (L21)
@dd19df789547baebfea110998cdf5713
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL // Read @LCL to A
D=M // Put @LCL to D
@SP
A=M
M=D // Save @LCL to SP
@SP
M=M+1
@ARG // Read @ARG to A
D=M // Put @ARG to D
@SP
A=M
M=D // Save @ARG to SP
@SP
M=M+1
@THIS // Read @THIS to A
D=M // Put @THIS to D
@SP
A=M
M=D // Save @THIS to SP
@SP
M=M+1
@THAT // Read @THAT to A
D=M // Put @THAT to D
@SP
A=M
M=D // Save @THAT to SP
@SP
M=M+1
@SP
D=M
@LCL
M=D
D=D-1
D=D-1
D=D-1
D=D-1
D=D-1
D=D-1
@ARG
M=D
@Main.fibonacci // Jump to Main.fibonacci
0;JMP
(dd19df789547baebfea110998cdf5713) // return back from function here
(Sys.initWHILE) // end label WHILE (L23)
@Sys.initWHILE
0;JMP // end goto WHILE (L24)
@369
0;JMP
