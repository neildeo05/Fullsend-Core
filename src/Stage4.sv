module Stage4 (
    input logic clk,
    input logic reset,
    input logic load_inst,
    input logic reg_dest,
    input logic [31:0] ex_mem_ir,
    input logic [31:0] ex_mem_alu_output,
    input logic [31:0] ex_mem_b,
    input logic sb_en[3:0],
    input logic [31:0] sb_fwd,
    output logic [31:0] mem_wb[4:0],
    output logic [31:0] mem_address,
    output logic [31:0] mem_input,  /*mem_output, */
    output logic mem_enable,
    output logic mem_r_w
);

  assign mem_address = ex_mem_alu_output;
  assign mem_input = (e_sb_en) ? e_sb_fwd : reg_b_in;
  //   assign mem_output = mem_wb[2];
  assign mem_enable = load_inst;
  assign mem_r_w = reg_dest;

  logic [31:0] reg_b_in;
  logic [31:0] e_sb_fwd;
  logic        e_sb_en;

  always_comb begin
    if (sb_en[2] | sb_en[3]) reg_b_in = sb_fwd;
    else reg_b_in = ex_mem_b;
  end

  always @(posedge clk) begin
    e_sb_en   <= sb_en[3];
    e_sb_fwd  <= reg_b_in;
    mem_wb[0] <= ex_mem_ir;
    mem_wb[1] <= ex_mem_alu_output;
    mem_wb[3] <= load_inst;
    mem_wb[4] <= reg_dest;
  end


endmodule
