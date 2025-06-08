module bitwise_and(input [31:0] a, b, output [31:0] y);
    genvar i;
    generate for (i = 0; i < 32; i = i + 1)
    begin
        
        and a_gate(y[i], a[i], b[i]);
    end
    endgenerate
endmodule
