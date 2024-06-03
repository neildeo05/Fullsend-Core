module ForwardingUnit(mem_wb_ir, ex_mem_ir, id_ex_ir, ex_aluout, mem_aluout, mem_memout, f_rs1, f_rs2, fwd_1, fwd_2, f_en);
   // Combinational Logic to detect if we need to forward or not
   input logic [31:0] mem_wb_ir;
   input logic [31:0] ex_mem_ir;
   input logic [31:0] id_ex_ir;
   input logic [31:0] ex_aluout;
   input logic [31:0] mem_aluout;
   input logic [31:0] mem_memout;

   output logic       f_rs1 [1:0];
   output logic       f_rs2 [1:0];
   output logic [31:0] fwd_1;
   output logic [31:0] fwd_2;
   output logic        f_en;
   
   
   logic [6:0] mem_op;
   logic [6:0] ex_op;
   logic [6:0] id_op;
   logic [3:0] ex_rd;
   logic [3:0] mem_rd;
   logic [3:0] id_rs1;
   logic [3:0] id_rs2;
   
   logic ex_rs1_forward;
   logic ex_rs2_forward;
   logic mem_rs1_forward;
   logic mem_rs2_forward;
   
   
   assign mem_op = mem_wb_ir[6:0];
   assign mem_rd = mem_wb_ir[11:7];
   assign ex_op = ex_mem_ir[6:0];
   assign ex_rd = ex_mem_ir[11:7];
   assign id_op = id_ex_ir[6:0];
   assign id_rs1 = id_ex_ir[19:15];
   assign id_rs2 = id_ex_ir[24:20];
   assign f_rs1[0] = ex_rs1_forward;
   assign f_rs1[1] = mem_rs1_forward;
   assign f_rs2[0] = ex_rs2_forward;
   assign f_rs2[1] = mem_rs2_forward;
   assign f_en = ex_rs1_forward | ex_rs2_forward | mem_rs1_forward | mem_rs1_forward;
   
   always_comb begin
      if(f_rs1[0]) begin
         fwd_1 = ex_aluout;
         if(f_rs2[1]) begin
            fwd_2 = mem_aluout;
         end
         else fwd_2 = 31'bx;
      end
      else if(f_rs1[1]) begin
         fwd_1 = mem_aluout;
         if(f_rs2[0]) begin
            fwd_2 = ex_aluout;
         end
         else fwd_2 = 31'bx;
      end
      else begin
         fwd_1 = 31'bx;
         if(f_rs2[0]) begin
            fwd_2 = ex_aluout;
         end
         else if(f_rs2[1]) begin
            fwd_2 = mem_aluout;
            
         end
         else begin
            fwd_1 = 31'bx;
            fwd_2 = 31'bx;
         end
      end
      
      
   end
   
   always_comb begin
      if (ex_op != 0 & id_op != 0) begin
         if (ex_rd == id_rs1) begin
            if((ex_op[5] & ex_op[4]) | (!ex_op[5] & ex_op[4])) begin
     // If the op currently being executed is a reg-reg ALU or immediate
               ex_rs1_forward = 1;
               ex_rs2_forward = 0;
            end
            else begin
               ex_rs1_forward = 0;
               ex_rs2_forward = 0;
            end
         end
         else if (ex_rd == id_rs2) begin
            if(((ex_op[5] & ex_op[4])  | (!ex_op[5] & ex_op[4])) & (id_op[5] & id_op[4])) begin
        // If the op currently being executed is reg-reg ALU or imm and the inst being dispatched is a reg-reg ALU op
               ex_rs2_forward = 1;
               ex_rs1_forward = 0;
            end
            else begin
               ex_rs1_forward = 0;
               ex_rs2_forward = 0;
            end
         end
         else begin
            ex_rs1_forward = 0;
            ex_rs2_forward = 0;
         end
      end
      else begin
         ex_rs1_forward = 0;
         ex_rs2_forward = 0;
      end // else: !if(ex_op != 0 & id_op != 0)
     
     if (mem_op != 0 & id_op != 0) begin
        if(mem_rd == id_rs1) begin
           if(mem_op[5] | mem_op[4]) begin
     // If the op currently in mem stage is a reg-reg ALU or immediate
              mem_rs1_forward = 1;
              mem_rs2_forward = 0;
           end
           else begin
              mem_rs1_forward = 0;
              mem_rs2_forward = 0;
           end
           
        end
        else if (mem_rd == id_rs2) begin
        // If the op currently in mem stage is reg-reg ALU or imm and the inst being dispatched is a reg-reg ALU op
           if(mem_op[5] | mem_op[4] & (id_op[5] & id_op[4])) begin
              mem_rs2_forward = 1;
              mem_rs1_forward = 0;
           end
           else begin
              mem_rs1_forward = 0;
              mem_rs2_forward = 0;
           end
           
        end
        else begin
           mem_rs1_forward = 0;
           mem_rs2_forward = 0;
        end
     end // if (mem_op != 0 & id_op != 0)
     else begin
        mem_rs1_forward = 0;
        mem_rs2_forward = 0;
     end // else: !if(mem_op != 0 & id_op != 0)
     
   
      
      
   end
   




endmodule; // ForwardingUnit
