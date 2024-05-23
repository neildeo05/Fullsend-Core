#include <stdlib.h>
#include <stdint.h>
#include <string>
#include <iostream>
#include <bitset>
#include "verilated.h"
#include "VDatapath.h"
#include "tb.hpp"

#define MAX_TIME 20

using namespace std;

int main() { 
  printf("\n\n\n");
  FILE* f = fopen("../software/main.asm", "r");
  char c;
  c = fgetc(f);
  while(c != EOF) {
    printf("%c", c);
    c = fgetc(f);
  }
  fclose(f);
  printf("\n\n\n");
  TB<VDatapath>* tb = new TB<VDatapath>(MAX_TIME);

  tb->start_trace("waveform.vcd");
  string id_ex_labels[5] = {
    "First Register",
    "Second Register",
    "New PC",
    "Instruction Register",
    "Immediate",
  };
  while (tb->should_tick()) {
    tb->tick();
    for(int i = 0; i < 5; i++) {
      //      cout << id_ex_labels[i] << ": " << hex << tb->to->id_ex[i] << "\t" ;
    }
    printf("\n");
  }

  tb->close_trace();
  exit(0);
}
