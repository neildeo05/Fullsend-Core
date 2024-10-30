/*
 Controller controls:
 1. two muxes in execute stage
 2. write-back mux
 3. destination mux

 we need to figure out if the instruction is a:
  - branch (control top mux of exec)
  - reg_reg (control bottom mux of exec)
  - load_inst (control first wb mux)
  - mux to choose which part of IR is the correct reg_dest (control second wb mux) (reg_reg ALU vs ALU immediate/Load)

 */
module Datapath (
    clk,
    reset,
    pc,
    curr_inst,
    current_opcode,
    mul_inst,
    current_func,
    branch_inst,
    reg_reg_inst,
    ex_load_inst,
    ex_reg_dest,
    load_inst,
    reg_dest,
    alu_op,
    reg_array,
    mem_wb,
    mem_address,
    mem_input,
    mem_enable,
    mem_r_w
);
  input logic clk;
  input logic reset;
  input logic branch_inst;
  input logic reg_reg_inst;
  input logic load_inst;
  input logic reg_dest;
  input logic ex_load_inst;
  input logic ex_reg_dest;

  input logic [4:0] alu_op;
  input logic [31:0] curr_inst;
  output logic [31:0] pc;
  output logic [6:0] current_opcode;
  output logic mul_inst;
  output logic [3:0] current_func;
  output logic [31:0] reg_array[31:0];

  // These two come from EX/MEM
  logic branch_taken;
  logic [31:0] pc_offset_branch;

  // IR, NPC
  logic [31:0] if_id[1:0];
  assign current_opcode = id_ex[3][6:0];
  assign current_func = {id_ex[3][30], id_ex[3][14:12]};
  //00000010010000011000000100110011
  assign mul_inst = id_ex[3][25];
  //a, b, npc, ir, imm
  logic [31:0] id_ex [4:0];
  //ir, cond, alu_output, b-register
  logic [31:0] ex_mem[3:0];

  // ir, alu_output, lmd, load_inst, reg_dest

  output logic [31:0] mem_wb[4:0];







  // Regfile has two read output ports, one for rs1, and one for rs2
  // wa is the write input


  logic [ 4:0] reg_wa;
  logic [31:0] wa_data;
  logic        reg_r_w;
  logic [ 1:0] stall_counter;
  logic        stall;
  logic        f_rs1         [1:0];
  logic        f_rs2         [3:0];
  logic [31:0] fwd_1;
  logic [31:0] fwd_2;
  logic [31:0] sb_fwd_2;
  logic        f_en;

  output logic [31:0] mem_address;
  output logic [31:0] mem_input;
  //   output logic [31:0] mem_output;
  output logic mem_enable;
  output logic mem_r_w;

  StallUnit su (
      id_ex[3],
      if_id[0],
      stall_counter,
      stall
  );
  ForwardingUnit fu (
      mem_wb[0],
      ex_mem[0],
      id_ex[3],
      ex_mem[2],
      mem_wb[1],
      mem_wb[2],
      f_rs1,
      f_rs2,
      fwd_1,
      fwd_2,
      sb_fwd_2,
      f_en
  );
  Stage1 s1 (
      .clk(clk),
      .reset(reset),
      .curr_inst(curr_inst),
      .branch_cond(ex_mem[1]),
      .pc_offset_branch(ex_mem[2]),
      .hazard(stall),
      .if_id(if_id),
      .pc(pc),
      .stall_counter(stall_counter)
  );
  Stage2 s2 (
      .clk(clk),
      .reset(reset),
      .hazard(stall),
      .if_id_ir(if_id[0]),
      .if_id_npc(if_id[1]),
      .id_ex(id_ex)
  );
  Stage3 s3 (
      .clk(clk),
      .reset(reset),
      .branch_inst(branch_inst),
      .reg_reg_inst(reg_reg_inst),
      .ex_load_inst(ex_load_inst),
      .ex_reg_dest(ex_reg_dest),
      .id_ex_a(id_ex[0]),
      .id_ex_b(id_ex[1]),
      .id_ex_npc(id_ex[2]),
      .id_ex_ir(id_ex[3]),
      .id_ex_imm(id_ex[4]),
      .alu_op(alu_op),
      .f_rs1(f_rs1),
      .f_rs2(f_rs2),
      .fwd_1(fwd_1),
      .fwd_2(fwd_2),
      .sb_fwd_2(sb_fwd_2),
      .f_en(f_en),
      .ex_mem(ex_mem)
  );
  Stage4 s4 (
      .clk(clk),
      .reset(reset),
      .load_inst(load_inst),
      .reg_dest(reg_dest),
      .ex_mem_ir(ex_mem[0]),
      .ex_mem_alu_output(ex_mem[2]),
      .ex_mem_b(ex_mem[3]),
      .sb_en(f_rs2),
      .sb_fwd(sb_fwd_2),
      .mem_wb(mem_wb),
      .mem_address(mem_address),
      .mem_input(mem_input),
      .mem_enable(mem_enable),
      .mem_r_w(mem_r_w)
  );

  logic [31:0] write_back;
  logic        enable;

  always_comb begin
    if (mem_wb[3] == 0) begin
      // not a load instruction, so the output is the alu_output
      write_back = mem_wb[1];
      enable = 0;
    end else begin
      if (mem_wb[4] == 1) begin
        // store instruction
        write_back = 0;
        enable = 1;
      end else begin
        write_back = mem_wb[3];
        enable = 0;
      end
    end

  end




  Regfile regs (
      .clk(clk),
      .reset(reset),
      .neg_enable(enable),
      .reg_r_w(reg_r_w),
      .reg_wa(mem_wb[0][11:7]),
      .wa_data((mem_wb[3] == 0) ? mem_wb[1] : mem_wb[2]),
      .reg_a(id_ex[3][19:15]),
      .reg_b(id_ex[3][24:20]),
      .ra_data(id_ex[0]),
      .rb_data(id_ex[1]),
      .reg_array(reg_array)
  );




endmodule
;  // Datapath
