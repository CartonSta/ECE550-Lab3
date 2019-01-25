module processor ( 	input clock,
							input reset,
							input [31:0] keyboard_in,
							input sw0,sw1,
							output keyboard_ack, 
							output lcd_write,
							output [31:0] lcd_data,
							output [6:0] Hex07,Hex06,Hex05,Hex04,Hex03,Hex02,Hex01,Hex00);
							

// The core of the Duke 550 processor
// Author: <INSERT YOUR NAME HERE!!!!>

//    |***************|*******************|********* |
//    |Name           | NetID             | TeamNum: |
//    |***************|*******************|**********|
//    |Yukun Yang     | yy228             |          |
//    |Hongliang Dong | hd97              |    26    |
//    |Burak Gunay    | bg127             |          |
//    |***************|*******************|**********|

// Define all the wires you will need below:

wire [11:0] insAddress;
wire clken;
wire [31:0] insOutput;

wire [31:0] readData2;
wire [31:0] dataOutput;
wire [4:0] regDJump31;
wire [31:0] valDInput;
wire [31:0] readData1;
wire [31:0] ALUMuxOutput;
wire [31:0] ALUResult;
wire isEqual;
wire isLessThan;
wire [4:0] regBInput;
wire [31:0] signExtendOutput;
wire [31:0] calculatedAnswer;
wire [31:0] newValue;
wire [31:0] PCNewExtend;

wire [11:0] PCInput;
wire [11:0] branchAdderOutput;
wire andInput;
wire branchMuxS;
wire [11:0] branchMuxOutput;
wire [11:0] JMuxOutput;
wire [2:0] funcCode;
wire [11:0] PCNew;
wire [11:0] imemInput;
//

//control signals

wire MemWrite;
wire RegWrite;
wire RegTar;
wire Jr;
wire J;
wire Jal;
wire ALUSrc;
wire keyIn;
wire MemtoReg;
wire Branch;
wire display;

assign clken =1'b1;
assign lcd_data = readData2;
assign keyboard_ack = keyIn;
assign lcd_write = display;
// Instantiate the imem - connect with wires to other units?
imem
my_imem(.address(imemInput),
.clken(clken),
.clock(clock),
.q(insOutput));

// Instantiate the dmem - connect with wires to other units?
dmem
my_dmem(.address(ALUResult[11:0]),
.clock(!clock),
.data(readData2),
.wren(MemWrite),
.q(dataOutput));

// Instantiate the regfile - connect with wires to other units?
regfile
my_regfile(.clock(clock),
.wren(RegWrite),
.clear(reset),
.regD(regDJump31),
.regA(insOutput[21:17]),
.regB(regBInput),
.valD(valDInput),
.valA(readData1),
.valB(readData2));

// Instantiate the alu - connect with wires to other units?
alu
my_alu(.A(readData1),
.B(ALUMuxOutput),
.op(funcCode),
.R(ALUResult),
.isEqual(isEqual),
.isLessThan(isLessThan));

// Instantiate the control unit - connect with with wires to other units?
//********************************************************
control
my_control(.op(insOutput[31:27]),
.MemWrite(MemWrite),
.RegWrite(RegWrite),
.RegTar(RegTar),
.Jr(Jr),
.J(J),
.Jal(Jal),
.ALUSrc(ALUSrc),
.keyIn(keyIn),
.MemtoReg(MemtoReg),
.Branch(Branch),
.display(display),
.func(funcCode));
// Instantiate the RegTar Mux
mux
#(.n(5))
RegTar_mux(.A(regDJump31),
.B(insOutput[16:12]),
.s(RegTar),
.F(regBInput));

// Instantiate the jrJal Mux

mux
#(.n(5))
jrJal_mux(.A(insOutput[26:22]),
.B(5'd31),
.s(Jr || Jal),
.F(regDJump31));
// Instantiate the ALUSrc Mux

mux
#(.n(32))
ALUSrc_mux(.A(readData2),
.B(signExtendOutput),
.s(ALUSrc),
.F(ALUMuxOutput));

// Instantiate the KeyIn Mux
mux
#(.n(32))
keyIn_mux(.A(calculatedAnswer),
.B(keyboard_in),
.s(keyIn),
.F(valDInput));
// Instantiate the MemtoReg Mux
mux
#(.n(32))
MemtoReg_mux(.A(ALUResult),
.B(dataOutput),
.s(MemtoReg),
.F(newValue));

// Instantiate the Jal Mux
mux
#(.n(32))
Jal_mux(.A(newValue),
.B(PCNewExtend),
.s(Jal),
.F(calculatedAnswer));

// Instantiate the signExtend
signExtend
my_signExtend(.in(insOutput[16:0]),
.out(signExtendOutput));

// Instantiate the signExtend12
signExtend12
my_signExtend12(.in(PCNew[11:0]),
.out(PCNewExtend));

// Instantiate the PC
reg_new
#(.n(12))
my_PC(.D(PCInput),
.clock(clock),
.clear(reset),
.enable(clken),
.Q(insAddress));

assign PCNew = insAddress + 12'd1;

// Instantiate the branch adder
adder_cs
#(.n(12))
branchAdder(.A(PCNew),
.B(insOutput[11:0]),
.cin(1'b0),
.cout(),
.sum(branchAdderOutput),
.signed_overflow());

// Instantiate the branch prepare Mux
mux
#(.n(1))
BPrepare_mux(.A(isEqual),
.B(isLessThan),
.s(insOutput[28]),
.F(andInput));

assign branchMuxS = Branch && andInput;

// Instantiate the branch Mux
mux
#(.n(12))
branch_mux(.A(PCNew),
.B(branchAdderOutput),
.s(branchMuxS),
.F(branchMuxOutput));

// Instantiate the j or jal Mux
mux
#(.n(12))
JOrJal_mux(.A(branchMuxOutput),
.B(insOutput[11:0]),
.s(J || Jal),
.F(JMuxOutput));

// Instantiate the jr Mux
mux
#(.n(12))
Jr_mux(.A(JMuxOutput),
.B(readData2[11:0]),
.s(Jr),
.F(PCInput));
// Instantiate the reset Mux
mux
#(.n(12))
reset_mux(.A(PCInput),
.B(12'd0),
.s(reset),
.F(imemInput));

//displayPC
displayPC
my_displayPC(.inputData(insAddress),
.switchMode(sw0),
.disp3(Hex03),
.disp2(Hex02),
.disp1(Hex01),
.disp0(Hex00));

InsCounter
my_counter(.switchMode(sw1),
.clock(clock),
.reset(reset),
.disp7(Hex07),
.disp6(Hex06),
.disp5(Hex05),
.disp4(Hex04));

/* TODO: Connect stuff up to make a processor
	
	---- FETCH Stage
	
	---- DECODE Stage
	
	---- EXECUTE Stage
	
	---- MEMORY WRITE Stage
	
	---- WRITEBACK Stage

*/

endmodule
