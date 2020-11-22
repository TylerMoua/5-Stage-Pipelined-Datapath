module InstructionMemory #(parameter N = 16)
						  (input [15:0]ReadAddress,
						   input clk, rst,
						   output reg [15:0] Instruction);
						   
reg [15:0] Instructions [N-1:0];
integer i;
always @(posedge clk, negedge rst)
begin
	
	if(!rst)
	begin
		//Test Value
		//for (i = 0; i<16; i=i+1)
		//	Instructions[i]<=0;
		//Format: 16h"abcd" where a= opcode, b=op1, c=op2, d=function code
		//ADD R0 R1
		Instructions[0]<=16'h1010;
		//SUB R2 R3
		Instructions[1]<=16'h1231;
		//Move R4 R5 
		Instructions[2]<=16'h145e;
		//Swap R6 R7
		Instructions[3]<=16'h167f;
		
		

	end
	else
	
		Instruction <= Instructions [ReadAddress];
end
endmodule
