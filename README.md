# nand2tetris

Working my way through the [Nand to Tetris Course](https://www.nand2tetris.org/)

- Download the latest `nand2tetris.zip` from the book website, and overwrite everything in the `projects` and `tools` directory.
- Remember to run `chmod +X tools/*.sh` if you're on \*nix.

My notes are in [NOTES.md](NOTES.md).

## [Project 1: Boolean Logic](https://www.nand2tetris.org/project01)

Build order as per the website. Cost for each gate in NAND in brackets.

- [x] `Nand` (primitive)
- [x] `Not` (1)
- [x] `Or` (3)
- [x] `Xor` (6, Can be improved)
- [x] `And` (2)
- [x] `Mux` (8, Took me ages. Can be improved)
- [x] `DMux` (5, Super Fun)
- [x] `Not16` (16)
- [x] `And16` (32)
- [x] `Or16` (48)
- [x] `Mux16` (113)
- [x] `Or8Way` (21)
- [x] `Mux4Way16` (339)
- [x] `Mux8Way16` (791)
- [x] `DMux4Way` (37, Fun)
- [x] `DMux8Way` (101)

## [Project 2: Boolean Arithmetic](https://www.nand2tetris.org/project02)

CHIPs/Gates used in brackets

- [x] `HalfAdder` (Xor+And)
- [x] `FullAdder` (2 HalfAdder, 1 Or)
- [x] `Add16` (1 HalfAdder, 15 FullAdder)
- [x] `Inc16` (1 Add16)
- [x] `ALU` (6 Mux16, 3 Not16, 1 Add16, 1 And16, 2 Or8Way, 2 Or, 1 Not)

## [Project 3: Memory](https://www.nand2tetris.org/project03)

Make sure you read through the [Hardware Simulator Tutorial][s] to understand the clock in the simulator.

- [x] `DFF` (primitive)
- [x] `Bit` (1 Mux, 1DFF)
- [x] `Register` (16 Bits)
- [x] `RAM8` (8 Registers, 1 DMux8Way, 1 Mux8Way16) = 8 registers
- [x] `RAM64` (8 RAM8, 1 DMux8Way, 1 Mux8Way16) = 64 registers
- [x] `RAM512` (8 RAM64, 1 DMux8Way, 1 Mux8Way16) = 512 registers
- [x] `RAM4K` (8 RAM512, 1 DMux8Way, 1 Mux8Way16) = 4096 registers
- [x] `RAM16K` (4 RAM4K, 1 DMux4Way, 1 Mux4Way16) = 16384 registers
- [x] `PC` (1 Register, 1 Inc16, 1 Or8Way, 1 Mux8Way16)

[s]: https://b1391bd6-da3d-477d-8c01-38cdf774495a.filesusr.com/ugd/44046b_bfd91435260748439493a60a8044ade6.pdf

## [Project 4: Machine Language Programming](https://www.nand2tetris.org/project03)

Counting number of instructions by `wc -l $file.hack`

- [x] Mult (18)
- [x] Fill (98)

## [Project 5: Computer Architecture](https://www.nand2tetris.org/project05)

### Chips

- [x] `Memory.hdl` (2xMux16, 2xNot, 3xAnd 1 RAM16K)
- [x] `CPU.hdl` (6 And, 2 Nand, 3 Or, 1 Not, 1 Mux16, 1 Mux16, 2 Register, 1 PC, 1 ALU)
- [x] `Computer.hdl` (1 CPU, 1 ROM32K, 1 Memory)

### Computer chip tests:

- [x] `Add.hack`
- [x] `Max.hack`
- [x] `Rect.hack`

## [Project 6: The Assembler](https://www.nand2tetris.org/project06)

### Without Symbols

- [x] `MaxL.asm`
- [x] `RectL.asm`
- [x] `PongL.asm`
- [x] `Add.asm`

### Symbolic Programs

- [x] `Max.asm`
- [x] `Rect.asm`
- [x] `Pong.asm`

## [Project 7: Virtual Machine I - Stack Arithmetic](https://www.nand2tetris.org/project07)

Final hack instruction set count in brackets. Calculated by running:

```bash
php file.vm > file.asm
ruby assembler.rb file.vm > file.hack
wc -l file.hack
```

### Arithmetic Commands

- [x] `SimpleAdd.vm` (21)
- [x] `StackTest.vm` (334)

### Memory Access Commands

- [x] `BasicTest.vm` (228)
- [x] `PointerTest.vm` (127)
- [x] `StackTest.vm` (73)

## [Project 8: Virtual Machine II - Program Control](https://www.nand2tetris.org/project08)

Final hack instruction set count in brackets as before.

### Program Flow Commands

- [x] `BasicLoop.vm` (93)
- [x] `Fibonacci.vm` (193)

## Function Calling Commands

- [x] `SimpleFunction.vm` (128)
- [x] `FibonacciElement` (434)
- [x] `NestedCall.vm` (556)
- [x] `StaticsTest.vm` (664)

## [Project 9: High-Level Programming](https://www.nand2tetris.org/project09)
