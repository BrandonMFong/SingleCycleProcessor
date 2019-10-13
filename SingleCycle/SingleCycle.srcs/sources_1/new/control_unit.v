`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: Monday, September 2, 2019 10:09:05 AM
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

module control_unit 

/*** PARAMETERS ***/
#(parameter
	// WORD LENGTH
	INST_WL    = 5,
	DATA_WL    = 32,
	SEL_WL     = 3,
	
	// OPCODE
	LW = 6'b100011,
	SW = 6'b101011,
	ADDI = 6'b001000,
	JUMP = 6'b000010,
	R  = 6'b000000,
	BEQ = 6'b000100, /* TODO finish implementing branch instructions */
	/* TODO if you have time */
	BNE = 6'b000101,

	
	// FUNCT
	ADD = 6'b100000,
	SUB = 6'b100010,
	SLL = 6'b000000,
	SRA = 6'b000011,
	SRL = 6'b000010,
	SLLV = 6'b000100,
	SRAV = 6'b000111,
	SRLV = 6'b000110,
	/* TODO implement the bottom two functions if you have time */
	MULT = 6'b011000,
	DIV  = 6'B011010,
	
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

/*** IN/OUT ***/
(
	// IN
	input [5 : 0]				OP, 
	                            FUNCT,
	input						zeroflag,
	// OUT
	output reg					RFWE, //Register file write enable
								DMWE,//Data Mem write enable
								
								/*** MUXES ***/
								mux0sel, //1 = RD, 0 = RT
								mux2sel, //1 = DMRD, 0 = ALU_out
								mux4sel, // 1 = RFRD1, 0 = RFRD2
								
								/* ZERO FLAG */
								// took zeroflag to cunit cuz you have a 3 to 1 mux for pc input
								// easier this way for me
								
	output reg [3 : 0]          mux1sel, //2 = SHAMT, 1 = SIGNED_IMMED, 0 = RT 
	                            mux3sel, // 2 = pcjump, 1 = pcreg, 0 = pcbranch
	output reg [SEL_WL - 1 : 0]	ALUsel,
	output reg                  rst
	
);

    initial
    begin
        #10 rst = 1;
        #10 rst = 0;
    end
    always @(*) 
	begin
	   case(OP)
	       LW: // Load from memory
	       begin
	           // alu op
	           ALUsel	= ALU_LW_SW_ADD_ADDI;
	           
	           // write enables
	           RFWE	= 1; // righting to destination rt
	           DMWE	= 0; // ensuring nothing is written in memory
	           
	           // muxes
	           mux0sel = 0; // destination is rt
	           mux1sel = 1; // signed immediate offset
	           mux2sel = 1;  // reading memory from data memory
	           mux3sel = 1; // bringing incrememnted pc not branch value
	           
	          
	           
	       end
	       SW: // Store into memory
	       begin
	           // alu op
	           ALUsel = ALU_LW_SW_ADD_ADDI; // ALU calc address to put into data mem
	           
	           //write enables
	           DMWE = 1; // write in memory
	           RFWE = 0; //don't write in register
	           
	           //muxes
	           mux0sel = 1'bx; // don't write anything in register
	           mux1sel = 1'b1; // alu is calculating the address to write into mem
	           mux2sel = 1; //reading from memory, but you aren't loading anything
	           mux3sel = 1; // inc pc
	       end
	       ADDI: // Add immediate values
	       begin
	           // alu op
	           ALUsel = ALU_LW_SW_ADD_ADDI; // ALU does nothing
	           
	           //write enables
	           DMWE = 0; // don't write in memory
	           RFWE = 1; //write in register
	           
	           //muxes
	           mux0sel = 0; // write into rt
	           mux1sel = 1; // add rs and imm, alu command here
	           mux2sel = 0; // taking from alu out and put into reg file
	           mux3sel = 1; // inc pc
	       end
	       JUMP:
	       begin
	           // alu op
	           ALUsel = 1'bx; // ALU does nothing
	           
	           //write enables
	           DMWE = 0; // don't write into memory
	           RFWE = 0; // don't write into memory
	           
	           //muxes
	           mux0sel = 1'bx; // write into nowhere cuz you're jumping
	           mux1sel = 1'bx; // not using alu cuz you're jumping
	           mux2sel = 1'bx; // not putting anything in the reg file cuz you're jumping
	           mux3sel = 2; // jumping
	       end
	       BEQ:
	       begin
	            // alu op
	           ALUsel = ALU_SUB_BRANCH; // 
	           
	           //write enables
	           DMWE = 0; // not writing into mem
	           RFWE = 0; // not writing into mem
	           
	           //muxes
	           mux0sel = 1'bx; // not writing into regfile
	           mux1sel = 1'b0; // 
	           mux2sel = 1'bx; // not writing into regfile
	           if(zeroflag) mux3sel = 0; // if zeroflag is one, then chose pcbranch else chose pcreg
	           else mux3sel = 1; 
	       end
	       R: // R type subdivision
	       begin
	           /*** FUNCT SELECTS ***/
	           case(FUNCT)
                   ADD:
                   begin
                       ALUsel = ALU_LW_SW_ADD_ADDI;
                       mux1sel = 0; // using rt as an operand, no immed value needed
                   end
                   SUB:
                   begin
                       ALUsel = ALU_SUB_BRANCH;
                       mux1sel = 0; // using rt as an operand, no immed value needed
                   end
                   SLL:
                   begin
                       ALUsel = ALU_SLL;
                       mux1sel = 1'bx; // using shamt at alu
                   end
                   SLLV:
                   begin
                       ALUsel = ALU_SLLV;
                       mux1sel = 0; // passing dt into the alu port two (IN2)
                   end
                   SRA:
                   begin
                       ALUsel = ALU_SRA;
                       mux1sel = 1'bx; // using shamt at alu
                   end
                   SRAV:
                   begin
                       ALUsel = ALU_SRAV;
                       mux1sel = 0; // passing dt into the alu port two (IN2)
                   end
                   SRL:
                   begin
                       ALUsel = ALU_SRL;
                       mux1sel = 1'bx; // using shamt at alu
                   end
                   SRLV:
                   begin
                       ALUsel = ALU_SRLV;
                       mux1sel = 0; // passing dt into the alu port two (IN2)
                   end
                   MULT:
                   begin
                       ALUsel = ALU_MULT;
                       /* TODO figure out mux select, might have unique sets of mux selects */
                   end
	           endcase
	           //write enables
	           DMWE = 0; // don't write in memory
	           RFWE = 1; // write in register
	           
	           //muxes
	           mux0sel = 1; // using rd for destination, not rt.  note this is rtype
	           mux2sel = 0; // bypass data memory, ops in register file
	           mux3sel = 1; // inc pc
	       end
	   endcase
    end
endmodule