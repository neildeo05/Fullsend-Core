#!/usr/bin/bash
set -xe
riscv32-unknown-linux-gnu-as test.asm 
riscv32-unknown-linux-gnu-ld -o test.elf -T fullsend.ld -m elf32lriscv -nostdlib --no-relax a.out 
riscv32-unknown-linux-gnu-objcopy -O binary test.elf a.bin --only-section ".text*"
riscv32-unknown-linux-gnu-objcopy -O binary test.elf b.bin --only-section ".data*"
hexdump -v -e '1/4 "%08x\n"' a.bin > text.hex
hexdump -v -e '1/4 "%08x\n"' b.bin > data.hex
rm b.bin a.out

