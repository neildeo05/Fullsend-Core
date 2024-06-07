module Stage4(clk, reset, load_inst, reg_dest, ex_mem_ir, ex_mem_alu_output, ex_mem_b, mem_wb, sb_en, sb_fwd, dmem);
   input logic clk;
   input logic reset;
   input logic load_inst;
   input logic reg_dest;
   input logic [31:0] ex_mem_ir;
   input logic [31:0] ex_mem_alu_output;
   input logic [31:0] ex_mem_b;
   input logic        sb_en [3:0];
   input logic [31:0] sb_fwd;
   
   output logic [31:0] mem_wb [4:0];
   output logic [31:0] dmem [2047:0];
   logic [31:0]        reg_b_in;
   logic [31:0]        e_sb_fwd;
   logic               e_sb_en;
   
   always_comb begin
      if(sb_en[2] | sb_en[3]) reg_b_in = sb_fwd;
      else reg_b_in = ex_mem_b;
   end
   
   
   DMem dm(clk, ex_mem_alu_output, (e_sb_en) ? e_sb_fwd : reg_b_in, mem_wb[2], load_inst, reg_dest, dmem);
   
   always @(posedge clk) begin
      e_sb_en <= sb_en[3];
      e_sb_fwd <= reg_b_in;
      mem_wb[0] <= ex_mem_ir;
      mem_wb[1] <= ex_mem_alu_output;
      mem_wb[3] <= load_inst;
      mem_wb[4] <= reg_dest;
   end
   
   
endmodule; // Stage4

