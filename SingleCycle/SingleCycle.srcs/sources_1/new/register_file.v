	`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2019 04:35:05 PM
// Design Name: 
// Module Name: register_file
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

//READ FIRST MODE
module register_file

/*** PARAMETERS ***/
#(parameter
	ADDR_WL = 5,
	DATA_WL = 32
)

/*** IN/OUT ***/
(
	// IN 
	input clk, RFWE, rst,
	
	// connect this input from the data after your ALU
	input [DATA_WL - 1 : 0]	RFWD,	//RFWD
	
	input [ADDR_WL - 1 : 0]	RFRA1,	//RFRA1
							RFRA2,	//RFRA2
							RFWA,	//RFWA
	// OUT					
	output [DATA_WL - 1 : 0]RFRD1,	//RFRD1
							RFRD2	//RFRD2
							
);

	reg [DATA_WL - 1 : 0] MEM [0 : 2**ADDR_WL - 1];
	
	/* Default vals for register file */
	initial 
	begin
	   MEM[0]  = 32'b00000000000000000000000000000000; // $0
	   MEM[1]  = 32'b00000000000000000000000000000000; // $at
	   MEM[2]  = 32'b00000000000000000000000000000000; // $v0
	   MEM[3]  = 32'b00000000000000000000000000000000; // $v1
	   MEM[4]  = 32'b00000000000000000000000000000000; // $a0
	   MEM[5]  = 32'b00000000000000000000000000000000; // $a1
	   MEM[6]  = 32'b00000000000000000000000000000000; // $a2
	   MEM[7]  = 32'b00000000000000000000000000000000; // $a3
	   MEM[8]  = 32'b00000000000000000000000000000000; // $t0
	   MEM[9]  = 32'b00000000000000000000000000000000; // $t1
	   MEM[10] = 32'b00000000000000000000000000000000; // $t2
	   MEM[11] = 32'b00000000000000000000000000000000; // $t3
	   MEM[12] = 32'b00000000000000000000000000000000; // $t4
	   MEM[13] = 32'b00000000000000000000000000000000; // $t5
	   MEM[14] = 32'b00000000000000000000000000000000; // $t6
	   MEM[15] = 32'b00000000000000000000000000000000; // $t7
	   MEM[16] = 32'b00000000000000000000000000000000; // $s0
	   MEM[17] = 32'b00000000000000000000000000000000; // $s1
	   MEM[18] = 32'b00000000000000000000000000000000; // $s2
	   MEM[19] = 32'b00000000000000000000000000000000; // $s3
	   MEM[20] = 32'b00000000000000000000000000000000; // $s4
	   MEM[21] = 32'b00000000000000000000000000000000; // $s5
	   MEM[22] = 32'b00000000000000000000000000000000; // $s6
	   MEM[23] = 32'b00000000000000000000000000000000; // $s7
	   MEM[24] = 32'b00000000000000000000000000000000; // $t8
	   MEM[25] = 32'b00000000000000000000000000000000; // $t9
	   MEM[26] = 32'b00000000000000000000000000000000; // $k0
	   MEM[27] = 32'b00000000000000000000000000000000; // $k1
	   MEM[28] = 32'b00000000000000000000000000000000; // $gp
	   MEM[29] = 32'b00000000000000000000000000000000; // $sp
	   MEM[30] = 32'b00000000000000000000000000000000; // $fp
	   MEM[31] = 32'b00000000000000000000000000000000; // $ra
	end
	
	always @ (posedge clk)
	begin
		if(!rst)
		begin
		  if(RFWE) MEM[RFWA] <= RFWD;
	    end
	end  
	
	/*** READ FIRST ***/
	assign RFRD1 = MEM[RFRA1];
	assign RFRD2 = MEM[RFRA2];
	
endmodule