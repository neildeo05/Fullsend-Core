module Mem(clk, address, in, out, en, r_w, ram);
   // 4kb of ram
   // 1 kb of instruction memory
   // 3 kb of data memory
   // 0x0 -> 0x399 (instruction memory)
   // 0x400 -> 0x1000 (data memory)
   input logic clk;
   input logic [31:0] address;
   input logic [31:0] in;
   input logic        r_w;
   input logic        en;
   
   logic [31:0] imem[2047:0];
   logic [31:0] dmem[2047:0];
   output logic [31:0] out;
   output logic [31:0] ram [10239:0];
   assign ram[2047:0] = imem;
   
   always @(posedge clk) begin
      if(en) begin
         if(!r_w) out <= ram[address];
         else ram[address] <= in;
      end
      else begin
         out <= 0;
      end
   end
   integer i;
   initial begin
      
      $readmemh("../software/text.hex", imem);
      $readmemh("../software/data.hex", dmem);
      for(i = 0; i < 2048; i = i+1) begin
         ram[2048+(i*4)] = dmem[i];
      end
   end
   
   

   
endmodule; // Mem
