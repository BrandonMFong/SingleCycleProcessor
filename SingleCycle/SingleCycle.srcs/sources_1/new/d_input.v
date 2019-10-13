`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: Sunday, September 1, 2019 12:26:03 PM
// Design Name: 
// Module Name: d_input
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

module d_input //This is your input module

/*** PARAMETERS ***/
#(parameter
    DATA_WL = 32,
	ADDR_WL = 6
);

/*** IN/OUTPUT ***/
(
	// IN
	input clk,
    input [DATA_WL - 1:0]	IN,
	// OUT
	output					we,  //telling system there are instructions coming
    output [DATA_WL - 1:0]	OUT
);

/*** TODO ***/
//How am I going to get a set of instructions and input it to
//the data and instruction memory
//I think I am getting the instructions serially


endmodule