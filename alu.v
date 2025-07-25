module alu(opA, opB, ALUop, result, zero);

input [31:0] opA;
input [31:0] opB;
input [3:0] ALUop;

output reg [31:0] result;
output zero; //1 if result is 0

assign zero = (result==0);

always @(ALUop, opA, opB) begin
	case(ALUop)
		4'b0000: result=opA&opB;
		4'b0001: result=opA|opB;
		4'b0010: result=opA+opB;
		
		4'b0110: result=opA-opB;
		4'b0111: result=opA<opB?1:0; //slt
		4'b1100: result=~(opA|opB);
	endcase
end

always @(*) begin
	$display("time: = %0t | ALU: A = %h | B = %h | ALUop = %b | Result = %h",$time, opA, opB, ALUop, result);

end


endmodule