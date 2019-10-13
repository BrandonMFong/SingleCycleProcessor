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

module mux1

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
	input [3 : 0]			mux1sel,
	input [4 : 0]			SHAMT,
	input [DATA_WL - 1 : 0]	SIGNED_IMMED,
	                        DT,
	
	// OUT
	output reg [31 : 0] dout
);

	always @(*) 
	begin
	    if(rst) dout = 0;
	    else
	    begin
            case(mux1sel)
                0:
                begin
                    dout = DT;
                end
                1:
                begin
                    dout = SIGNED_IMMED;
                end
                2:
                begin
                    dout = SHAMT;
                end
            endcase 
        end
	end 

endmodule