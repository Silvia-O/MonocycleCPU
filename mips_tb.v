module mips_tb();
  `timescale 1ns / 1ps
  reg clk;
  reg reset;

  initial
  begin
    clk = 0;
    reset = 1;
    
    //wait 50ns for global reset to finish
    #50; 
    clk = ~clk;
    #50;
    reset = 0;
    
    forever #50  
    begin
      clk = ~clk;
    end
  end
  
  mips mips(clk, reset);
endmodule
