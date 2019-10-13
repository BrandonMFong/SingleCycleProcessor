`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: Thursday, September 5, 2019 4:52:11 PM
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

module mux0

/*** PARAMETERS ***/
#(parameter
	INST_WL = 5,
	DATA_WL = 32,
	ADDR_WL = 5
)

/*** IN/OUT ***/
(
	// IN 
	input 			mux0sel,
	                rst,
	input [4 : 0]	RT,
					RD,
	// OUT
	output reg [4 : 0] dout
);

	always @(*) 
	begin
	    if(rst) dout = 0;
	    else
	    begin
            if(mux0sel) dout	= RD;
            else dout			= RT;
        end
	end 

endmodule