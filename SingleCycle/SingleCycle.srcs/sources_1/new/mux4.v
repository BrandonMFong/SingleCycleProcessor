`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2019 06:57:09 PM
// Design Name: 
// Module Name: mux4
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


module mux4

/*** PARAMETERS ***/
#(parameter
	INST_WL = 5,
	DATA_WL = 32,
	ADDR_WL = 5
)

/*** IN/OUT ***/
(
	// IN 
	input 			        mux4sel,
	                        rst,
	input [DATA_WL - 1 : 0]	RFRD1, /* TODO check wires */
							RFRD2,
	// OUT
	output reg [DATA_WL - 1 : 0] dout
);

	always @(*) 
	begin
	    if(rst) dout        = 0;
	    else
	    begin
            if(mux4sel) dout	= RFRD1; //regular
            else dout			= RFRD2; // shift function
        end
	end 
endmodule
