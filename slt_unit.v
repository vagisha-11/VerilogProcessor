`timescale 1ns / 1ps


module slt_unit(input [31:0] a, b, output [31:0] y);
    wire [31:0] diff;
    wire dummy;

    ripple_adder_32 sub(.a(a), .b(~b), .cin(1'b1), .sum(diff));

    // If MSB is 1 ? a < b
    assign y = {31'b0, diff[31]};
endmodule
