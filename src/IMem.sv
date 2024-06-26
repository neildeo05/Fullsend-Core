// Temporary Instruction Memory RAM, will eventually build ICache


module IMem (imem, address, read_out);
   input logic [31:0] address;
   output logic [31:0] read_out;

   // 128 instruction maximum
   input logic [31:0]        imem [10239:0];

   //NOT SYNTHESIZEABLE

//   initial begin
//      $readmemh("../software/text.hex", imem);
//   end
   assign read_out = imem[address-4];

   
   
endmodule // IMem

