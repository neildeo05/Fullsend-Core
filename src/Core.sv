module Core (clk, reset, pc, curr_inst, reg_array, mem_wb, mem_address, mem_input, mem_enable, mem_r_w);
   input logic clk;
   input logic reset;
   input logic [31:0] curr_inst;
   // Has to implement Datapath and ControlUnit
   logic [6:0] current_opcode;
   logic [3:0] current_func;
   logic       branch_inst;
   logic       reg_reg_inst;
   logic       ex_load_inst;
   logic       ex_reg_dest;
   logic       load_inst;
   logic       reg_dest;
   logic [3:0] alu_op;
   output logic [31:0] pc;
   output logic [31:0] reg_array [31:0];
   output logic [31:0] mem_wb [4:0];
   output logic [31:0] mem_address;
   output logic [31:0] mem_input;
   output logic        mem_enable;
   output logic        mem_r_w;
   
   Datapath dp(clk, reset, pc, curr_inst, current_opcode, current_func, branch_inst, reg_reg_inst, ex_load_inst, ex_reg_dest, load_inst, reg_dest, alu_op, reg_array, mem_wb,mem_address, mem_input, mem_enable, mem_r_w);

   ControlUnit cu(clk, reset, current_opcode, current_func, branch_inst, reg_reg_inst, ex_load_inst, ex_reg_dest, load_inst, reg_dest, alu_op);
   
 

endmodule; // Core
