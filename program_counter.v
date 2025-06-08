`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: pclogic
// Description: Program Counter logic for word-addressed MIPS
//////////////////////////////////////////////////////////////////////////////////

module pclogic(
    input clk,
    input reset,
    input [31:0] branch_offset,  // sign-extended immediate (no shift)
    input [31:0] jump_address,   // from {PC[31:28], instr[25:0], 2'b00}
    input pcsel,                 // Branch signal (Branch & Zero)
    input jump,                  // Jump signal
    output reg [31:0] PC,
    input isJR,
    input [31:0] jr_address         // Current Program Counter
);

always @(posedge clk or posedge reset) begin
    if (reset)
        PC <= 32'b0;
    else if(isJR)
        PC <= jr_address;
    else if (jump)
        PC <= jump_address;
    else if (pcsel)
        PC <= PC + 1 + branch_offset;
    else
        PC <= PC + 1;
end

endmodule
