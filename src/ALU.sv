// `include "inst_pkg.sv"
// https://www.cs.sfu.ca/~ashriram/Courses/CS295/assets/notebooks/RISCV/RISCV_CARD.pdf
module ALU (
    input  logic [31:0] pc,
    input  logic [31:0] alu_a,
    input  logic [31:0] alu_b,
    input  logic [ 4:0] alu_op,
    output logic [31:0] alu_out
);
  import inst_pkg::*;

  // Specifically needed for multiplication/division operation
  // This would sign extend the alu_a and alu_b operands
  logic [31:0] signed_alu_a = $signed(alu_a);
  logic [31:0] unsigned_alu_a = $unsigned(alu_a);
  logic [31:0] signed_alu_b = $signed(alu_b);
  logic [31:0] unsigned_alu_b = $unsigned(alu_b);
  logic [63:0] mul_out;
  always_comb begin
    case (alu_op)
      // add
      ADD: alu_out = alu_a + alu_b;
      // subtract
      SUB: alu_out = alu_a - alu_b;
      // XOR
      XOR: alu_out = alu_a ^ alu_b;
      // OR
      OR: alu_out = alu_a | alu_b;
      // AND
      AND: alu_out = alu_a & alu_b;
      // Shift Left
      SLL: alu_out = alu_a << alu_b;
      // Shift Right
      SRL: alu_out = alu_a >> alu_b;
      // Arithmetic shift right
      SRA: alu_out = alu_a >>> alu_b;
      // SLT
      SLT: alu_out = (alu_a < alu_b) ? 1 : 0;
      // SLTU (sets the )
      SLTU: alu_out = (alu_a < alu_b) ? 1 : 0;
      // Add upper immediate
      AUI: alu_out = alu_a + (alu_b << 12);
      // Add upper immediate to PC
      AUIPC: alu_out = (pc - 4) + (alu_b << 12);
      // MUL
      MUL: begin
        // IGNORE ERROR HERE
        alu_out = {alu_a * alu_b}[31:0];
        // alu_out = mul_out[31:0];
      end
      MULH: begin
        // IGNORE ERROR HERE
        alu_out = {alu_a * alu_b}[63:32];
      end
      MULHU: begin
        // IGNORE ERROR HERE
        alu_out = {unsigned_alu_a * unsigned_alu_b}[63:32];
      end
      MULHSU: begin
        // mul_out = signed_alu_a * unsigned_alu_b;
        // IGNORE ERROR HERE
        alu_out = {signed_alu_a * signed_alu_b}[63:32];
      end
      DIV: alu_out = (signed_alu_a / signed_alu_b);
      DIVU: alu_out = (unsigned_alu_a / unsigned_alu_b);
      REM: alu_out = (signed_alu_a % signed_alu_b);
      REMU: alu_out = (unsigned_alu_a % unsigned_alu_b);
      default: begin
        // NOP
        alu_out = 0;
      end


    endcase

  end
endmodule
