module PC(
  input clk,
  input reset,
  input [31:0] din,
  
  output reg[31:0] dout
  );
  
  always@(posedge clk or posedge reset)
  begin
    if(reset) 
      dout <= 32'h3000;   //initial pc 
    else 
      dout <= din;        //renew pc
      $display(" PC_current :0x%x ", dout); //display the current pc
  end

endmodule