`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: Saturday, August 31, 2019 1:55:32 PM
// Design Name: 
// Module Name: instruction_memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module instruction_memory

/*** PARAMETERS ***/
#(parameter
	DATA_WL = 32,
	ADDR_WL = 32 //you're passing through 5 from the top mod
)

/*** IN/OUT ***/
(
	// IN
	input                   rst,
	input [31 : 0] addr, //Instructions
	
	// OUT
	/*** INSTRUCTION PARTITIONS  ***/
	output reg [5 : 0] 		OP,
							FUNCT,
	output reg [4 : 0]		RS,
							RT,
							RD,
							SHAMT,
	output reg [15 : 0]		IMMED, //immediates
	output reg [25 : 0]		JUMP //jump value
	
);
	
	reg [DATA_WL - 1 : 0] inst;
	
	/*** INSTRUCTION MEM DECLARATION ***/
	reg [DATA_WL - 1 : 0] inst_mem [0 : 2**31];
	
	initial 
	begin
	   $readmemb("parte_instmem.mem", inst_mem);
	   //inst_mem[0] = 32'b
//	   inst_mem[0] = 32'b10001100000000000000000000000000; //LW $t0 0($0)
//       inst_mem[1] = 32'b10001100000000010000000000000000; //LW $t1 1($0)
//       inst_mem[2] = 32'b10001100000000100000000000000000; //LW $t2 2($0)
//       inst_mem[3] = 32'b10001100000000110000000000000000; //LW $t3 3($0)
	end
	
	always @(*)
	begin
		if(rst) 
		begin
		    inst = 0;
            OP		= inst[31 : 26]; //might be {} 
            FUNCT	= inst[5 : 0];
            RS		= inst[25 : 21];
            RT		= inst[20 : 16];
            RD		= inst[15 : 11];
            SHAMT	= inst[10 : 6];
            IMMED	= inst[15 : 0];
            JUMP	= inst[25 : 0];
		end
		else
		begin
            inst = inst_mem[addr];
            OP		= inst[31 : 26]; //might be {} 
            FUNCT	= inst[5 : 0];
            RS		= inst[25 : 21];
            RT		= inst[20 : 16];
            RD		= inst[15 : 11];
            SHAMT	= inst[10 : 6];
            IMMED	= inst[15 : 0];
            JUMP	= inst[25 : 0];	
		end
	end 
	
endmodule

