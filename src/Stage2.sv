module Stage2 (clk, reset, if_id_ir, if_id_npc, id_ex, hazard);
   input logic clk;
   input logic reset;
   input logic hazard;
   

   input logic [31:0] if_id_ir;
   input logic [31:0] if_id_npc;
   

   
   
   output logic [31:0] id_ex [4:0];
   logic               long_immediate;
   
   assign long_immediate = if_id_ir[2];

   
   
   always @(posedge clk) begin
      if(reset) begin
         id_ex[0] <= 0;
         id_ex[1] <= 0;
         id_ex[2] <= 0;
         id_ex[3] <= 0;
         id_ex[4] <= 0;
      end
      else if (hazard) begin
         // Dispatch No-ops
         id_ex[4] <= 0;
         id_ex[3] <= 0;
      end
      else begin
         
         id_ex[2] <= if_id_npc;
         id_ex[3] <= if_id_ir;
         // Checking to see which immediate we need:
         if (long_immediate) id_ex[4] <= $signed(if_id_ir[31:12]);
         else id_ex[4] <= $signed(if_id_ir[31:20]);
         
      end
      
      

   end
   
endmodule; // Stage2
