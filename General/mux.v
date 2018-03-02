module mux (
  input control,
  input [31:0] d0,
  input [31:0] d1,
  output [31:0] out
  );
 
  assign out = control ? d1 : d0;
  
endmodule

