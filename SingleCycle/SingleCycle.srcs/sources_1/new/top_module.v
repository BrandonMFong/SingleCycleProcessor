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


module top_module
/* TODO make sure all bit width are correct */
/*** PARAMETERS ***/
#(parameter
    // WORD LENGTH
	INST_WL    = 5,
	DATA_WL    = 32,
	SEL_WL     = 3,
	ADDR_WL    = 5,
	IMMED_WL   = 16,
	JUMP_WL    = 26,
	
//	/* Might not need */
//	val0 = 17,
//	val1 = 31,
//	val2 = -5,
//	val3 = -2,
//	val4 = 250,
	
	// OPCODE
	LW = 6'b100011,
	SW = 6'b101011,
	R  = 6'b000000,
	
	// FUNCT
	ADD = 6'b100000,
	SUB = 6'b100010,
	SLL = 6'b000000,
	SRA = 6'b000011,
	SRL = 6'b000010,
	SLLV = 6'b000100,
	SRAV = 6'b000111,
	SRLV = 6'b000110,
	MULT = 6'b011000,
	
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
	input clk
	// OUT
    
);

/*** TODO initialize clock ***/
// Do in testbench

/*** WIRES ***/
    wire [5 : 0] 		     instmem_controlunit_opcode,
						     instmem_controlunit_funct;
	wire [4 : 0]		     instmem_regfile,
						     instmem_mux0_regfile,
						     instmem_mux0;
						     //instmem_mux1;
	wire [15 : 0]		     instmem_signedext; //immediates
	wire				/*** WRITE ENABLE ***/
	                         controlunit_regfile_rfwe, //Register file write enable
						     controlunit_datamem_dmwe,//Data Mem write enable
						/*** MUXES ***/
						     controlunit_mux0, //1 = RD, 0 = RT
						     controlunit_mux2; //1 = DMRD, 0 = ALU_out						     
	wire [3 : 0]             controlunit_mux1, //2 = SHAMT, 1 = SIGNED_IMMED, 0 = RT
	                         controlunit_mux3; // 2 = pcjump, 1 = pcreg, 0 = pcbranch
	wire [SEL_WL - 1 : 0]	 controlunit_alu;
	wire [DATA_WL - 1 : 0] /* FROM ALU */  
	                         regfile_alu,
	                         mux1_alu,
	                         alu_datamem_mux2; //DMA input
	wire [31 : 0]            pc_instmem_adder0_adder1_jump; // wire that connects pc to instruction memory
	wire [31 : 0]            regfile_mux1_datamem;
	wire [DATA_WL - 1 : 0]   datamem_mux2;
	wire [DATA_WL - 1 : 0]   mux3_pc;
	wire [DATA_WL - 1 : 0]   adder0_mux3;
	wire [DATA_WL - 1 : 0]   signedext_mux1_adder1;
	wire [DATA_WL - 1 : 0]   adder1_mux3;
	wire [4 : 0]             mux0_regfile;
	wire [DATA_WL - 1 : 0]   mux2_regfile;
	wire [JUMP_WL - 1 : 0]   instmem_jump;
	wire [DATA_WL - 1 : 0]   jump_mux3;
	wire                     alu_controlunit;
	wire                     controlunit_everyone_rst,
	                         controlunit_mux4;
	wire [4 : 0]             instmem_alu;
	                       
	

