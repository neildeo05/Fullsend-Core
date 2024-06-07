# Fullsend - A RISC-V Core


- [x] RV32I (minus branches)
- [x] Pipeline Staling
- [x] Pipeline forwarding
- [ ] Full RV32IM support
- [ ] Caches
- [ ] Branches


## Issue
The regfile writes on the rising edge and reads on the falling edge. Thus, in order to properly implement stalling, I made the regfile's input be ID/EX's RS1 and RS2, not IF/ID's RS1 and RS2. I do not know if this will cause problems down the line but it is working so far
