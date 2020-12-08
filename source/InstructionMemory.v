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
		//Format: 16h"abcd" where a= opcode, b=op1, c=op2, d=function code
		//Add R1, R2 = 1120
		Instruction[0] = 8'h11;
		Instruction[1] = 8'h20;
		//Sub R2, R13= 12D1
		Instruction[2] = 8'h12;
		Instruction[3] = 8'hD1;
		//MOV R4, R8 = 148E
		Instruction[4] = 8'h14;
		Instruction[5] = 8'h8E;
		//OR R8, 0000= A800
		Instruction[6] = 8'hA8;
		Instruction[7] = 8'h00;
		//SWP R4, R6 = 146F
		Instruction[8] = 8'h14;
		Instruction[9] = 8'h6F;
		//[A]:LBU R7, 4(R9)=4794
		Instruction[10] = 8'h47;
		Instruction[11] = 8'h94;
		//[C]:ANDi R3, 4C =934c
		Instruction[12] = 8'h93;
		Instruction[13] = 8'h4c;
		//[E]:SUB R14, R14=1EE1
		Instruction[14] = 8'h1e;
		Instruction[15] = 8'he1;
		//[10]:SB R7, 6(R9) =5796
		Instruction[16] = 8'h57;
		Instruction[17] = 8'h96;
		//[12]:LW R6, 8(R9)=6698
		Instruction[18] = 8'h66;
		Instruction[19] = 8'h98;
		//[14]:BEQ R7, 4 = E704
		Instruction[20] = 8'hE7;
		Instruction[21] = 8'h04;
		//[16]:ADD R11, R1 =1b10
		Instruction[22] = 8'h1b;
		Instruction[23] = 8'h10;
		//[18] BLT R7, 5 = C705
		Instruction[24] = 8'hc7;
		Instruction[25] = 8'h05;
		//[1A] ADD R11, R2=1b20
		Instruction[26] = 8'h1b;
		Instruction[27] = 8'h20;
		//[1C] BGT R7, 2 =d702
		Instruction[28] = 8'hd7;
		Instruction[29] = 8'h02;
		//[1E] ADD R1, R1 = 1110
		Instruction[30] = 8'h11;
		Instruction[31] = 8'h10;
		//[20] ADD R1, R1 = 1110
		Instruction[32] = 8'h11;
		Instruction[33] = 8'h10;
		//[22] LW R8, 0(R9) = 6890
		Instruction[34] = 8'h68;
		Instruction[35] = 8'h90;
		//[24] ADD R8, R8 = 1880
		Instruction[36] = 8'h18;
		Instruction[37] = 8'h80;
		//[26] SW R8, 2(R9)= 7892
		Instruction[38] = 8'h78;
		Instruction[39] = 8'h92;
		//[28] LW R10, 2(R9)= 6a92
		Instruction[40] = 8'h6a;
		Instruction[41] = 8'h92;
		//[2A] ADD R12, R10 =1ca0
		Instruction[42] = 8'h1c;
		Instruction[43] = 8'ha0;
		//[2C] SUB R12, R13 = 1cd1
		Instruction[44] = 8'h1c;
		Instruction[45] = 8'hd1;
		//[2E] ADD R12, R13 = 1cd0
		Instruction[46] = 8'h1c;
		Instruction[47] = 8'hd0;
		//[30] Excpetion : 0f20
		Instruction[48] = 8'h0f;
		Instruction[49] = 8'h20;
	
	
	end
end
endmodule
