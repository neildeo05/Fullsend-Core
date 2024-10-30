module Regfile (
    input logic clk,
    input logic reset,
    input logic neg_enable,
    input logic reg_r_w,
    input logic [4:0] reg_wa,
    input logic [31:0] wa_data,
    input logic [4:0] reg_a,
    input logic [4:0] reg_b,
    output logic [31:0] ra_data,
    output logic [31:0] rb_data,
    output logic [31:0] reg_array[31:0]
);
  assign reg_array[0] = 0;
  always @(posedge clk, negedge clk) begin
    if (reset) begin
      ra_data <= 0;
      rb_data <= 0;
    end
    if (clk) begin
      if (!neg_enable) begin
        reg_array[reg_wa] <= wa_data;
      end
    end else begin
      ra_data <= reg_array[reg_a];
      rb_data <= reg_array[reg_b];
    end
  end



endmodule
