module InstructionMemory #(parameter N = 100)
						  (input [15:0]ReadAddress,
						   input clk, rst,
						   output [15:0] Instruction);

reg [7:0] Instructions [N-1:0];

	assign Instruction = {Instructions[ReadAddress],Instructions[ReadAddress+1]};

always @(posedge clk, negedge rst)
begin
	
	if(!rst)
	begin
	for (i = 0; i<16; i=i+1)
		Instructions[i]<=0;
	
	//Format: 16h"abcd" where a= opcode, b=op1, c=op2, d=function code
	/*//Test Values for Hazards:
		//ADD R0 R1: R0 = 0 + 1 = 1
		Instructions[0]<=8'h10;
		Instructions[1]<=8'h10;
		//LW R0 0(R2): R4 = data in mem[2]
		Instructions[2]<=8'h60;	
		Instructions[3]<=8'h02;		
		//BGT op0 04 - > True : pc = 6+8= e, False: pc = 4
		Instructions[4]<=8'hD0;
		Instructions[5]<=8'h04;
		//SUB R0 R1: R0 = 3 - 1 = 3
		Instructions[6]<=8'h10;
		Instructions[7]<=8'h11;
		//Instruction 30 should be an unknown opcode exception
	//*/
		//Add R1, R2
		Instruction[0] = ;
		Instruction[1] = ;
		//Sub R2, R13
		Instruction[2] = ;
		Instruction[3] = ;
		//MOV R4, R8
		Instruction[4] = ;
		Instruction[5] = ;
		//OR R8, 0000
		Instruction[6] = ;
		Instruction[7] = ;
		//
		Instruction[8] = ;
		Instruction[9] = ;
		//
		Instruction[10] = ;
		Instruction[11] = ;
		//
		Instruction[12] = ;
		Instruction[13] = ;
		//
		Instruction[14] = ;
		Instruction[15] = ;
		//
		Instruction[16] = ;
		Instruction[17] = ;
		//
		Instruction[18] = ;
		Instruction[19] = ;
		//
		Instruction[20] = ;
		Instruction[21] = ;
		//
		Instruction[22] = ;
		Instruction[23] = ;
		//
		Instruction[24] = ;
		Instruction[25] = ;
		//
		Instruction[26] = ;
		Instruction[27] = ;
		//
		Instruction[28] = ;
		Instruction[29] = ;
		//
		Instruction[30] = ;
		Instruction[31] = ;
		//
		Instruction[32] = ;
		Instruction[33] = ;
		//
		Instruction[34] = ;
		Instruction[35] = ;
		//
		Instruction[36] = ;
		Instruction[37] = ;
		//
		Instruction[38] = ;
		Instruction[39] = ;
		//
		Instruction[40] = ;
		Instruction[41] = ;
		//
		Instruction[42] = ;
		Instruction[43] = ;
		//
		Instruction[44] = ;
		Instruction[45] = ;
		//
		Instruction[46] = ;
		Instruction[47] = ;
		//
		Instruction[48] = ;
		Instruction[49] = ;
	
	
	end
end
endmodule
