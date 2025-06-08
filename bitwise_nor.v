module bitwise_nor(input [31:0] a, b, output [31:0] y);
    wire [31:0] temp;
    genvar i;
    generate for (i = 0; i < 32; i = i + 1)
    begin
        or or_gate(temp[i], a[i], b[i]);
    end
    endgenerate
    generate for (i = 0; i < 32; i = i + 1)
    begin
        not not_gate(y[i], temp[i]);
    end
    endgenerate
endmodule
