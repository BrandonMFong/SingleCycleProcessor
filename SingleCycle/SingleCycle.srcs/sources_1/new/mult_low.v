`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: Monday, September 9, 2019 7:06:17 PM
// Design Name: 
// Module Name: top_module
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

module mult_low

/*** PARAMETERS ***/
#(parameter
	INST_WL = 5,
	DATA_WL = 32,
	ADDR_WL = 5
)

/*** IN/OUT ***/
(
	// IN 
	input 					mux3sel,
	input [DATA_WL - 1 : 0]	pcreg,
							pcbranch,
	// OUT
	output reg [4 : 0] dout
);

	always @(*) 
	begin
		if(mux3sel) dout	= pcreg;
		else dout			= pcbranch;
	end 

endmodule