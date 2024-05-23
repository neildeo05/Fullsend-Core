module Regfile (clk, reset, reg_a, ra_data, reg_b, rb_data, reg_wa, wa_data, reg_r_w, reg_array);
   input logic clk;
   input logic reset;

   input logic [4:0] reg_a;
   input logic [4:0] reg_b;
   output logic [31:0] ra_data;
   output logic [31:0] rb_data;
   input logic [4:0]   reg_wa;
   input logic [31:0]  wa_data;

   input logic         reg_r_w;

   output logic [31:0]        reg_array [31:0];
   // constant first register 
   assign reg_array[0] = 0;
   
   
   

   always @(posedge clk) begin
      if(reset) begin
         ra_data <= 0;
         rb_data <= 0;
      end
      else begin
         ra_data <= reg_array[reg_a];
         rb_data <= reg_array[reg_b];
         reg_array[reg_wa] <= wa_data;
      end
      
      
   end
   
   
   
endmodule; // Regfile

   
   
