module ForwardingUnit(mem_wb_ir, ex_mem_ir, id_ex_ir, ex_aluout, mem_aluout, mem_memout, f_rs1, f_rs2, fwd_1, fwd_2, sb_fwd_2, f_en);
   // Combinational Logic to detect if we need to forward or not
   input logic [31:0] mem_wb_ir;
   input logic [31:0] ex_mem_ir;
   input logic [31:0] id_ex_ir;
   input logic [31:0] ex_aluout;
   input logic [31:0] mem_aluout;
   input logic [31:0] mem_memout;

   output logic       f_rs1 [1:0];
   output logic       f_rs2 [3:0];
   output logic [31:0] fwd_1;
   output logic [31:0] fwd_2;
   output logic [31:0] sb_fwd_2;
   output logic        f_en;
   
   
   logic [6:0] mem_op;
   logic [6:0] ex_op;
   logic [6:0] id_op;
   logic [4:0] ex_rd;
   logic [4:0] mem_rd;
   logic [4:0] id_rs1;
   logic [4:0] id_rs2;
   logic [4:0] ex_rs1;
   logic [4:0] ex_rs2;
   logic ex_rs1_forward;
   logic ex_rs2_forward;
   logic mem_rs1_forward;
   logic mem_rs2_forward;
   assign f_en = ex_rs1_forward | ex_rs2_forward | mem_rs1_forward | mem_rs1_forward;
   
   
   assign mem_op = mem_wb_ir[6:0];
   assign mem_rd = mem_wb_ir[11:7];
   assign ex_op = ex_mem_ir[6:0];
   assign ex_rd = ex_mem_ir[11:7];
   assign id_op = id_ex_ir[6:0];
   assign id_rs1 = id_ex_ir[19:15];
   assign id_rs2 = id_ex_ir[24:20];
   assign ex_rs1 = ex_mem_ir[19:15];
   assign ex_rs2 = ex_mem_ir[24:20];
   assign f_rs1[0] = ex_rs1_forward;
   assign f_rs1[1] = mem_rs1_forward;
   assign f_rs2[0] = ex_rs2_forward;
   assign f_rs2[1] = mem_rs2_forward;
   assign f_rs2[2] = m_storeb_en;
   assign f_rs2[3] = e_storeb_en;
   logic [31:0] mem_out;
   

   logic [3:0] fcheck;

   assign fcheck = '{f_rs1[0], f_rs1[1], f_rs2[0], f_rs2[1]};
   always_comb begin
      case(fcheck) 
        4'b0000: begin
           // no forward
           fwd_1 = 0;
           fwd_2 = 0;
        end
        4'b0001: begin
           // forward mem_rs2
           fwd_1 = 0;
           fwd_2 = mem_aluout;
        end
        4'b0010: begin
           // forward ex_rs2
           fwd_1 = 0;
           fwd_2 = ex_aluout;
        end
        4'b0011: begin
           // Since we need to forward both, forward the ex
           fwd_1 = 0;
           fwd_2 = ex_aluout;
        end
        4'b0100: begin
           //forward mem_rs1
           fwd_1 = mem_out;
           fwd_2 = 0;
        end
        4'b0101: begin
           //forward mem_rs1 and mem_rs2
           fwd_1 = mem_out;
           fwd_2 = mem_aluout;
        end
        4'b0110: begin
           //forward mem_rs1, and ex_rs2
           fwd_1 = mem_out;
           fwd_2 = ex_aluout;
        end
        4'b0111: begin
           // forward mem_rs1 and (ex_rs2 over mem_rs2)
           fwd_1 = mem_out;
           fwd_2 = ex_aluout;
        end
        4'b1000: begin
           //forward ex_rs1
           fwd_1 = ex_aluout;
           fwd_2 = 0;
        end
        4'b1001: begin
           // forward ex_rs1 and mem_rs2
           fwd_1 = ex_aluout;
           fwd_2 = mem_aluout;
        end
        4'b1010: begin
           //forward ex_rs1 and ex_rs2
           fwd_1 = ex_aluout;
           fwd_2 = ex_aluout;
        end
        4'b1011: begin
           // forward ex_rs1 and ex_rs2
           fwd_1 = ex_aluout;
           fwd_2 = ex_aluout;
        end
        4'b1100: begin
           // forward ex_rs1
           fwd_1 = ex_aluout;
           fwd_2 = 0;
        end
        4'b1101: begin
           // forward ex_rs1 and mem_rs2
           fwd_1 = ex_aluout;
           fwd_2 = mem_aluout;
        end
        4'b1110: begin
           // forward ex_rs1 and ex_rs2
           fwd_1 = ex_aluout;
           fwd_2 = ex_aluout;
        end
        4'b1111: begin
           // forward ex_rs1 and ex_rs2
           fwd_1 = ex_aluout;
           fwd_2 = ex_aluout;
        end
      endcase // case (fcheck)
   end
   
   logic ex_rs1_match;
   logic ex_rs2_match;
   assign ex_rs1_match = (ex_rd == id_rs1) & (ex_op != 0 & id_op != 0);
   assign ex_rs2_match = (ex_rd == id_rs2) & (ex_op != 0 & id_op != 0);
   
   // EX-Forward Rs1 
   always_comb begin
      if (ex_rs1_match) begin
         if((ex_op[5] & ex_op[4]) | (!ex_op[5] & ex_op[4])) begin
            ex_rs1_forward = 1;
         end
         else ex_rs1_forward = 0;
      end
      else ex_rs1_forward = 0;
   end // always_comb

   
   // EX-Forward Rs2 
   always_comb begin
      if (ex_rs2_match) begin
         if(((ex_op[5] & ex_op[4])  | (!ex_op[5] & ex_op[4])) & (id_op[5] & id_op[4])) ex_rs2_forward = 1;
         else ex_rs2_forward = 0;
      end
      else ex_rs2_forward = 0;
   end
   logic mem_rs1_match;
   logic mem_rs2_match;
   assign mem_rs1_match = (mem_rd == id_rs1) & (mem_op != 0 & id_op != 0)& !(mem_op[5] & !mem_op[4]);
   assign mem_rs2_match = (mem_rd == id_rs2) & (mem_op != 0 & id_op != 0)& !(mem_op[5] & !mem_op[4]);
   
   // MEM-Forward Rs1
   logic mem_is_load;
   assign mem_is_load= (!mem_op[5] & !mem_op[4]);
   always_comb begin
      if(mem_rs1_match) begin
         if(mem_is_load) begin
            mem_rs1_forward = 1;
            mem_out = mem_memout;
         end
         else begin
            mem_rs1_forward = 1;
            mem_out = mem_aluout;
         end
      end
      else begin
         mem_rs1_forward = 0;
         mem_out = 0;
      end // else: !if(mem_rs1_match)
      
   end
   
   // MEM-Forward Rs2 
   always_comb begin
      if(mem_rs2_match) begin
         if(mem_op[5] | mem_op[4] & (id_op[5] & id_op[4])) mem_rs2_forward = 1;
         else mem_rs2_forward = 0;
      end
      else mem_rs2_forward = 0;
   end

   logic m_storeb_en;
   assign m_storeb_en = (ex_op[5] & !ex_op[4]) & (mem_rd == ex_rs2);
   logic e_storeb_en;
   assign e_storeb_en = (id_op[5] & !id_op[4]) & (mem_rd == id_rs2);
   logic ex_is_load;
   
   
   assign ex_is_load =  (!ex_op[5] & !ex_op[4]);
   
   // Store Bypassing
   always_comb begin
      // Make sure we are not forwarding from ex
      // We want mem_wb_ir to contain a store instruction
      // We want the previous instruction to be anything
      if(m_storeb_en | e_storeb_en) begin
         if(mem_is_load) sb_fwd_2 = mem_memout;
         else sb_fwd_2 = mem_aluout;
      end
      else sb_fwd_2 = 0;
   end
   
   




endmodule; // ForwardingUnit
