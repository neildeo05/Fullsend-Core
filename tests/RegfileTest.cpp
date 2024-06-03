#include <stdlib.h>
#include <stdint.h>
#include <string>
#include <iostream>
#include <bitset>
#include "verilated.h"
#include "VRegfile.h"
#include "tb.hpp"

#define MAX_TIME 4

using namespace std;

int main() { 
  FILE* f = fopen("../software/simple.asm", "r");
  char c;
  c = fgetc(f);
  while(c != EOF) {
    printf("%c", c);
    c = fgetc(f);
  }
  fclose(f);
  printf("\n\n\n");
  TB<VRegfile>* tb = new TB<VRegfile>(MAX_TIME);

  tb->start_trace("waveform.vcd");
  while (tb->should_tick()) {
    tb->to->reg_a = 3;
    tb->to->reg_wa = 3;
    tb->to->wa_data = 69;
    tb->tick();
    cout << tb->to->ra_data << endl;
  }
  for(int i = 0; i <= 31; i++) {
    cout << "x" << i << ": " << tb->to->reg_array[i] << endl;
  }

  tb->close_trace();
  exit(0);
}
