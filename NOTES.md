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

See `vm/README.md` for more details. Observations go here, implementation notes are there.
