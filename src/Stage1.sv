// branch_cond corresponds to EX/MEM.cond
// pc_offfset_branch corresponds to EX/MEM.ALUOutput
module Stage1 (clk, reset, branch_cond, pc_offset_branch, if_id, hazard, stall_counter);
   input logic clk;
   input logic reset;
   input logic hazard;
   output logic [1:0] stall_counter;
   input logic [31:0] pc_offset_branch;
   input logic        branch_cond;
   logic [31:0] pc;
   logic [31:0] npc;
   logic [31:0] ir;
   output logic [31:0] if_id [1:0];

   IMem mem(pc, ir);
   always @(posedge clk) begin
      if (reset) begin
         pc <= 0;
         npc <= 0;
         if_id[0] <= 0;
         if_id[1] <= 0;
      end
      else begin
         if(branch_cond) begin
            npc <= pc_offset_branch;
            pc <= pc_offset_branch;
         end
         else if(hazard) begin
            // If a hazard, keep recirculating this inst
//            $display("HAZARD");
            npc <= npc;
            pc <= pc;
            stall_counter <= stall_counter + 1;
         end
         else begin
            npc <= npc + 1;
            pc <= pc + 1;
         end
      end
   end
   assign if_id[0] = ir;
   assign if_id[1] = npc;
endmodule;