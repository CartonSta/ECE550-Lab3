// Control for the Duke 550 Processor
// Authors: 
//
//    |***************|*******************|********* |
//    |Name           | NetID             | TeamNum: |
//    |***************|*******************|**********|
//    |Yukun Yang     | yy228             |          |
//    |Hongliang Dong | hd97              |    26    |
//    |Burak Gunay    | bg127             |          |
//    |***************|*******************|**********|


module control ( 	input [4:0] op,
						// TODO: Figure out what other control signals you require for your processor						
						// TODO: Figure out what values they will take based on the opcode
						output MemWrite,RegWrite,RegTar,Jr,J,Jal,ALUSrc,keyIn,MemtoReg,Branch, display,
						output[2:0]func);
						
assign MemWrite = op[3] && (!op[2]) && (!op[1]) && (!op[0]);
assign RegWrite = (!op[3]) || (op[2] && (!op[1]) && op[0]) || (op[2] && op[1] && (!op[0]));
assign RegTar   = !op[3];
assign Jr       = op[3] && (!op[2]) && op[1] && op[0];
assign J        = op[3] && op[2] && (!op[1]) && (! op[0]);
assign Jal      = op[3] && op[2] && (!op[1]) && op[0];
assign ALUSrc   = (op[3] && (!op[1]) && (!op[0])) || (op[2] && op[1]);
assign keyIn    = op[3] && op[2] && op[1] && !op[0];
assign MemtoReg = op[2] && op[1] && op[0];
assign Branch   = (op[3] && (!op[1]) && (op[0])) || (op[3] && (!op[2]) && op[1]);
assign func[2]  = op[2] && (!op[1]);
assign func[1]  = (!op[3]) && (!op[2]) && op[1];
assign func[0]  = ((!op[1]) && op[0])||(op[3] && op[1])||((!op[2]) && op[1] && op[0]);
assign display  = op[3] && op[2] && op[1] && op[0];
// Hint: This unit basically decides the values of the control signals
// based on the input opcode received. Eg. Look at slide 31 in Lecture 9

endmodule 