/*** MODULES ***/
    control_unit
            /* PARAMETERS */
            #(
                .INST_WL(INST_WL),
                .DATA_WL(DATA_WL),
                .SEL_WL(SEL_WL),
                
                // OPCODE
                .LW(LW),
                .SW(SW),
                .R(R),
                
                // FUNCT
                .ADD(ADD),
                .SUB(SUB),
                .SLL(SLL),
                .SRA(SRA),
                .SRL(SRL),
                .SLLV(SLLV),
                .SRAV(SRAV),
                .SRLV(SRLV),
                
                // ALU
                .ALU_IDLE(ALU_IDLE),
                .ALU_LW_SW_ADD_ADDI(ALU_LW_SW_ADD_ADDI),
                .ALU_SUB_BRANCH(ALU_SUB_BRANCH),
                .ALU_SLLV(ALU_SLLV),
                .ALU_SRAV(ALU_SRAV),
                .ALU_SRLV(ALU_SRLV),
                .ALU_SLL(ALU_SLL),
                .ALU_SRA(ALU_SRA),
                .ALU_SRL(ALU_SRL)
            )
        mod0
            /* IN/OUT */
            (
                // IN
                .OP(instmem_controlunit_opcode),
				.FUNCT(instmem_controlunit_funct),
                // OUT
                .RFWE(controlunit_regfile_rfwe), //Register file write enable
				.DMWE(controlunit_datamem_dmwe),//Data Mem write enable
				/*** MUXES ***/
				.mux0sel(controlunit_mux0), //1 = RD, 0 = RT
				.mux2sel(controlunit_mux2), //1 = DMRD, 0 = ALU_out
				.mux3sel(controlunit_mux3), // 1 = pcreg, 0 = pcbranch
				.mux1sel(controlunit_mux1), //2 = SHAMT, 1 = SIGNED_IMMED, 0 = RT 
				.ALUsel(controlunit_alu),
				.rst(controlunit_everyone_rst),
				.mux4sel(controlunit_mux4),
                .zeroflag(alu_controlunit)
            );
    ALU
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL),
	            .ADDR_WL(ADDR_WL),
	            .SEL_WL(SEL_WL),
                // ALU
                .ALU_IDLE(ALU_IDLE),
                .ALU_LW_SW_ADD_ADDI(ALU_LW_SW_ADD_ADDI),
                .ALU_SUB_BRANCH(ALU_SUB_BRANCH),
                .ALU_SLLV(ALU_SLLV),
                .ALU_SRAV(ALU_SRAV),
                .ALU_SRLV(ALU_SRLV),
                .ALU_SLL(ALU_SLL),
                .ALU_SRA(ALU_SRA),
                .ALU_SRL(ALU_SRL)
            )
        mod1
            (
                // IN 
                .rst(controlunit_everyone_rst),
                .clk(clk),
                .ALUsel(controlunit_alu),
                .IN1(regfile_alu), 
                .IN2(mux1_alu),
                .SHAMT(instmem_alu),
                // OUT
                .OUT(alu_datamem_mux2),
                .zeroflag(alu_controlunit) /* TODO make branch instruction */
            );
    instruction_memory
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL),
	            .ADDR_WL(ADDR_WL)
            )
        mod2
            /* IN/OUT */
            (
                // IN
                .rst(controlunit_everyone_rst),
                .addr(pc_instmem_adder0_adder1_jump),
                // OUT
                .OP(instmem_controlunit_opcode),
                .FUNCT(instmem_controlunit_funct),
                .RS(instmem_regfile),
                .RT(instmem_mux0_regfile),
                .RD(instmem_mux0),
                .SHAMT(instmem_alu),
                .IMMED(instmem_signedext), //immediates
                /* TODO make jump architecture */
                .JUMP(jump_mux3) //jump value
            );
    data_memory
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL),
                .ADDR_WL(ADDR_WL)
            )
        mod3
            /* IN/OUT */
            (
                // IN 
                .rst(controlunit_everyone_rst),
                .clk(clk), 
                .DMWE(controlunit_datamem_dmwe),
                .DMA(alu_datamem_mux2),
                .DMWD(regfile_mux1_datamem),
                // OUT
                .DMRD(datamem_mux2)
            );
    adder0
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod4
            /* IN/OUT */
            (
                // IN
                .rst(controlunit_everyone_rst),
                .din(pc_instmem_adder0_adder1_jump),
                // OUT
                .dout(adder0_mux3)
            );
    adder1
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod5
            /* IN/OUT */
            (
                // IN
                .rst(controlunit_everyone_rst),
                .SIGNED_IMMED(signedext_mux1_adder1),
                .pc_out(pc_instmem_adder0_adder1_jump),
                // OUT
                .dout(adder1_mux3)
            );
    program_counter
            /* PARAMETERS */
            #(
                .DATA_WL(DATA_WL)
            )
        mod6
            /* IN/OUT */
            (
                // IN
                .rst(controlunit_everyone_rst),
                .clk(clk),
                .pc_in(mux3_pc),
                // OUT 
                .pc_out(pc_instmem_adder0_adder1_jump)
            );
    mux0
            /* PARAMETERS */
            #(
                .INST_WL(INST_WL),
	            .DATA_WL(DATA_WL),
	            .ADDR_WL(ADDR_WL)
            )
        mod7
            /* IN/OUT */
            (
                // IN
                .rst(controlunit_everyone_rst),
                .mux0sel(controlunit_mux0),
                .RT(instmem_mux0_regfile),
                .RD(instmem_mux0),
                // OUT
                .dout(mux0_regfile) 
            );
     mux1
            /* PARAMETERS */
            #(
                .INST_WL(INST_WL),
	            .DATA_WL(DATA_WL),
	            .ADDR_WL(ADDR_WL)
            )
        mod8
            /* IN/OUT */
            (
                // IN
                .rst(controlunit_everyone_rst),
                .mux1sel(controlunit_mux1),
                .DT(regfile_mux1_datamem),
                .SIGNED_IMMED(signedext_mux1_adder1),
                // OUT
                .dout(mux1_alu) 
            );    
     mux2
            /* PARAMETERS */
            #(
                .INST_WL(INST_WL),
	            .DATA_WL(DATA_WL),
	            .ADDR_WL(ADDR_WL)
            )
        mod9
            /* IN/OUT */
            (
                // IN
                .rst(controlunit_everyone_rst),
                .mux2sel(controlunit_mux2),
                .DMRD(datamem_mux2),
                .ALU_out(alu_datamem_mux2),
                // OUT
                .dout(mux2_regfile) 
            );  
     mux3
            /* PARAMETERS */
            #(
                .INST_WL(INST_WL),
	            .DATA_WL(DATA_WL),
	            .ADDR_WL(ADDR_WL)
            )
        mod10
            /* IN/OUT */
            (
                // IN
                .rst(controlunit_everyone_rst),
                .mux3sel(controlunit_mux3),
                .pcreg(adder0_mux3),
                .pcbranch(adder1_mux3),
                .pcjump(jump_mux3),
                // OUT
                .dout(mux3_pc) 
            );  
     register_file
            /* PARAMETERS */
            #(
                .ADDR_WL(ADDR_WL),
                .DATA_WL(DATA_WL)
            )
        mod11
            /* IN/OUT */
            (
                // IN
                .rst(controlunit_everyone_rst),
                .clk(clk),
                .RFWE(controlunit_regfile_rfwe),
                .RFWD(mux2_regfile),	//RFWD
                .RFRA1(instmem_regfile),	//RFRA1
                .RFRA2(instmem_mux0_regfile),	//RFRA2
                .RFWA(mux0_regfile),	//RFWA
                // OUT
                .RFRD1(regfile_alu),	//RFRD1
                .RFRD2(regfile_mux1_datamem)	//RFRD2 
            ); 
     sign_extension
            /* PARAMETERS */
            #(
                .IMMED_WL(IMMED_WL),
                .DATA_WL(DATA_WL)
            )
        mod12
            /* IN/OUT */
            (
                // IN
                .rst(controlunit_everyone_rst),
                .IMMED(instmem_signedext),
                // OUT
                .SIGNED_IMMED(signedext_mux1_adder1)
            ); 
    jump
            /* PARAMETERS */
            #(
                .JUMP_WL(JUMP_WL),
                .DATA_WL(DATA_WL)
            )
        mod13
            /* IN/OUT */
            (
                // IN
                .rst(controlunit_everyone_rst),
                .JUMP(instmem_jump),
                .PC(pc_instmem_adder0_adder1_jump),
                // OUT
                .jaddr(jump_mux3)
            ); 

             
endmodule
