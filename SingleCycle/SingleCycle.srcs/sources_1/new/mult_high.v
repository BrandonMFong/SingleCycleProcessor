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

module mult_high

/*** PARAMETERS ***/
#(parameter
	DATA_WL = 32,
)

/*** IN/OUT ***/
(
	// IN 
	input 					mult_high_sel,
	// OUT
	output reg [4 : 0] dout
);

	always @(*) 
	begin
		if(mux3sel) dout	= pcreg;
		else dout			= pcbranch;
	end 

endmodule