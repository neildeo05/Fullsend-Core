module Stage2 (
    input logic clk,
    input logic reset,
    input logic hazard,
    input logic [31:0] if_id_ir,
    input logic [31:0] if_id_npc,
    output logic [31:0] id_ex[4:0]
);
  //definition of pipeline register indices: a, b, npc, ir, imm
  typedef enum int {
    A_IDX   = 0,
    B_IDX   = 1,
    NPC_IDX = 2,
    IR_IDX  = 3,
    IMM_IDX = 4
  } stage_2_idx_e;

  logic long_immediate;
  // IR[2] contains the long_immediate bit. If it is high then the immediate is 21 bits, versus 11 bits
  assign long_immediate = if_id_ir[2];
  always @(posedge clk) begin
    if (reset) begin
      id_ex[A_IDX]   <= 0;
      id_ex[B_IDX]   <= 0;
      id_ex[NPC_IDX] <= 0;
      id_ex[IR_IDX]  <= 0;
      id_ex[IMM_IDX] <= 0;
    end else if (hazard) begin
      // If the hazard flag is high, then we ce-circulate NOPs
      id_ex[IR_IDX]  <= 0;
      id_ex[IMM_IDX] <= 0;
    end else begin
      id_ex[NPC_IDX] <= if_id_npc;
      id_ex[IR_IDX]  <= if_id_ir;
      // Checking to see which immediate we need:
      if (long_immediate) id_ex[IMM_IDX] <= $signed(if_id_ir[31:12]);
      else id_ex[IMM_IDX] <= $signed(if_id_ir[31:20]);
    end
  end
endmodule
