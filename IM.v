module IM(
  input [9:0] addr,
  output reg[31:0] dout
  ); 
  
  reg[31:0] InstrMem[31:0];
  reg[31:0] instr_temp;
  integer fd, cnt, pointer;
   
   /*get instruction hex code*/
  initial
  begin
    fd = $fopen("./test.txt","r"); 
    for(pointer = 0; pointer < 32; pointer = pointer+1)
    begin
      cnt = $fscanf(fd, "%x", instr_temp);
      InstrMem[pointer] = instr_temp;
      //display the instructions
      $display("IM read instruction %d: 0x%x", pointer, instr_temp);   
    end
     $fclose(fd);
  end

  always@(*)
  begin
    dout <= InstrMem[addr];  
  end

endmodule
