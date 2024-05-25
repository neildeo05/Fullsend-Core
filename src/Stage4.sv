module Stage4(clk, reset, load_inst, reg_dest, ex_mem_ir, ex_mem_alu_output, ex_mem_b, mem_wb, dmem);
   input logic clk;
   input logic reset;
   input logic load_inst;
   input logic reg_dest;
   input logic [31:0] ex_mem_ir;
   input logic [31:0] ex_mem_alu_output;
   input logic [31:0] ex_mem_b;
   output logic [31:0] mem_wb [4:0];
   output logic [31:0] dmem [2047:0];
   DMem dm(clk, ex_mem_alu_output, ex_mem_b, mem_wb[2], load_inst, reg_dest, dmem);
   
   always @(posedge clk) begin
      mem_wb[0] <= ex_mem_ir;
      mem_wb[1] <= ex_mem_alu_output;
      mem_wb[3] <= load_inst;
      mem_wb[4] <= reg_dest;
   end
   
   
endmodule; // Stage4

