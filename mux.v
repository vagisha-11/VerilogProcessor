`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2025 18:26:09
// Design Name: 
// Module Name: mux
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
module mux(sel, ina, inb, out);
//mux 2 to 1
parameter DATA_LENGTH = 32;

input sel;
input [DATA_LENGTH-1 : 0] ina; 
input [(DATA_LENGTH-1) : 0]  inb;
output [DATA_LENGTH-1 : 0] out;

assign out=(sel==0)?ina:inb;

endmodule

