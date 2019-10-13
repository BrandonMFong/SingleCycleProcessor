`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2019 01:09 PM
// Design Name: 
// Module Name: adder
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

/*** ADDER FOR PC ***/
module adder0 

/*** PARAMETERS ***/
#(parameter
    DATA_WL = 32
)

/*** IN/OUT ***/
(
    // IN
	input                      rst,
	input [DATA_WL - 1 : 0]    din,
	
	// OUT 
	output reg [DATA_WL - 1 : 0]   dout
);

    always @(*) 
    begin
        if(rst) dout = 0;
        dout = din + 1;
    end
endmodule