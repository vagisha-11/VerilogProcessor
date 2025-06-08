`timescale 1ns / 1ps
module mux8_32 (
    input [3:0] sel,
    input [31:0] in0, in1, in2, in3, in4, in5, in6, in7,
    output reg [31:0] out
);
    always @(*) begin
        case(sel)
            4'b0000: out = in0;
            4'b0001: out = in1;
            4'b0010: out = in2;
            4'b0110: out = in6;
            4'b0111: out = in7;
            4'b1100: out = in3; // nor used in in3
            default: out = 32'b0;
        endcase
    end
endmodule
