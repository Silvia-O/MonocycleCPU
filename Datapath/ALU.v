`include "./ctrl_def.v"

module ALU(
  input [31:0] A,    //1st operand
  input [31:0] B,    //2nd operand
  input [1:0] ALUOp,
  
  output reg Zero,
  output reg[31:0] result 
  );
  
  initial 
  begin
    Zero = 0;
    result = 32'b0;
  end
  
  always@(*)
  begin
    case(ALUOp)
      `ALUOP_ADDU:
        result = A + B;
      `ALUOP_SUBU:
        result = A - B;
      `ALUOP_ORI:
        result = A | B;
      default: result = 0;
    endcase
    
    if(A == B)
      Zero = 1;
    else
      Zero = 0;
  end
  
endmodule
    
      
  
    
      
      
    
