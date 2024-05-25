module DMem(clk, address, in, out, en, r_w, dmem);
   input logic clk;
   
   input logic [31:0] in;
   
   input logic [31:0] address;
   input logic        en;
   input logic        r_w;
   output logic [31:0] out;
   
   output logic [31:0]        dmem [2047:0];
   assign dmem[5] = 5;
   assign dmem[6] = 6;
   assign dmem[7] = 7;
   
   

   always @(posedge clk) begin
      if(en) begin
         if(!r_w) out <= dmem[address];
         else dmem[address] <= in;
      end
      else begin
         out <= 0;
      end
      
   end
endmodule // DMem
