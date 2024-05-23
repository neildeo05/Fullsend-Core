module Core (clk, reset, reg_array, dmem);
   input logic clk;
   input logic reset;
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
   output logic [31:0] reg_array [31:0];
   output logic [31:0] dmem [2047:0];
   
   Datapath dp(clk, reset, current_opcode, current_func, branch_inst, reg_reg_inst, ex_load_inst, ex_reg_dest, load_inst, reg_dest, alu_op, reg_array, dmem);
   ControlUnit cu(clk, reset, current_opcode, current_func, branch_inst, reg_reg_inst, ex_load_inst, ex_reg_dest, load_inst, reg_dest, alu_op);
//   always @(posedge clk) begin
//      $display("current_op: %b current_func: %b branch: %b reg: %b load: %b dest: alu_op: %b", current_opcode, current_func, branch_inst, reg_reg_inst, load_inst, reg_dest, alu_op);
//      
//   end
   
 

endmodule; // Core
