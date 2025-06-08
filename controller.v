module control(
    input [5:0] opcode,
    output reg RegDst,
    output reg ALUSrc,
    output reg MemtoReg,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch,
    output reg Jump,
    output reg Jal,
    output reg [1:0] AluOP
);

always @(opcode) begin
    case (opcode)
        6'b000000: // R-type
            {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, Jal, AluOP} 
                = 11'b1_0_0_1_0_0_0_0_0_10;

        6'b100011: // lw
            {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, Jal, AluOP} 
                = 11'b0_1_1_1_1_0_0_0_0_00;

        6'b101011: // sw
            {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, Jal, AluOP} 
                = 11'b0_1_x_0_0_1_0_0_0_00;

        6'b000100: // beq
            {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, Jal, AluOP} 
                = 11'b0_0_x_0_0_0_1_0_0_01;

        6'b000010: // j
            {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, Jal, AluOP} 
                = 11'b0_0_x_0_0_0_0_1_0_00;

        6'b000011: // jal
            {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, Jal, AluOP} 
                = 11'b0_0_0_1_0_0_0_1_1_00;
        6'b001000: // addi
                    {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, Jal, AluOP} 
                        = 11'b0_1_0_1_0_0_0_0_0_00;
        default:
            {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, Jal, AluOP} 
                =11'b0_0_0_0_0_0_0_0_0_00; 
    endcase
end

endmodule
