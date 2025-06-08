`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2025 18:54:55
// Design Name: 
// Module Name: bitwise_or
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


module bitwise_or(input [31:0] a, b, output [31:0] y);
    genvar i;
    generate for (i = 0; i < 32; i = i + 1)
    begin
        or o_gate(y[i], a[i], b[i]);
    
    end
    endgenerate
endmodule