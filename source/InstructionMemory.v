module InstructionMemory #(parameter N = 16)
						  (input [15:0]ReadAddress,
						   input clk, rst,
						   output [15:0] Instruction);

reg [7:0] Instructions [N-1:0];

	assign Instruction = {Instructions[ReadAddress],Instructions[ReadAddress+1]};

always @(posedge clk, negedge rst)
begin
	
	if(!rst)
	begin
		//for (i = 0; i<16; i=i+1)
		//	Instructions[i]<=0;
	
	//Format: 16h"abcd" where a= opcode, b=op1, c=op2, d=function code
	//Test Values for Hazards:
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

	end
end
endmodule
