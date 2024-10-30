// branch_cond corresponds to EX/MEM.cond
// pc_offfset_branch corresponds to EX/MEM.ALUOutput
module Stage1 (
    input logic clk,
    input logic reset,
    input logic [31:0] curr_inst,
    input logic branch_cond,
    input logic [31:0] pc_offset_branch,
    input logic hazard,
    output logic [31:0] if_id[1:0],
    output logic [31:0] pc,
    output logic [1:0] stall_counter
);
  typedef enum int {
    IR_IDX  = 0,
    NPC_IDX = 1
  } stage_1_idx_e;
  logic [31:0] npc;
  logic [31:0] ir;
  assign ir = curr_inst;
  always @(posedge clk) begin
    if (reset) begin
      pc <= 0;
      npc <= 0;
      if_id[IR_IDX] <= 0;
      if_id[NPC_IDX] <= 0;
    end else begin
      if (branch_cond) begin
        npc <= pc_offset_branch;
        pc  <= pc_offset_branch;
      end else if (hazard) begin
        // If a hazard, keep recirculating this inst
        npc <= npc;
        pc <= pc;
        stall_counter <= stall_counter + 1;
      end else begin
        stall_counter <= 0;
        npc <= npc + 4;
        pc <= pc + 4;
      end
    end
  end
  assign if_id[IR_IDX]  = ir;
  assign if_id[NPC_IDX] = npc;
endmodule
