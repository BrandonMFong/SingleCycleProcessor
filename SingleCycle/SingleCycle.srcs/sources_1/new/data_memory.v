`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: Sunday, September 1, 2019 12:03:39 PM
// Design Name: 
// Module Name: data_memory
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

module data_memory

/*** PARAMETERS ***/
#(parameter
	DATA_WL = 32,
	ADDR_WL = 32
)

/*** IN/OUT ***/
(
	// IN
	input clk, DMWE, rst,
	input [DATA_WL - 1 : 0]    DMA,
	input [DATA_WL - 1 : 0]    DMWD,
	
	// OUT
	output [DATA_WL - 1 : 0] DMRD
	
);

	/*** DATA MEM DECLARATION ***/
	reg [DATA_WL - 1 : 0] data_mem [0 : 2**31]; // Note you are passing 5 to ADDR_WL
	
	initial $readmemb ("data_mem.mem", data_mem); 
	
	/*** TODO intialized data as per assignment ***/
	/* INITIAL VALUES IN DATA MEM */
//    initial
//    begin
//        data_mem[0]= val0;
//        data_mem[1]= val1;
//        data_mem[2]= val2;
//        data_mem[3]= val3;
//        data_mem[4]= val4;
//    end
    
	always @ (posedge clk)
	begin
		if(DMWE) data_mem[DMA] <= DMWD;
	end
	
	assign DMRD = data_mem[DMA];
	
endmodule