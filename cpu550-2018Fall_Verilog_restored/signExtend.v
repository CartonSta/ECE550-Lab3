module signExtend(input[16:0] in, output[31:0] out);

assign out[15:0]=in[15:0];

assign out[31:16]=in[16]?16'b 1111_1111_1111_1111:16'b0;

endmodule
