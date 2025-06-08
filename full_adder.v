`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2025 19:10:46
// Design Name: 
// Module Name: full_adder
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

module full_adder (
    input a, b, cin,
    output sum, cout
);

    wire w1, w2, w3;

    xor g1(w1, a, b);
    xor g2(sum, w1, cin);

    and g3(w2, a, b);
    and g4(w3, w1, cin);

    or g5(cout, w2, w3);

endmodule