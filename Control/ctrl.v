`include "./ctrl_def.v"
`include "./instr_def.v"

module ctrl(
  input clk,
  input reset,
  
  input [5:0] OP,
  input [5:0] Funct,
  
  output reg RegDst,
  output reg ALUSrc,
  output reg MemtoReg,
  output reg RegWrite,
  output reg MemRead,
  output reg MemWrite,
  output reg Branch,
  output reg Jump,
  output reg[1:0] ALUOp
  );
  
  initial
  begin
    RegDst = 0;
    ALUSrc = 0;
    MemtoReg = 0;
    RegWrite = 0;
    MemRead = 0;
    MemWrite = 0;
    Branch = 0;
    Jump = 0;
  end
  
  always @(*)
  begin
    case(OP)
      `OP_RTYPE:
      begin
        case(Funct)
          `FUNCT_ADDU: ALUOp = `ALUOP_ADDU;
          `FUNCT_SUBU: ALUOp = `ALUOP_SUBU;
        endcase
        RegDst = 1;
        ALUSrc = 0;
        MemtoReg = 0;
        RegWrite = 1;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        Jump = 0;
      end
      
      `OP_ORI:
      begin
        ALUOp = `ALUOP_ORI;
        RegDst = 0;
        ALUSrc = 1;
        MemtoReg = 0;
        RegWrite = 1;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        Jump = 0;
      end
      
      `OP_LW:
      begin
        ALUOp = `ALUOP_ADDU;
        RegDst = 0;
        ALUSrc = 1;
        MemtoReg = 1;
        RegWrite = 1;
        MemRead = 1;
        MemWrite = 0;
        Branch = 0;
        Jump = 0;
      end
      
      `OP_SW:
      begin
        ALUOp = `ALUOP_ADDU;
        RegDst = 0;
        ALUSrc = 1;
        MemtoReg = 0;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 1;
        Branch = 0;
        Jump = 0;
      end
      
      `OP_BEQ:
      begin
        RegDst = 0;
        ALUSrc = 0;
        MemtoReg = 0;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        Jump = 0;
      end
      
      `OP_JAL:
      begin
        RegDst = 0;
        ALUSrc = 0;
        MemtoReg = 0;
        RegWrite = 1;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        Jump = 1;
      end
      
      default:
      begin
        RegDst = 0;
        ALUSrc = 0;
        MemtoReg = 0;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        Jump = 0;
      end
    endcase
  end
endmodule
      
  