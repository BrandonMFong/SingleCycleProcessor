`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: Tuesday, September 3, 2019 4:43:29 PM
// Design Name: 
// Module Name: register_file
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

module sign_extension

/*** PARAMETERS ***/
#(parameter
	IMMED_WL = 16,
	DATA_WL = 32
)

/*** IN/OUT ***/
(
	// IN
	input                        rst,
	input [16 : 0]               IMMED,
	
	// OUT
	output reg [DATA_WL - 1 : 0] SIGNED_IMMED
);

	always @ (*)
	begin
		if(rst) SIGNED_IMMED = 0;
		else
		begin
            if(IMMED[IMMED_WL - 1]) 
            begin
                SIGNED_IMMED[DATA_WL - 1 : 16] = 16'b1111111111111111;
                SIGNED_IMMED[IMMED_WL - 1 : 0] = IMMED;
            end 
            else 
            begin
                SIGNED_IMMED[DATA_WL - 1 : 16] = 16'b0000000000000000;
                SIGNED_IMMED[IMMED_WL - 1 : 0] = IMMED;
            end
		end
	end

endmodule