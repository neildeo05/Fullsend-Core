module ALU(alu_a, alu_b, alu_op, alu_out);
   input logic [31:0] alu_a;
   input logic [31:0] alu_b;
   input logic [3:0]  alu_op;
   output logic [31:0] alu_out;



   always_comb begin
      case (alu_op)
        4'b0001: alu_out = alu_a + alu_b;
        4'b0010: alu_out = alu_a - alu_b;
        4'b0011: alu_out = alu_a ^ alu_b;
        4'b0100: alu_out = alu_a | alu_b;
        4'b0101: alu_out = alu_a & alu_b;
        4'b0110: alu_out = alu_a << alu_b;
        4'b0111: alu_out = alu_a >> alu_b;
        4'b1000: alu_out = alu_a <<< alu_b;
        4'b1001: alu_out = alu_a >>> alu_b;
        4'b1010: alu_out = (alu_a < alu_b) ? 1 : 0;
        4'b1011: alu_out = (alu_a < alu_b) ? 1 : 0;
        
        default: begin
           alu_out = 0;
        end
        
        
      endcase // case alu_op
      
   end
   
   
endmodule; // ALU
