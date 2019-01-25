module InsCounter(switchMode,clock,reset,disp7,disp6,disp5,disp4);
input switchMode;
input clock;
input reset;
output [6:0] disp7;
output [6:0] disp6;
output [6:0] disp5;
output [6:0] disp4;

integer low4;
integer low5;
integer low6;
integer low7;

reg [35:0] counter;
wire [15:0] divider;
assign divider=counter[35:20];

always@(posedge clock)
begin
	if(reset)
	begin
		counter <=36'd0;
	end
	else
	begin
	counter <= counter +36'd1;
	low4=divider[3:0];
	low5=divider[7:4];
	low6=divider[11:8];
	low7=divider[15:12];
	end
end


assign disp7=switchMode?((low7==4'h0)?7'b1000000:
             (low7==4'h1)?7'b1111001:
             (low7==4'h2)?7'b0100100:
             (low7==4'h3)?7'b0110000:
             (low7==4'h4)?7'b0011001:
             (low7==4'h5)?7'b0010010:
             (low7==4'h6)?7'b0000010:
             (low7==4'h7)?7'b1111000:
             (low7==4'h8)?7'b0000000:
             (low7==4'h9)?7'b0010000:
				 (low7==4'hA)?7'b0001000:
	          (low7==4'hB)?7'b0000011:
       	    (low7==4'hC)?7'b1000110:
	          (low7==4'hD)?7'b0100001:
	          (low7==4'hE)?7'b0000110:
	          (low7==4'hF)?7'b0001110:7'b0):7'b1111111;
assign disp6=switchMode?((low6==4'h0)?7'b1000000:
             (low6==4'h1)?7'b1111001:
             (low6==4'h2)?7'b0100100:
             (low6==4'h3)?7'b0110000:
             (low6==4'h4)?7'b0011001:
             (low6==4'h5)?7'b0010010:
             (low6==4'h6)?7'b0000010:
             (low6==4'h7)?7'b1111000:
             (low6==4'h8)?7'b0000000:
             (low6==4'h9)?7'b0010000:
				 (low6==4'hA)?7'b0001000:
	          (low6==4'hB)?7'b0000011:
       	    (low6==4'hC)?7'b1000110:
	          (low6==4'hD)?7'b0100001:
	          (low6==4'hE)?7'b0000110:
	          (low6==4'hF)?7'b0001110:7'b0):7'b1111111;
assign disp5=switchMode?((low5==4'h0)?7'b1000000:
             (low5==4'h1)?7'b1111001:
             (low5==4'h2)?7'b0100100:
             (low5==4'h3)?7'b0110000:
             (low5==4'h4)?7'b0011001:
             (low5==4'h5)?7'b0010010:
             (low5==4'h6)?7'b0000010:
             (low5==4'h7)?7'b1111000:
             (low5==4'h8)?7'b0000000:
             (low5==4'h9)?7'b0010000:
				 (low5==4'hA)?7'b0001000:
	          (low5==4'hB)?7'b0000011:
       	    (low5==4'hC)?7'b1000110:
	          (low5==4'hD)?7'b0100001:
	          (low5==4'hE)?7'b0000110:
	          (low5==4'hF)?7'b0001110:7'b0):7'b1111111;
assign disp4=switchMode?((low4==4'h0)?7'b1000000:
             (low4==4'h1)?7'b1111001:
             (low4==4'h2)?7'b0100100:
             (low4==4'h3)?7'b0110000:
             (low4==4'h4)?7'b0011001:
             (low4==4'h5)?7'b0010010:
             (low4==4'h6)?7'b0000010:
             (low4==4'h7)?7'b1111000:
             (low4==4'h8)?7'b0000000:
             (low4==4'h9)?7'b0010000:
				 (low4==4'hA)?7'b0001000:
	          (low4==4'hB)?7'b0000011:
       	    (low4==4'hC)?7'b1000110:
	          (low4==4'hD)?7'b0100001:
	          (low4==4'hE)?7'b0000110:
	          (low4==4'hF)?7'b0001110:7'b0):7'b1111111;

endmodule