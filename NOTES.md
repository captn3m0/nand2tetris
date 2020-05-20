# NOTES

RAM8
: trick is to figure out how to mux twice based on address, once for setting the load bit and once for picking the correct output bus.

RAM64
: Interesting part here is that the MSB|LSB decision is arbitary. You could use the LSB to pick the RAM8 module, and use the MSB as the address within the RAM8, and it _would still work_. The caller for RAM64 doesn't care how you use the "complete address". It just cares that you return the same thing for that address.

RAM512
: I used the premise of the previous note and decided to index the RAM64 moduls by the LSB instead of the customary MSB. It still works :metal:
