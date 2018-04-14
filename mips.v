`include "./ctrl_def.v"
`include "./instr_def.v"
`include "./global_def.v"
`include "./ALU.v"
`include "./IM.v"
`include "./DM.v"
`include "./EXT.v"
`include "./PC.v"
`include "./RF.v"

module mips(
  input clk,
  input reset
  );
   
    
  wire[31:0]	pc_current;
  wire[31:0]	pc_new;
  wire[31:0]	instr;
  wire[31:0] rf_rd1;
  wire[31:0] rf_rd2;
  wire[31:0]	alu_result;
  wire[31:0]	dm_rd;
  wire[31:0]	ext_result;
	wire[31:0]	pc_temp;
	wire[31:0]	pc_add4;
	wire[31:0]	pc_branch;
	wire[31:0]	rf_ra;
	wire[31:0]	rf_final_wa;
	wire[31:0] rf_final_wd;   
	wire[31:0]	alu_srcA;
	wire[31:0]	alu_srcB;
	wire	Zero, Zero2;
	wire[31:0] memtoreg_data; 
  //SIGNAL
  wire RegDst;
  wire ALUSrc;
  wire MemtoReg;
  wire RegWrite;
  wire MemRead;
  wire MemWrite;
  wire Branch;
  wire Jump;
  wire[2:0] ALUOp;
  wire[1:0] EXTOp;  
  
  assign alu_srcA = rf_rd1;
  assign pc_add4 = pc_current + 4;
  
  //-----------------Link Modules-------------------//
  
  /*CTRL
  module ctrl(
  input clk,
  input reset,
  
  input [5:0] OP,
  input [5:0] Funct,
  input zero,
  
  output reg RegDst,
  output reg ALUSrc,
  output reg MemtoReg,
  output reg RegWrite,
  output reg MemRead,
  output reg MemWrite,
  output reg Branch,
  output reg Jump,
  output reg[1:0] ALUOp,
  output reg[1:0] EXTOp 
  );*/
  ctrl ctrl(clk, reset, instr[31:26], instr[5:0], zero, RegDst, ALUSrc, MemtoReg, 
  RegWrite, MemRead, MemWrite, Branch, Jump, ALUOp, EXTOp);
 
 
  /*ALU
  module ALU(
  input [31:0] A,    //1st operand
  input [31:0] B,    //2nd operand
  input [1:0] ALUOp,
  
  output reg Zero,                       
  output reg[31:0] result 
  );*/
  ALU pc_branch_add(pc_add4, {ext_result[29:0],2'b00}, `ALUOP_ADD, Zero2, pc_branch); //branch adder
  ALU dm_addr_alu(alu_srcA, alu_srcB, ALUOp, Zero, alu_result);
  
  
  /*DM 
  module DM(
  input clk,
  input [31:0] din, //data to write back
  input MemWrite,
  input MemRead,
  input [31:0] addr,  
  
  output [31:0] dout //data to read
  );*/
  DM dm(clk, rf_rd2, MemWrite, MemRead, alu_result, dm_rd);
 
  
  /*EXT
  module EXT(
  input [15:0] Imm16,  //data to extend
  input [1:0] EXTOp,  
  
  output reg[31:0] Imm32  //extended result
  );*/
  EXT ext(instr[15:0], EXTOp, ext_result);
 
  
  /*IM
  module IM(
  input [9:0] addr,
  output reg[31:0] dout
  ); */
  IM im(pc_current[11:2], instr);
  
  
  /*PC
  module PC(
  input clk,
  input reset,
  input [31:0] din,
  
  output reg[31:0] dout
  );*/
  PC pc(clk, reset, pc_new, pc_current);
   
   
  /*RF
  module RF(
  input clk,
  input RegWrite,
  
  input [4:0] RA1, //1st reg address to read
  input [4:0] RA2, //2nd reg address to read
  input [31:0] WA,  //reg address to write
  input [31:0] WD, //reg data to write
  
  output [31:0] RD1, //1st reg data to read
  output [31:0] RD2  //2nd reg data to read
  );*/
  RF rf(clk, RegWrite, instr[25:21], instr[20:16], rf_final_wa, rf_final_wd, rf_rd1, rf_rd2);


  /*MUX
  module mux (
  input control,
  input [31:0] d0,
  input [31:0] d1,
  output [31:0] out
  );*/
  mux pc_branch_mux(Branch & Zero, pc_add4, pc_branch, pc_temp);
  mux regwrite_addr_mux(RegDst, {27'b0,instr[20:16]}, {27'b0,instr[15:11]}, rf_ra);
  mux alu_src_mux(ALUSrc, rf_rd2, ext_result, alu_srcB);
  mux memtoreg_mux(MemtoReg, alu_result, dm_rd, memtoreg_data);
  mux jal_addr_mux(Jump, rf_ra, 31, rf_final_wa);
  mux jal_data_mux(Jump, memtoreg_data, pc_add4, rf_final_wd); 
  mux jal_pc_mux(Jump, pc_temp, {pc_add4[31:28], instr[25:0], 2'b00}, pc_new);
  
endmodule