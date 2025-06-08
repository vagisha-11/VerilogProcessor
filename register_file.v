`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: register_file (rf)
//////////////////////////////////////////////////////////////////////////////////

module rf(clk, RegWrite, ra, rb, rc, da, db, dc);
    input clk;
    input RegWrite;
    input [4:0] ra;         // Read register 1 (instr[25:21])
    input [4:0] rb;         // Read register 2 (instr[20:16])
    input [4:0] rc;         // Write register (from mux)
    input [31:0] dc;        // Write data
    output [31:0] da;       // Output read data 1
    output [31:0] db;       // Output read data 2

    reg [31:0] memory [31:0]; // 32 general-purpose registers

    // Read logic
    assign da = (ra != 0) ? memory[ra] : 32'b0;
    assign db = (rb != 0) ? memory[rb] : 32'b0;

    // Write logic
    always @(posedge clk) begin
        if (RegWrite && rc != 0) begin
            memory[rc] <= dc;
        end
    end

    // Initialize all registers to zero
//    integer i;
//    initial begin
//        for (i = 0; i < 32; i = i + 1)
//            memory[i] = 32'h00000000;
//    end

    // Monitor $t0-$t6 = registers 8 to 14
    initial begin
        $display("------ MIPS Temp Registers ($t0-$t6) ------");
        $monitor("Time = %0t | $t0 = %h | $t1 = %h | $t2 = %h | $t3 = %h | $t4 = %h | $t5 = %h | $t6 = %h | $ra = %h",
                 $time, memory[8], memory[9], memory[10], memory[11], memory[12], memory[13], memory[14], memory[31]);
    end
endmodule
