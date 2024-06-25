#include <stdlib.h>
#include <stdint.h>
#include <stdint.h>
#include <iostream>
#include <bitset>
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "VMem.h"

#define MAX_TIME 100
uint8_t cnt = 0;

using namespace std;

int main() { 
  VMem *to = new VMem;
  to->eval();
  for(int i = 0; i < 100; i++) {
    printf("imem[%d] = %08x\n", i,to->imem[i]);
  }
  for(int i = 2048; i < 2100; i++) {
    printf("dmem[%d] = %08x\n", i,to->ram[i]);
  }
 exit(0);
}
