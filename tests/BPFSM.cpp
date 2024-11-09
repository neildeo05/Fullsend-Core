#include <stdlib.h>
#include <stdint.h>
#include <iostream>
#include <bitset>
#include <cmath>
#include <cassert>
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "VBranchPredictionFSM.h"

#define MAX_TIME 100

using namespace std;

int main() { 

  int cnt = 0;
  Verilated::traceEverOn(true);
  VBranchPredictionFSM *to = new VBranchPredictionFSM;
  VerilatedVcdC* trace = new VerilatedVcdC;
  to->trace(trace, 99);
  trace->open("bpfsm.vcd");
  while(cnt <= MAX_TIME) {
    to->clk ^= 1;
    to->eval();
    to->reset = 0;
    to->eval();
    if(cnt % 2 == 0) {
      to->taken = (int)(rand() % 2);
      to->eval();
    printf("%d %d\n", to->taken, to->states);
    }
    // std::cout << to->states << std::endl;
    trace->dump((uint64_t)(cnt));
    cnt++;
  }
  trace->close();

 exit(0);
}
