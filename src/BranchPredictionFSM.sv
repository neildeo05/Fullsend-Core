module BranchPredictionFSM(
  input logic clk,
  input logic reset,
  input logic taken,
  output logic [1:0] states
  );
  /*
  00 -> Strongly Not Taken
  01 -> Weakly Not Taken
  10 -> Weakly Taken
  11 -> Strongly Taken
  */
  always_ff @(posedge clk) begin
    if(reset) begin
      states <= 2'b00;
    end
    else begin
      case({taken, states})
        3'b000: begin
          states <= 2'b00;
        end
        3'b001: begin
          states <= 2'b00;
        end
        3'b010: begin
          states <= 2'b01;
        end
        3'b011: begin
          states <= 2'b10;
        end
        3'b100: begin
          states <= 2'b01;
        end
        3'b101: begin
          states <= 2'b10;
        end
        3'b110: begin
          states <= 2'b11;
        end
        3'b111: begin
          states <= 2'b11;
        end
      endcase
    end
  end
endmodule
