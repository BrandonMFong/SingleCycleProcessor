`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2019 04:17:48 PM
// Design Name: 
// Module Name: jump
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


module jump

/*** PARAMETERS ***/
#(parameter
	JUMP_WL = 26,
	DATA_WL = 32
)

/*** IN/OUT ***/
(
	// IN
	input                   rst,
	input [JUMP_WL - 1 : 0] JUMP,
	input [DATA_WL - 1 : 0] PC,
	
	// OUT
	output reg [DATA_WL - 1 : 0] jaddr
);

    always @(*)
    begin
        if(rst) jaddr = 0;
        else jaddr = {PC[31:26],JUMP};
    end
    
endmodule
