# NOTES

## RAM8

trick is to figure out how to mux twice based on address, once for setting the load bit and once for picking the correct output bus.

## RAM64

Interesting part here is that the `MSB|LSB` decision is arbitary. You could use the LSB to pick the RAM8 module, and use the MSB as the address within the RAM8, and it _would still work_. The caller for RAM64 doesn't care how you use the "complete address". It just cares that you return the same thing for that address.

## RAM512

I used the premise of the previous note and decided to index the RAM64 moduls by the LSB instead of the customary MSB. It still works :metal:

## PC

The Program Counter was tricky. I ended up using a Or8Way (instead of a `Or3Way`, which we don't have) along with `Mux8Way16` to pick the input for the register. Since the Mux has duplicate inputs at this point (supports 8, but we only have 3 special, and 1 neutral case) - this can be optimized by switching to a `Mux4Way16`, along with some other changes.

## Fill.asm

Figured out [that my RAM16K implementation was wrong](https://github.com/captn3m0/nand2tetris/commit/90526cc036a93683f3fa335aae70cc17c787e5a5) while working on this. The rough pseudocode would be:
```c
int r0=*screen;
while(true) {
  int color = 0;
  if (*kbd > 0) {
    color = -1;
  }

  // This sets an entire row of pixels to color
  // each row has 32 registers (512/16) that we set to color
  *r0 = color;
  *r0+1 = color;
  *r0+2 = color;
  *r0+3 = color;
  *r0+4 = color;
  // and so on
  *r0+31 = color;

  // if we are on the last row
  if (r0-24575 <=0) {
    r0 = *screen;
  }
}

```

So every "cycle" of the loop, we are coloring an entire row. The row is decided by R0, which is set to @SCREEN at the start. So if you press a key while we are on the middle of the loop (say 120th row), everything from that row onwards would get painted in black, and then the loop resets r0=\*screen once we cross the limits. The next iteration of the loop then starts filling the white pixels we'd left in the previous iteration. I kept the smallest paint unit as the row, but it doesn't really matter that much. The only difference is that I'm reading kbd a total of 256 times to paint the screen. Reading once per register also would work, and reading once per "screenfill" would also work. But that changes the 'delay' b/w your keyboard press and the screen fill start. I thought per row was a good compromise.

## Memory

Started by using a Mux4Way16, but then decided against making the same mistake I did in PC. Switched to 2 Mux16s instead.

## CPU

No tricks, fairly straight forward implementation of a few Mux atop the ALU. Things I missed on the first pass:
 - Ensuring that control bits for writeM or jumps are _only_ set when instruction is C. This is just ANDing the relevant control bit with instruction[15]
 - `!ng != positive`. Zero being the exception. So `positive = !(ng | zr)`. I think the whole jumpToAddress bit calculation can be improved though.

## Computer

The hardest part about this was deciding what name to give to all the pins

## Assembler

I think there are definitely some tricks with reducing lookup table sizes, but I wasn't really aiming for performance (I wrote it in ruby afterall). Also working on a rust implementation, just to learn rust.

# VM (1)

The implementation is written in Modern PHP with static typing. Uses the following 3 classes

- `CommandType` as a Enum for using command types as constants
- `Parser`, mostly as defined in the specification
- `CodeWriter`, mostly as defined in the specification
- `VMTranslator` which combines the above

# VM (2)

Learnt quite a lot. Interesting gotchas:

1. Stack manipuation is hard. Keeping track of registers is hard. I was going by the diagrams which always have "arguments" going from 0..n, which screws up the one case where you don't have arguments for a function, and ARG points to the same location where the return address is stored. In case the VM writes the return value to ARG[0], and you have zero arguments - it will also overwrite the return address, and your whole stack will go haywire (I got cool designs on my screen because of this).

2. I got into a weird state where FibonacciElement test was passing, but the SimpleFunction was failing for me. Ended up wasting a lot of time reverting back and forth to figure out the differences. If you're stuck here, check the [project page](https://www.nand2tetris.org/project08) for details on the intermediate `NestedCall.vm` testcase, which comes with a [detailed survival guide](https://www.nand2tetris.org/copy-of-hdl-survival-guide) and RAM states at various points in the call history: https://www.nand2tetris.org/copy-of-nestedcall.

# Writing Jack (Chapter 9)

I thought of writing a Ultimate Tic Toe game in Jack, but decided against it in the interest of time. The book specifically asks you to treat the project as a learning exercise to get a feel for Jack, and not try to become an expert Jack programmer. Writing UTT would have resulted in a lot of Yak Shaving which I wanted to avoid. I instead spent the time working on [other projects](https://github.com/captn3m0/modernart).

# Compiler - Tokenizer

Writing the Tokenizer was fun. The hardest part was, surprisingly, comments. Since we're removing comments before we have a complete tokenization, parsing the following line becomes super-hard:

```java
/*Open a comment */ let s = "/** This is not a comment */"; /* But this is */ do a.b;
```

I decided to ignore such edge cases, and focus on getting the base ideas correct. I haven't corrected for either of the two issues:

- multiple multi-line comments on the same line
- multi-line comments inside of strings

I can definitely solve it, but I want to do it properly. I've also realized why I love PHP, and not Python so much -

1. The standard library is much _easier to use_. PHP is built for developer productivity first, and terseness doesn't matter. Examples: Creating a directory recursively in [PHP][https://www.php.net/manual/en/function.mkdir.php] vs [Python](https://stackoverflow.com/a/600612)
2. PHP's language documentation is aimed at users, while Python throws so much useless stuff at you. I'm yet to find a language documentation that rivals PHP, to be fair - but Python gets so much wrong. Searching for "condition" on Python docs gets you: a page on something called Condition Objects, Conditional Expressions, and "More on conditions" - none of which actually detail what are the conditional statements and how they work. Look at the [control structures](https://www.php.net/manual/en/language.control-structures.php) page on PHP website instead. Python docs also like talking about language implementation details too much. For eg, BNF notation is peppered throughout the docs. PHP on the other hand uses only one language in its docs - PHP.
3. Lack of examples in documentation. You're left to figure out so many things. PHP gets this correct, for every function in the standard library. If examples are missing, the comments will usually have them.
4. Static Typing
