`include "./ctrl_def.v"

module EXT(
  input [15:0] Imm16,  //data to extend
  input [1:0] EXTOp,  
  
  output reg[31:0] Imm32  //extended result
  );
  
  initial 
  begin
    Imm32 = 32'b0;
  end
  
  always@(*)
  begin
    case(EXTOp)
      `EXTOP_ZERO:               //zero extend
        Imm32 = {16'b0,Imm16};
      `EXTOP_SIGN:               //sign extend
        Imm32 = {{16{Imm16[15]}},Imm16};
      `EXTOP_HIGH:               //extend higher
        Imm32 = {Imm16,16'b0};
      default:
        Imm32 = {16'b0,Imm16};
    endcase
  end
  
endmodule
        
