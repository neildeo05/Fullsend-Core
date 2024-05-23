#include <stdlib.h>
#include <stdint.h>
#include <iostream>
#include <bitset>
#include "verilated.h"
#include "VStage1.h"
#include "tb.hpp"

#define MAX_TIME 20

using namespace std;

int main() { 
  TB<VStage1>* tb = new TB<VStage1>(MAX_TIME);

  tb->start_trace("waveform.vcd");
  tb->to->branch_cond = 0;
  while (tb->should_tick()) {
    tb->tick();
    printf("%d: %x\n", tb->to->if_id[1], tb->to->if_id[0]);
  }

  tb->close_trace();
  exit(0);
}
