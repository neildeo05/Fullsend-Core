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
module Datapath (clk, reset,/* id_ex, */current_opcode, current_func, branch_inst, reg_reg_inst, ex_load_inst, ex_reg_dest, load_inst, reg_dest, alu_op, reg_array, dmem);
   input logic clk;
   input logic reset;
   input logic branch_inst;
   input logic reg_reg_inst;
   input logic load_inst;
   input logic reg_dest;
   input logic ex_load_inst;
   input logic ex_reg_dest;
   input logic [3:0] alu_op;
   output logic [6:0] current_opcode;
   output logic [3:0] current_func;
   output logic [31:0] reg_array [31:0];
   output logic [31:0] dmem [2047:0];
   
   // These two come from EX/MEM
   logic branch_taken;
   logic [31:0] pc_offset_branch;
   
   // IR, NPC 
   logic [31:0] if_id [1:0];
   assign current_opcode = id_ex[3][6:0];
   assign current_func = {id_ex[3][30], id_ex[3][14:12]};
   //a, b, npc, ir, imm
   logic [31:0] id_ex [4:0];
   //ir, cond, alu_output, b-register
   logic [31:0] ex_mem[3:0]; 

   // ir, alu_output, lmd, load_inst, reg_dest
   logic [31:0] mem_wb [4:0];
   

   

   
   
   // Regfile has two read output ports, one for rs1, and one for rs2
   // wa is the write input
   

   logic [4:0] reg_wa;
   logic [31:0] wa_data;
   logic       reg_r_w;
   logic [1:0] stall_counter;
   logic       stall;
   logic       f_rs1 [1:0];
   logic       f_rs2 [3:0];
   logic [31:0] fwd_1;
   logic [31:0] fwd_2;
   logic [31:0] sb_fwd_2;
   logic        f_en;
   
   
   StallUnit su(id_ex[3], if_id[0], stall_counter, stall);
   ForwardingUnit fu(mem_wb[0], ex_mem[0], id_ex[3], ex_mem[2], mem_wb[1], mem_wb[2], f_rs1, f_rs2, fwd_1, fwd_2,sb_fwd_2, f_en);
   Stage1 s1 (clk, reset, ex_mem[1], ex_mem[2], if_id, stall, stall_counter);
   Stage2 s2 (clk, reset, if_id[0], if_id[1], id_ex, stall);
   Stage3 s3 (clk, reset, branch_inst, reg_reg_inst, ex_load_inst, ex_reg_dest, id_ex[0], id_ex[1], id_ex[2], id_ex[3], id_ex[4], alu_op, ex_mem, f_rs1, f_rs2, fwd_1, fwd_2, sb_fwd_2, f_en);
   Stage4 s4 (clk, reset, load_inst, reg_dest, ex_mem[0], ex_mem[2], ex_mem[3], mem_wb, f_rs2, sb_fwd_2, dmem);

   logic [31:0] write_back;
   logic        enable;
   
   always_comb begin
      if(mem_wb[3] == 0) begin
         // not a load instruction, so the output is the alu_output
         write_back = mem_wb[1];
         enable = 0;
      end
      else begin
         if(mem_wb[4] == 1) begin
            // store instruction
            write_back = 0;
            enable = 1;
         end
         else begin
            write_back = mem_wb[3];
            enable = 0;
         end
      end
      
   end
   
   
   
   
   Regfile regs(clk, reset, enable, id_ex[3][19:15], id_ex[0], id_ex[3][24:20], id_ex[1], mem_wb[0][11:7], (mem_wb[3] == 0) ? mem_wb[1] : mem_wb[2], reg_r_w, reg_array);
   
   
   

endmodule; // Datapath

