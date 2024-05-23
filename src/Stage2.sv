module Stage2 (clk, reset, if_id_ir, if_id_npc, id_ex);
   input logic clk;
   input logic reset;

   input logic [31:0] if_id_ir;
   input logic [31:0] if_id_npc;
   

   
   
   output logic [31:0] id_ex [4:0];
   
   always @(posedge clk) begin
      if(reset) begin
         id_ex[0] <= 0;
         id_ex[1] <= 0;
         id_ex[2] <= 0;
         id_ex[3] <= 0;
         id_ex[4] <= 0;
      end
      else begin
         
         id_ex[2] <= if_id_npc;
         id_ex[3] <= if_id_ir;
         id_ex[4] <= $signed(if_id_ir[31:20]);
      end
      
      

   end
   
endmodule; // Stage2
