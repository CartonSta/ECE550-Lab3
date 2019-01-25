module displayPC(inputData,switchMode,disp3,disp2,disp1,disp0);

input [11:0] inputData;
input switchMode;

output  [6:0] disp3;
output  [6:0] disp2;
output  [6:0] disp1;
output  [6:0] disp0;

integer low0;
integer low1;
integer low2;
integer low3;




always@(*)
begin
low0=inputData[3:0];
low1=inputData[7:4];
low2=inputData[11:8];
low3=4'b0000;
end
	
	
	assign disp3=switchMode?7'b1000000:7'b1111111;
	assign disp2=switchMode?((low2==4'h0)?7'b1000000:
             (low2==4'h1)?7'b1111001:
             (low2==4'h2)?7'b0100100:
             (low2==4'h3)?7'b0110000:
             (low2==4'h4)?7'b0011001:
             (low2==4'h5)?7'b0010010:
             (low2==4'h6)?7'b0000010:
             (low2==4'h7)?7'b1111000:
             (low2==4'h8)?7'b0000000:
             (low2==4'h9)?7'b0010000:
				 (low2==4'hA)?7'b0001000:
	          (low2==4'hB)?7'b0000011:
       	    (low2==4'hC)?7'b1000110:
	          (low2==4'hD)?7'b0100001:
	          (low2==4'hE)?7'b0000110:
	          (low2==4'hF)?7'b0001110:7'b0):7'b1111111;
				 
		assign disp1=switchMode?((low1==4'h0)?7'b1000000:
             (low1==4'h1)?7'b1111001:
             (low1==4'h2)?7'b0100100:
             (low1==4'h3)?7'b0110000:
             (low1==4'h4)?7'b0011001:
             (low1==4'h5)?7'b0010010:
             (low1==4'h6)?7'b0000010:
             (low1==4'h7)?7'b1111000:
             (low1==4'h8)?7'b0000000:
             (low1==4'h9)?7'b0010000:
	          (low1==4'hA)?7'b0001000:
	          (low1==4'hB)?7'b0000011:
       	    (low1==4'hC)?7'b1000110:
	          (low1==4'hD)?7'b0100001:
	          (low1==4'hE)?7'b0000110:
	          (low1==4'hF)?7'b0001110:7'b0):7'b1111111;
		  
		assign disp0=switchMode?((low0==4'h0)?7'b1000000:
             (low0==4'h1)?7'b1111001:
             (low0==4'h2)?7'b0100100:
             (low0==4'h3)?7'b0110000:
             (low0==4'h4)?7'b0011001:
             (low0==4'h5)?7'b0010010:
             (low0==4'h6)?7'b0000010:
             (low0==4'h7)?7'b1111000:
             (low0==4'h8)?7'b0000000:
             (low0==4'h9)?7'b0010000:
				 (low0==4'hA)?7'b0001000:
	          (low0==4'hB)?7'b0000011:
       	    (low0==4'hC)?7'b1000110:
	          (low0==4'hD)?7'b0100001:
	          (low0==4'hE)?7'b0000110:
	          (low0==4'hF)?7'b0001110:7'b0):7'b1111111;





endmodule