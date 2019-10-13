`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2019 07:25:08 PM
// Design Name: 
// Module Name: testbench0
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


module testbench0;

reg clk;

top_module
        mod0
            /* IN/OUT */
            (
                // IN
                .clk(clk)
            );

    initial clk <= 0;
    always #5 clk <= ~clk;
    initial
    begin
        #5000;
        $finish;
    end
endmodule
