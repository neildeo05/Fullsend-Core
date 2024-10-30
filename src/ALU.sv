// https://www.cs.sfu.ca/~ashriram/Courses/CS295/assets/notebooks/RISCV/RISCV_CARD.pdf
module ALU (
    input  logic [31:0] pc,
    input  logic [31:0] alu_a,
    input  logic [31:0] alu_b,
    input  logic [ 4:0] alu_op,
    output logic [31:0] alu_out
);
  typedef enum logic [4:0] {
    NOP   = 5'b00000,
    ADD   = 5'b00001,
    SUB,
    XOR,
    OR,
    AND,
    SHL,
    SHR,
    SHLU,
    SHRU,
    SLT,
    SGT,
    AUI,
    AUIPC,
    MUL,
    DIV,
    REM
  } alu_operation_t;

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
      SHL: alu_out = alu_a << alu_b;
      // Shift Right
      SHR: alu_out = alu_a >> alu_b;
      // Another shift left
      SHLU: alu_out = alu_a <<< alu_b;
      // Another shift right
      SHRU: alu_out = alu_a >>> alu_b;
      // SLT
      SLT: alu_out = (alu_a < alu_b) ? 1 : 0;
      // SGT
      SGT: alu_out = (alu_a < alu_b) ? 1 : 0;
      // Add upper immediate
      AUI: alu_out = alu_a + (alu_b << 12);
      // Add upper immediate to PC
      AUIPC: alu_out = (pc - 4) + (alu_b << 12);
      // MUL
      MUL: alu_out = (alu_a * alu_b);
      DIV: alu_out = (alu_a / alu_b);
      REM: alu_out = (alu_a % alu_b);
      default: begin
        // NOP
        alu_out = 0;
      end


    endcase

  end
endmodule
