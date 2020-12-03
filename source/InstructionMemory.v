module InstructionMemory #(parameter N = 16)
						  (input [15:0]ReadAddress,
						   input clk, rst,
						   output [15:0] Instruction);

//NEED: reg [7:0] Instructions [100:0] where Instruction[0] and Instruction[1] = One instruction
reg [15:0] Instructions [N-1:0];

	assign Instruction = Instructions [ReadAddress];

always @(posedge clk, negedge rst)
begin
	
	if(!rst)
	begin
		//for (i = 0; i<16; i=i+1)
		//	Instructions[i]<=0;
		//Format: 16h"abcd" where a= opcode, b=op1, c=op2, d=function code
	/*
		//Test Values for A-Type
		//ADD R0 R1: 0= 0 + 1
		Instructions[0]<=16'h1010;
		//SUB R2 R3: 2 = 2 - 3 = -1 = ffff
		Instructions[2]<=16'h1231;
		//Move R4 R5: 5 = 4
		Instructions[4]<=16'h145e;
		//Swap R6 R7
		Instructions[6]<=16'h167f;
	//*/
	
	/*
		//Test Values for B-Type
		//LBU R0 9(R1)
		Instructions[0]<=16'h4010;
		//SB R2 0(R3)
		Instructions[2]<=16'h5230;
		//LW R4 0(R5): R4 = data in op5
		Instructions[4]<=16'h6450;
		//SW R6 1(R7): Mem of Op7 = data in op 6
		Instructions[6]<=16'h7670;
	//*/
	
	/*
		//Test Values for C-Type- AND OR
		//AND 0000 h0012 = 0000
		Instructions[0]<=16'h9012;
		//OR 0002 h0012 = 0012
		Instructions[2]<=16'hA212;		
		//AND 0012 0012 = 12
		Instructions[4]<=16'h9412;
		//OR A010 0012 = A012
		Instructions[6]<=16'hA612;
	//*/
	
	/*
		//Test Values for C-Type
		//BLT op1 04 - > True : pc = 2+8= a, False: pc = 4
		Instructions[0]<=16'hD104;
		//Shouldn't Execute
		Instructions[2]<=16'hA212;		
		//AND 0012 0012 = 12
		Instructions[4]<=16'h9412;
		//OR A010 0012 = A012
		Instructions[6]<=16'hA612;
		//ADD R0 R1: 0= 0 + 1
		Instructions[10]<=16'h1010;
	//*/
	/*
		//Test Values for C-Type
		//Jump 004 -> pc = 2+8= a
		Instructions[0]<=16'h3004;
		//Shouldn't Execute
		Instructions[2]<=16'hA212;		
		//AND 0012 0012 = 12
		Instructions[4]<=16'h9412;
		//OR A010 0012 = A012
		Instructions[6]<=16'hA612;
		//ADD R0 R1: 0= 0 + 1
		Instructions[10]<=16'h1010;
	//*/
	end
end
endmodule
