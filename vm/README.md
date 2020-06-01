# VM Implementation

We have 8 segments:

- `argument`
- `local`
- `this/that`
- `pointer`
- `static` (shared)
- `constant` (shared)
- `temp` (shared)

RAM Address | Usage
============|=================
0-15        | Virtual Registers
16-255      | Static Variables (shared)
256-2047    | Stack
2048-16384  | Heap
16384-24575 | Memory mapped I/O

Register  |  Name  | Usage
==========|========|=========
`RAM[0]`  | `SP`   | Stack Pointer
`RAM[1]`  | `LCL`  | `local`
`RAM[1]`  | `ARG`  | `argument`
`RAM[3]`  | `THIS` | `this`
`RAM[4]`  | `THAT` | `that`
RAM[5-12] | `temp` Segment
RAM[13-15]| General Purpose Registers


The implementation is written in Modern PHP with static typing. Uses the following 3 classes

- `CommandType` as a Enum for using command types as constants
- `Parser`, mostly as defined in the specification
- `CodeWriter`, mostly as defined in the specification
- `VMTranslator` which combines the above
