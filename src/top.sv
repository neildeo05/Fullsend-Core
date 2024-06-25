module top(clk, reset, reg_array, ram);
   input logic clk;
   input logic reset;
   
   output logic [31:0] reg_array [31:0];
   
   logic [31:0] pc;
   logic [31:0] curr_inst;
   logic [31:0] imem [2047:0];
   logic [31:0] address;
   logic [31:0] in;
   logic [31:0] mem_wb [4:0];
   logic r_w;
   logic en;
   logic [31:0] out;
   
   output logic [31:0] ram [10239:0];
   
   Mem memory(clk, address, in,mem_wb[2] , en, r_w, ram);
   IMem im(ram, pc, curr_inst);
   Core core(clk, reset, pc, curr_inst, reg_array, mem_wb, address, in, en, r_w);

endmodule; // top
