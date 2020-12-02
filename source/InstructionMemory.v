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
		//ADD R0 R1
		Instructions[0]<=16'h1010;
		//SUB R2 R3
		Instructions[2]<=16'h1231;
		//Move R4 R5 
		Instructions[4]<=16'h145e;
		//Swap R6 R7
		Instructions[6]<=16'h167f;
	*/	
	///*
		//Test Values for B-Type
		//LBU R0 0(R1)
		Instructions[0]<=16'h4010;
		//SB R2 0(R3)
		Instructions[2]<=16'h5230;
		//LW R4 0(R5) 
		Instructions[4]<=16'h6450;
		//SW R6 0(R7)
		Instructions[6]<=16'h7670;
	//*/
	end
end
endmodule
