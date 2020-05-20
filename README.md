# nand2tetris

Working my way through the [Nand to Tetris Course](https://www.nand2tetris.org/)

- Download the latest `nand2tetris.zip` from the book website, and overwrite everything in the `projects` and `tools` directory.
- Remember to run `chmod +X tools/*.sh` if you're on \*nix.

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

- [x] HalfAdder (Xor+And)
- [x] FullAdder (2 x HalfAdder, 1 Or)
- [ ] Add16
- [ ] Inc16
- [ ] ALU (nostat)
- [ ] ALU (complete)
