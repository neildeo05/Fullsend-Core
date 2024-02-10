#include <stdlib.h>
#include <stdint.h>
#include <iostream>
#include <bitset>
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "VIMem.h"

#define MAX_TIME 100
uint8_t cnt = 0;

using namespace std;

int main() { 
  VIMem *to = new VIMem;
  to->address = 0;
  to->eval();
  printf("%08x\n", to->read_out);
  to->address = 1;
  to->eval();
  printf("%08x\n", to->read_out);
  to->address = 2;
  to->eval();
  printf("%08x\n", to->read_out);

 exit(0);
}
