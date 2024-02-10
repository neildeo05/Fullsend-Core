// Temporary Instruction Memory RAM, will eventually build ICache


module IMem (address, read_out);
   input logic [5:0] address;
   output logic [31:0] read_out;

   // 128 instruction maximum
   logic [31:0]        imem [128:0];

   //NOT SYNTHESIZEABLE

   initial begin
      $readmemh("../software/main.hex", imem);
   end
   assign read_out = imem[address];

   
   
endmodule // IMem

