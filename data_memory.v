module mem_sync(clk,a,dout, din, mread, mwrite);
// Synchronous memory with 256 32-bit locations for data memory
parameter S=32; // size
parameter L=256; // length

input [$clog2(L) - 1:0] a;
input [S-1:0] din;
input clk;
input mwrite;
input mread;
output [(S-1):0] dout;

reg [S-1:0] memory [L-1:0];

// Read operation
assign dout = (mread) ? memory[a] : 32'b0;

// Write operation
always @(posedge clk) begin
	if (mwrite)
		memory[a] <= din;
end

// Manual initialization
initial begin
	memory[0]  = 32'h00000001;
	memory[1]  = 32'h00000000;
	memory[2]  = 32'h00000000;
	memory[3]  = 32'h00000000;
	memory[4]  = 32'h00000001;
	memory[5]  = 32'h00000000;
	memory[6]  = 32'h00000000;
	memory[7]  = 32'h00000000;
	memory[8]  = 32'h00000001;
	memory[9]  = 32'h00000000;
	memory[10] = 32'h00000000;
	memory[11] = 32'h00000001;
	memory[12] = 32'h00000000;
	memory[13] = 32'h00000000;
	memory[14] = 32'h00000000;
	memory[15] = 32'h00000001;

	memory[64] = 32'h00000010;
	memory[68] = 32'h00000001;
	memory[72] = 32'h00000001;
end

endmodule
