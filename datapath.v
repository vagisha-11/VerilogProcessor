`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2025 19:15:48
// Design Name: 
// Module Name: datapath
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

module datapath(
    input clk,
    input reset,
    input RegDst, ALUSrc, MemToReg, RegWrite,
    input MemRead, MemWrite, Branch,
    input Jump, Jal,                // << NEW
    input [1:0] ALUOp,
    output [5:0] OpCode
);

wire [31:0] Instruction;
wire [31:0] PC_plus_1;
wire [31:0] jump_address;
wire [4:0] write_reg;
wire [31:0] write_data;

wire [3:0] ALUCtrl;
wire [31:0] ALUout;
wire Zero;

assign OpCode = Instruction[31:26];
wire isJR = (OpCode == 6'b000000) && (Instruction[5:0] == 6'b001000);
wire [31:0] PC_adr;



wire [31:0] ReadRegister1;
wire [31:0] ReadRegister2;

wire [4:0] muxinstr_out;
wire [31:0] muxalu_out;
wire [31:0] muxdata_out;

wire [31:0] ReadData;

wire [31:0] signExtend;

wire PCsel;

assign PC_plus_1 = PC_adr + 1;
assign jump_address = {PC_adr[31:26], Instruction[25:0]};

mem_async meminstr(PC_adr[7:0],Instruction); //Instruction memory
mem_sync memdata(clk, ALUout[7:0], ReadData, ReadRegister2, MemRead, MemWrite); //Data memory
rf registerfile(clk, RegWrite, Instruction[25:21], Instruction[20:16], write_reg, ReadRegister1, ReadRegister2, write_data);

alucontrol AluControl(ALUOp, Instruction[5:0], ALUCtrl); //ALUControl
alu Alu(ReadRegister1, muxalu_out, ALUCtrl, ALUout, Zero); //ALU


pclogic PCLogic(
    .clk(clk),
    .reset(reset),
    .branch_offset(signExtend),     // 32-bit sign-extended immediate
    .jump_address(jump_address),    // {PC[31:28], instr[25:0], 2'b00}
    .pcsel(PCsel),                  // Branch & Zero
    .jump(Jump),                    // Jump or Jal
     .PC(PC_adr),        
     .isJR(isJR),
     .jr_address(ReadRegister1)           // Output to instruction memory
); //generate PC
andm andPC(Branch, Zero, PCsel); //AndPC (branch & zero)
signextend Signextend(signExtend, Instruction[15:0]); //Sign extend

assign write_reg = (Jal) ? 5'd31 : (RegDst ? Instruction[15:11] : Instruction[20:16]);
//wire [31:0] PC_adr = (isJR) ? ReadRegister1 : PC_adr_internal;
mux muxalu(ALUSrc, ReadRegister2, signExtend, muxalu_out);//MUX for ALU
assign write_data = (Jal) ? PC_plus_1 : (MemToReg ? ReadData : ALUout);

endmodule
