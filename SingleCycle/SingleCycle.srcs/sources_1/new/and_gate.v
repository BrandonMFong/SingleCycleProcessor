`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2019 06:22:22 PM
// Design Name: 
// Module Name: and_gate
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


module and_gate

/*** PARAMETERS ***/
#(parameter
    No_param = 0
 )
 
 /*** IN/OUT ***/
(
	// IN
	input din1, din2,
	
	// OUT
	output reg dout
);

    always @(*) dout = din1 & din2;
 
 
 
endmodule
