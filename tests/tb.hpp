#include <verilated_vcd_c.h>
#include <cinttypes>
template<class Module> class TB {
public:
  unsigned long long cnt;
  unsigned long long max_cnt;
  Module* to;
  VerilatedVcdC *trace;

  TB(unsigned long long _max_cnt) {
    max_cnt = _max_cnt;
    to = new Module;
    cnt = 0;
    Verilated::traceEverOn(true);
  }
  ~TB() {
    delete to;
  }
  virtual int should_tick() {
    return cnt != max_cnt;
  }
  virtual void start_trace (const char* fname) {
    trace = new VerilatedVcdC;
    to->trace(trace, 99);
    trace->open(fname);
  }
  virtual void close_trace() {
    trace->close();
  }
  virtual void tick() {
    cnt++;
    to->clk = 0;
    to->eval();
    trace->dump((uint64_t)(10*cnt-2));
    to->clk = 1;
    to->eval();
    trace->dump((uint64_t)(10*cnt));
    to->clk = 0;
    to->eval();
    trace->dump((uint64_t)(10*cnt+5));
    trace->flush();
  }
};
