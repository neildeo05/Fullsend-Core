module Stage3(clk, reset, branch_inst, reg_reg_inst, id_ex_a, id_ex_b, id_ex_npc, id_ex_ir, id_ex_imm, alu_op, ex_mem);
   input logic clk;
   input logic reset;
   input logic branch_inst;
   input logic reg_reg_inst;
   input logic [31:0] id_ex_a;
   input logic [31:0] id_ex_b;
   input logic [31:0] id_ex_npc;
   input logic [31:0] id_ex_ir;
   input logic [31:0] id_ex_imm;
   input logic [3:0]   alu_op;
   output logic [31:0] ex_mem [3:0];
   logic [31:0]        alu_a;
   logic [31:0]        alu_b;
   logic [31:0]        alu_out;
   
   

   always_comb begin
      if(reg_reg_inst) begin
         alu_b = id_ex_b;
      end
      else begin
         alu_b = id_ex_imm;
      end
   end
   ALU alu(id_ex_a, alu_b, alu_op, alu_out);
   
   always @(posedge clk) begin
      if(reset) begin
         ex_mem[0] <= 0;
         ex_mem[1] <= 0;
         ex_mem[2] <= 0;
      end
      else begin
         ex_mem[0] <= id_ex_ir; //IR
         ex_mem[1] <= 0; //COND
         ex_mem[2] <= alu_out; //ALU Output
         ex_mem[3] <= id_ex_b; // Register B
      end
      
      
   end
   
   
endmodule; // Stage3
