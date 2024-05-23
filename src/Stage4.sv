module Stage4(clk, reset, load_inst, ex_mem_ir, ex_mem_alu_output, ex_mem_b, mem_wb);
   input logic clk;
   input logic reset;
   input logic load_inst;
   input logic [31:0] ex_mem_ir;
   input logic [31:0] ex_mem_alu_output;
   input logic [31:0] ex_mem_b;
   output logic [31:0] mem_wb [3:0];
   logic [31:0]        mem_out;
   logic               r_w;
   
   DMem dm(clk, ex_mem_alu_output, ex_mem_b, mem_wb[2], load_inst, r_w);
   
   always @(posedge clk) begin
      mem_wb[0] <= ex_mem_ir;
      mem_wb[1] <= ex_mem_alu_output;
      mem_wb[3] <= load_inst;
   end
   
   
endmodule; // Stage4

