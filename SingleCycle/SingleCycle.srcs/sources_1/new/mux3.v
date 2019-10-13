`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: Saturday, September 7, 2019 9:03:06 AM
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

module mux3

/*** PARAMETERS ***/
#(parameter
	INST_WL = 5,
	DATA_WL = 32,
	ADDR_WL = 5
)

/*** IN/OUT ***/
(
	// IN 
	input                   rst,
	input [3 : 0]			mux3sel,
	input [DATA_WL - 1 : 0]	pcreg,
							pcbranch,
							pcjump,
	// OUT
	output reg [DATA_WL - 1 : 0] dout
);

	always @(*) 
	begin
	    if(rst) dout = 0;
	    else
	    begin
            case(mux3sel) 
                0:
                begin
                    dout = pcbranch;
                    
                end
                1: 
                begin
                    dout = pcreg;
                end
                2:
                begin
                    dout = pcjump;
                end
                default dout = 1'bx;
            endcase
        end
	end 

endmodule