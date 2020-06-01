load CustomTest.asm,
output-file CustomTest.out,
compare-to CustomTest.cmp,
output-list RAM[20]%D0.2.0 RAM[41]%D0.2.0 RAM[61]%D0.2.0
            RAM[51]%D0.2.0 RAM[31]%D0.2.0 RAM[40]%D0.2.0
            RAM[60]%D0.2.0 RAM[50]%D0.2.0 RAM[30]%D0.2.0
            RAM[21]%D0.2.0 RAM[22]%D0.2.0 RAM[23]%D0.2.0
            RAM[24]%D0.2.0 RAM[25]%D0.2.0 RAM[26]%D0.2.0
            RAM[27]%D0.2.0 RAM[28]%D0.2.0 RAM[29]%D0.2.0,

set RAM[0] 20,   // stack pointer
set RAM[1] 30,   // base address of the local segment
set RAM[2] 40,   // base address of the argument segment
set RAM[3] 50,   // base address of the this segment
set RAM[4] 60,  // base address of the that segment

repeat 150 {      // enough cycles to complete the execution
  ticktock;
}

// Outputs the stack base and some values
// from the tested memory segments
output;
