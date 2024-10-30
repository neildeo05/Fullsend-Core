`include "inst_pkg.sv"
module top (
    clk,
    reset,
    reg_array,
    ram
);
  input logic clk;
  input logic reset;

  output logic [31:0] reg_array[31:0];

  logic [31:0] pc;
  logic [31:0] curr_inst;
  logic [31:0] imem[2047:0];
  logic [31:0] address;
  logic [31:0] in;
  logic [31:0] mem_wb[4:0];
  logic r_w;
  logic en;
  logic [31:0] out;

  output logic [31:0] ram[10239:0];

  Mem memory (
      .clk(clk),
      .address(address),
      .in(in),
      .out(mem_wb[2]),
      .en(en),
      .r_w(r_w),
      .ram(ram)
  );

  IMem im (
      .imem(ram),
      .address(pc),
      .read_out(curr_inst)
  );
  Core core (
      .clk(clk),
      .reset(reset),
      .pc(pc),
      .curr_inst(curr_inst),
      .reg_array(reg_array),
      .mem_wb(mem_wb),
      .mem_address(address),
      .mem_input(in),
      .mem_enable(en),
      .mem_r_w(r_w)
  );

endmodule
;  // top
