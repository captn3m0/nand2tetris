# NOTES

RAM8
: trick is to figure out how to mux twice based on address, once for setting the load bit and once for picking the correct output bus.

RAM64
: Interesting part here is that the MSB|LSB decision is arbitary. You could use the LSB to pick the RAM8 module, and use the MSB as the address within the RAM8, and it _would still work_. The caller for RAM64 doesn't care how you use the "complete address". It just cares that you return the same thing for that address.

RAM512
: I used the premise of the previous note and decided to index the RAM64 moduls by the LSB instead of the customary MSB. It still works :metal:

Fill.asm
: Figured out that my RAM16K implementation was wrong while working on this. The rough pseudocode would be:
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
  So every "cycle" of the loop, we are coloring an entire row. The row is decided by R0, which is set to @SCREEN at the start. So if you press a key while we are on the middle of the loop (say 120th row), everything from that row onwards would get painted in black, and then the loop resets r0=*screen once we cross the limits. The next iteration of the loop then starts filling the white pixels we'd left in the previous iteration. I kept the smallest paint unit as the row, but it doesn't really matter that much. The only difference is that I'm reading kbd a total of 256 times to paint the screen. Reading once per register also would work, and reading once per "screenfill" would also work. But that changes the 'delay' b/w your keyboard press and the screen fill start. I thought per row was a good compromise.
  **assembly**: Since our assembly doesn't have any functions, writing Assembly is much tougher than I thought it would be. All state is global, there are no functions, and you can only jump using goto.
