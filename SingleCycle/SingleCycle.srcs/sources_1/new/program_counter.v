`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2019 01:09 PM
// Design Name: 
// Module Name: program_counter
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

module program_counter

/*** PARAMETERS ***/
#(parameter
	DATA_WL = 32
)

/*** IN/OUT ***/
(
	// IN 
	input clk, rst,
	input [DATA_WL - 1 : 0]		pc_in,
	// OUT
	output [DATA_WL - 1 : 0]	pc_out
);
	
	// initial pc should start at 0
	reg [DATA_WL - 1 : 0] pc;
	
	always @ (posedge clk) 
	begin
	   if(rst) pc <= 0;
	   else pc <= pc_in;
	end
	
	assign pc_out = pc;
	
endmodule