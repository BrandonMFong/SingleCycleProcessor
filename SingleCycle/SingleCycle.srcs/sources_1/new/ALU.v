`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2019 04:31:36 PM
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

/*** QUESTIONS ***/
//What is in the regisiter in a register file, the address?

module ALU

/*** PARAMETERS ***/
#(parameter
    // WORD LENGTH
	DATA_WL    = 32,
	ADDR_WL    = 5,
	SEL_WL     = 3,
	
	
    // ALU
	ALU_IDLE               = 3'b000,
	ALU_LW_SW_ADD_ADDI     = 3'b001,
	ALU_SUB_BRANCH         = 3'b010,
	ALU_SLLV               = 3'b011,
	ALU_SRAV               = 3'b100,
	ALU_SRLV               = 3'b101,
	ALU_MULT               = 3'b110,
	ALU_SLL                = 3'b111,
	ALU_SRA                = 4'b1000,
	ALU_SRL                = 4'b1001
	
)

/*** IN/OUTPUT ***/
(
    // IN
    input clk, multsel,  rst,
    input [4 : 0]           SHAMT,
	input [SEL_WL - 1 : 0]  ALUsel,
    input [DATA_WL - 1:0]   IN1, 
                            IN2,
	// OUT
    output reg [DATA_WL - 1:0] OUT,
                                OUT_MULT_LO,
                                OUT_MULT_HI,
    output reg zeroflag
                                
 );
 
    reg [2*DATA_WL - 1 : 0] multreg;
    
    
    always @(*)
	begin
	   if(rst)
	   begin
	       OUT = 0;
	       OUT_MULT_LO = 0;
	       OUT_MULT_HI = 0;
	   end
	   else
	   begin
           case(ALUsel)
               ALU_IDLE:
               begin
                   OUT = 0; // Do nothing, out nothing
               end
               /*** TODO consolidate lw, sw, add.  They are the same op ***/
               ALU_LW_SW_ADD_ADDI:
               begin
                   /* TODO figure out how to deal with two's complement values */
                   OUT = IN1 + IN2;
               end
               ALU_SUB_BRANCH:
               begin
                   OUT = IN1 - IN2;
               end
               ALU_SLLV:
               begin
                   OUT = IN2 << IN1;
               end
               ALU_SRAV:
               begin
                   OUT = IN2 >>> IN1;
               end
               ALU_SRLV:
               begin
                   OUT = IN2 >> IN1;
               end
               ALU_MULT:
               begin
                   /* TODO what is the sequence to load mult lo and hi to regfile */
                   multreg = IN1 * IN2;
                   OUT_MULT_LO = multreg[DATA_WL - 1 : 0];
                   OUT_MULT_HI = multreg[2*DATA_WL - 1 : DATA_WL];
               end
               ALU_SLL:
               begin
                   OUT = IN2 << SHAMT;
               end
               ALU_SRA:
               begin
                   OUT = IN2 >>> SHAMT;
               end
               ALU_SRL:
               begin
                   OUT = IN2 >> SHAMT;
               end
               default OUT = 1'bx;
            endcase
            
            /* ZERO FLAG */
            if (!(IN1 - IN2)) zeroflag = 1;
            else zeroflag = 0;
       end
    end
endmodule