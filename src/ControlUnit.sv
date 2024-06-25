// ALU Ops:
/*
 ADD -> 00
 Sub -> 01
 Or -> 10
 AND -> 11
 */
module ControlUnit(clk, reset, current_opcode,current_func, branch_inst, reg_reg_inst, ex_load_inst, ex_reg_dest, load_inst, reg_dest, alu_op);
   input logic clk;
   input logic reset;
   input logic [6:0] current_opcode;
   input logic [3:0] current_func;
   output logic branch_inst;
   output logic reg_reg_inst;
   output logic load_inst;
   output logic reg_dest;
   output logic [3:0] alu_op;
   output logic       ex_load_inst;
   output logic       ex_reg_dest;
   
   /*
    Instructions
    1. NOP                 0000
    2. ADD                 0001
    3. SUB                 0010
    4. XOR                 0011
    5. OR                  0100
    6. AND                 0101
    7. LOGICAL SL          0110
    8. LOGICAL SR          0111
    9. ARITHM. SL          1000
    10. ARITHM. SR         1001
    11. SETLT              1010
    12. SETLT(zero extend) 1011
    13. AUI                1100
    14. AUIPC              1101
    */

   
   
   always @(posedge clk) begin
      load_inst <= ex_load_inst;
      reg_dest <=  ex_reg_dest;
   end
   
   always_comb begin
//      if(current_opcode[6]) begin
//         // branch
//      end
      if ((current_opcode[0] & current_opcode[1]) == 1) begin
         case(current_opcode[5:4])
           2'b00: begin
              // reg reg load
              // reg reg loads are basically immediate ops with a constant alu_op
              branch_inst = 0; reg_reg_inst = 0; ex_load_inst = 1; ex_reg_dest = 0; alu_op = 4'b0001; //always an add
           end
           2'b01: begin
              // immediate
//              $display("immediate %b %b", current_opcode, current_func);
              if(current_opcode[2]) begin
                 // alu operation for AUI
                 $display("Upper Immediate instruction");
                 branch_inst = 0; reg_reg_inst = 0; ex_load_inst = 0; ex_reg_dest = 0; alu_op = 4'b1101;
              end
              else begin
                 branch_inst = 0; reg_reg_inst = 0; ex_load_inst = 0; ex_reg_dest = 0;
                 
                 case(current_func[2:0])
                   3'b000: begin
                      // ADD
                      alu_op = 4'b0001;
                   end
                   3'b001: begin
                      //SLLI
                      alu_op = 4'b0110;
                      
                   end
                   3'b010: begin
                      // SETLT
                      alu_op = 4'b1010;
                      
                   end
                   3'b011: begin
                      // SETLT (U)
                      alu_op = 4'b1011;
                      
                   end
                   3'b100: begin
                      // XOR
                      alu_op = 4'b0011;
                   end
                   3'b101: begin
                      // Either logical SR or arith SR
                      if(current_func[3] == 0) alu_op = 4'b0111;
                      else alu_op = 4'b1001;
                   end
                   3'b110: begin
                      // OR
                      alu_op = 4'b0100;
                   end
                   3'b111: begin
                      // AND
                      alu_op = 4'b0101;
                   end
                   default: begin
                      alu_op = 4'b0000;
                   end
                 endcase // case (current_func)
              end // else: !if(current_opcode[2])
           end
           2'b10: begin
              // store (load instruction, with a reg_dest of 1 (doesn't wb)
              if(current_opcode[6]) begin
                 if(current_opcode[3]) begin
                    // jump
                    if(current_opcode[4]) begin
                       //jalr -> Immediate type instruction 
                       $display("ILLEGAL: JALR NOT IMPLEMENTED YET");
                       branch_inst = 0; reg_reg_inst = 0; ex_load_inst = 0; ex_reg_dest = 0; alu_op = 4'b0000;
                    end
                    else begin
                       // jal
                       branch_inst = 1; reg_reg_inst = 1; ex_load_inst = 0; ex_reg_dest = 0; alu_op = 4'b0001;
                    end
                 end
                 else begin
                    // branch
                    $display("ILLEGAL: BRANCH NOT IMPLEMENTED YET");
                 branch_inst = 0; reg_reg_inst = 0; ex_load_inst = 0; ex_reg_dest = 0; alu_op = 4'b0000;
                 end
              end
              else begin
                 // store
                 branch_inst = 0; reg_reg_inst = 0; ex_load_inst = 1; ex_reg_dest = 1; alu_op = 4'b0001;
              end
           end
           2'b11: begin
              // reg reg arith
//              $display("reg reg arith %b %b", current_opcode, current_func);
              branch_inst = 0; reg_reg_inst = 1; ex_load_inst = 0; ex_reg_dest = 0;
              case (current_func)
                4'b0000: alu_op = 4'b0001;
                4'b1000: alu_op = 4'b0010;
                4'b0001: alu_op = 4'b0110;
                4'b0010: alu_op = 4'b1010;
                4'b0011: alu_op = 4'b1011;
                4'b0100: alu_op = 4'b0011;
                4'b0101: alu_op = 4'b0111;
                4'b1101: alu_op = 4'b1001;
                4'b0110: alu_op = 4'b0100;
                4'b0111: alu_op = 4'b0101;
                default: alu_op = 4'b0000;
              endcase // case (current_func[2:0])
           end
         endcase // case (current_opcode[6:4])
      end // if (opcode[0] & opcode[1] == 1)
      else begin
         // illegal instruction or nop
         branch_inst = 0;reg_reg_inst = 0; ex_load_inst = 0; ex_reg_dest = 0; alu_op = 4'b0000;
      end // else: !if((current_opcode[0] & current_opcode[1]) == 1)
      
   end
endmodule; // ControlUnit
