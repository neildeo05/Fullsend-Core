// Temporary Instruction Memory RAM, will eventually build ICache


module IMem (address, read_out);
   input logic [31:0] address;
   output logic [31:0] read_out;

   // 128 instruction maximum
   logic [31:0]        imem [2047:0];

   //NOT SYNTHESIZEABLE

   initial begin
      $readmemh("../software/main.hex", imem);
   end
   assign read_out = imem[address-1];

   
   
endmodule // IMem

