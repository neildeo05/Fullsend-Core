// System Verilog Package to hold enumerations used across files:
// Specifically:
//  - ALU operations
//  - TODO: Instruction Funct3
//  - TODO: Instruction Funct7
//   NOP   = 5'b00000,
//   ADD   = 5'b00001,
//   SUB   = 5'b00010,
//   XOR   = 5'b00011,
//   OR    = 5'b00100,
//   AND   = 5'b00101,
//   SHL   = 5'b00110,
//   SHR   = 5'b00111,
//   SHLU  = 5'b01000,
//   SHRU  = 5'b01001,
//   SLT   = 5'b01010,
//   SLTU  = 5'b01011,
//   AUI   = 5'b01100,
//   AUIPC = 5'b01101,
//   MUL   = 5'b01110,
//   DIV   = 5'b01111,
//   REM   = 5'b10000
package inst_pkg;
  typedef enum logic [4:0] {
    NOP = 5'b00000,
    ADD,
    SUB,
    XOR,
    OR,
    AND,
    SLL,
    SRL,
    SRA,
    SLT,
    SLTU,
    AUI,
    AUIPC,
    MUL,
    MULH,
    MULHSU,
    MULHU,
    DIV,
    DIVU,
    REM,
    REMU
  } alu_operation_t;
endpackage
