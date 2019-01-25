module signExtend12(input[11:0] in, output[31:0] out);

assign out[11:0]=in[11:0];
assign out[31:12]=20'b0;
endmodule