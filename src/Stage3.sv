module Stage3(clk, reset, branch_inst, reg_reg_inst, ex_load_inst, ex_reg_dest, id_ex_a, id_ex_b, id_ex_npc, id_ex_ir, id_ex_imm, alu_op, ex_mem, f_rs1, f_rs2, fwd_1, fwd_2, f_en);
   input logic clk;
   input logic reset;
   input logic branch_inst;
   input logic reg_reg_inst;
   input logic ex_load_inst;
   input logic ex_reg_dest;
   input logic f_en;
   input logic [31:0] id_ex_a;
   input logic [31:0] id_ex_b;
   input logic [31:0] id_ex_npc;
   input logic [31:0] id_ex_ir;
   input logic [31:0] id_ex_imm;
   input logic [3:0]   alu_op;
   input logic         f_rs1 [1:0];
   input logic         f_rs2 [1:0];
   input logic [31:0]  fwd_1;
   input logic [31:0]  fwd_2;
   
   
   output logic [31:0] ex_mem [3:0];
   logic [31:0]        alu_a;
   logic [31:0]        alu_b;
   logic [31:0]        alu_out;
   logic [31:0]        reg_b_out;
   
   
   // ID/EX.a corresponds to RS1
   // ID/EX.b corresponds to RS2
   always_comb begin
      if(f_rs1[0]) begin
         alu_a = fwd_1;
      end
      else if(f_rs1[1]) begin
         alu_a = fwd_1;
      end
      else alu_a = id_ex_a;
   end
   
   always_comb begin
      if(f_rs2[0]) begin
         alu_b = fwd_2;
         reg_b_out = fwd_2;
      end
      else if(f_rs2[1]) begin
         alu_b = fwd_2;
         reg_b_out = fwd_2;
      end
      else begin
         reg_b_out = id_ex_b;
         if(reg_reg_inst) begin
            alu_b = id_ex_b;
         end
         else begin
            if(ex_load_inst & ex_reg_dest) begin
               // store inst has different immediate
               alu_b = {id_ex_ir[31:25], id_ex_ir[11:7]};
            end
            else begin
               alu_b = id_ex_imm;
            end
         end
      end // else: !if(f_rs2[1])
      
   end
   ALU alu(alu_a, alu_b, alu_op, alu_out);
   
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
         ex_mem[3] <= reg_b_out; // Register B
      end
      
      
   end
   
   
endmodule; // Stage3
