`include "./ctrl_def.v"

module ALU(
  input [31:0] A,    //1st operand
  input [31:0] B,    //2nd operand
  input [2:0] ALUOp,
  
  output reg Zero,
  output reg[31:0] result 
  );
  
  initial 
  begin
    Zero = 0;
    result = 32'b0;
  end
  
  integer dif;
  initial  dif = A - B;
  
  always@(*)
  begin
    case(ALUOp)
      `ALUOP_ADD:
        result = A + B;
      `ALUOP_SUB:
        result = A - B;
      `ALUOP_OR:
        result = A | B;
      `ALUOP_AND:
        result = A & B;
      `ALUOP_NOR:
        result = ~ (A | B);
      `ALUOP_SLT:
        result = ((A[31] && !B[31]) || ((!(A[31] ^ B[31])) && dif[31]))? 32'h1 : 32'h0;

      default: result = 0;
    endcase
    
    if(A == B)
      Zero = 1;
    else
      Zero = 0;
  end
  
endmodule
    
      
  
    
      
      
    
