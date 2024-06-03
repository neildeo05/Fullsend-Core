module StallUnit(id_ex_ir, if_id_ir, stall_counter, stall);
   // Comparing the instructions in the decode/execute stage, and the fetch/decode stage
   input logic [1:0] stall_counter;
   
   input logic [31:0] id_ex_ir;
   input logic [31:0] if_id_ir;
   
   output logic              stall;
   logic [3:0]               id_ex_rd;
   logic [3:0]               if_id_rs1;
   assign id_ex_rd = id_ex_ir[11:7];
   assign if_id_rs1 = if_id_ir[19:15];
   
   
   
   

   always_comb begin
      if(stall_counter == 2'b01) begin
         stall = 1;
      end
      else if(id_ex_ir == 0 | if_id_ir == 0) begin
         // Cannot hazard a nop
         stall = 0;
      end
      // Load Interlock Hazard Case 1
      else if(((id_ex_ir[5] | id_ex_ir[4]) == 0)) begin
         if(id_ex_rd == if_id_rs1) begin
            
            if(!(if_id_ir[19:15] == 0)) begin
               stall = 1;
            end
            else stall = 0;
         end
         // Load Interlock Hazard Case 2
         else if((id_ex_ir[11:7] == if_id_ir[24:20]) & (if_id_ir[5] & if_id_ir[4]) == 1) begin
            if(!(if_id_ir[24:20] == 0)) begin
//               $display("HAZARD DETECTED");
               stall = 1;
            end
            else stall = 0;
         end
         else begin
            
            stall = 0;
            
         end
         
      end
      else begin
         stall = 0;
         
      end // else: !if(((id_ex_ir[5] | id_ex_ir[4]) == 0))
      
   end
endmodule; // HazardUnit
