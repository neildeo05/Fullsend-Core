#!/usr/bin/bash
set -xe
riscv32-unknown-linux-gnu-as main.asm 
riscv32-unknown-linux-gnu-ld -o main.elf -T fullsend.ld -m elf32lriscv -nostdlib --no-relax a.out 
riscv32-unknown-linux-gnu-objcopy -O binary main.elf a.bin --only-section ".text*"
riscv32-unknown-linux-gnu-objcopy -O binary main.elf b.bin --only-section ".data*"
hexdump -v -e '1/4 "%08x\n"' a.bin > text.hex
hexdump -v -e '1/4 "%08x\n"' b.bin > data.hex
rm b.bin a.out

