module alucontrol(
    input [1:0] AluOp,
    input [5:0] FnField,  // For R-type instructions
    output reg [3:0] AluCtrl
);

always @(*) begin
    casex({AluOp, FnField})
        8'b00_xxxxxx:    AluCtrl = 4'b0010; // add (lw, sw, addi)
        8'b01_xxxxxx:    AluCtrl = 4'b0110; // sub (beq)
        8'b10_100000:    AluCtrl = 4'b0010; // R-type add
        8'b10_100010:    AluCtrl = 4'b0110; // R-type sub
        8'b10_100100:    AluCtrl = 4'b0000; // R-type and
        8'b10_100101:    AluCtrl = 4'b0001; // R-type or
        8'b10_101010:    AluCtrl = 4'b0111; // R-type slt
        default:         AluCtrl = 4'b1111; // unknown
    endcase
end

endmodule
