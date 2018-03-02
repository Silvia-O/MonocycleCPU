module RF(
  input clk,
  input RegWrite,
  
  input [4:0] RA1, //1st reg address to read
  input [4:0] RA2, //2nd reg address to read
  input [31:0] WA,  //reg address to write
  input [31:0] WD, //reg data to write
  
  output [31:0] RD1, //1st reg data to read
  output [31:0] RD2  //2nd reg data to read
  );
  
  reg[31:0] rf[31:0];
  integer i;
   
  initial
  begin
    for(i=0; i<32; i=i+1)
      rf[i] <= 0;
  end
  
  /*register write*/
  always@(posedge clk)
  begin
    if(WA != 0 && RegWrite)
        rf[WA] <= WD;       
    for(i=0; i<32; i=i+1)
      $display("rf[%d] = 0x%x", i, rf[i]);  //display the current rf condition
  end
  
   /*register read*/
  assign RD1 = rf[RA1];
  assign RD2 = rf[RA2];
  
endmodule
      
        
  