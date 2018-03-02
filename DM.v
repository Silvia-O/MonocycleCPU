module DM(
  input clk,
  input [31:0] din, //data to write back
  input MemWrite,
  input MemRead,
  input [31:0] addr,  //address to write back to
  
  output [31:0] dout //data to read
  );
  
  reg[31:0] mem[31:0];
  integer i;
  
  initial
  begin
    for(i=0; i<32; i=i+1)
      mem[i] = 32'b0;
  end
  
  /*write back data*/
  always@(posedge clk)
  begin
    if(MemWrite)
      mem[addr] <= din;
  end
  
  /*read data*/
  assign dout = mem[addr];
    
endmodule
      