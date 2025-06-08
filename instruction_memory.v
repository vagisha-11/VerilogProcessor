module mem_async(a, d);
// Asynchronous memory with 256 32-bit locations
// For instruction memory

parameter S=32;
parameter L=256;

input [$clog2(L) - 1:0] a;
output [(S-1):0] d;

reg [S-1:0] memory [L-1:0];
assign d = memory[a];

// Manual initialization instead of $readmemh
initial begin
	memory[0]  = 32'h00004020; // add $t0, $zero, $zero
	memory[1]  = 32'h00007020; // add $t1, $zero, $zero
	memory[2]  = 32'h0C00000F; // jal 15 ? $ra = 3, jump to 15
	memory[3]  = 32'h8d090040; // lw $t1, 64($t0)
	memory[4]  = 32'h8d0a0044; // lw $t2, 68($t0)
	memory[5]  = 32'h8d0b0048; // lw $t3, 72($t0)
	memory[6]  = 32'had00004c; // sw $zero, 76($t0)
	memory[7]  = 32'h8d0c0000; // lw $t4, 0($t0)
	memory[8]  = 32'h8dcd004c; // lw $t5, 76($t6)
	memory[9]  = 32'h01ac6820; // add $t5, $t5, $t4
	memory[10] = 32'hadcd004c; // sw $t5, 76($t6)
	memory[11] = 32'h012a4822; // sub $t1, $t1, $t2
	memory[12] = 32'h010b4020; // add $t0, $t0, $t3
	memory[13] = 32'h11200003; // beq $t1, $zero, 3 ? PC = 17 if $t1 == 0
	memory[14] = 32'h08000007; // j loop (address 7)

	// Function (called by jal at memory[2])
	memory[15] = 32'h20090005; // addi $t1, $zero, 5
	memory[16] = 32'h03F00008; // jr $ra - return to PC=3

	// Done section
	memory[17] = 32'h08000012; // done: j halt (PC = 18)
	memory[18] = 32'h08000012; // halt: j halt (infinite loop)
end




endmodule
