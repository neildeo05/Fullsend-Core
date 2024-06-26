#include <stdlib.h>
#include <iomanip>
#include <stdint.h>
#include <string>
#include <iostream>
#include <bitset>
#include "verilated.h"
#include "Vtop.h"
#include "tb.hpp"

#define MAX_TIME 40

using namespace std;

int main() { 
  printf("\n\n\n");
  FILE* f = fopen("../software/test.asm", "r");
  char c;
  c = fgetc(f);
  while(c != EOF) {
    printf("%c", c);
    c = fgetc(f);
  }
  fclose(f);
  printf("\n\n\n");
  TB<Vtop>* tb = new TB<Vtop>(MAX_TIME);

  tb->start_trace("waveform.vcd");
  while (tb->should_tick()) {
    tb->tick();
  }
  for(int i = 0; i <= 31; i++) {
    cout << 'x' << i << ": " << static_cast<int32_t>(tb->to->reg_array[i]) << endl;
  }
  for(int i = 2048; i <= 2048 + 31; i++) {
    cout << "mem[" << i << "]: " << static_cast<int32_t>(tb->to->ram[i]) << endl;
  }

  tb->close_trace();
  exit(0);
}
