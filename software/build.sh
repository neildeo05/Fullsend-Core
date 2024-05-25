#!/usr/bin/bash
set -xe
riscv32-unknown-linux-gnu-as main.asm
riscv32-unknown-linux-gnu-objcopy -O binary a.out a.bin --only-section ".text*"
riscv32-unknown-linux-gnu-objdump -D a.out
hexdump -v -e '1/4 "%08x\n"' a.bin > main.hex
rm a.bin a.out

