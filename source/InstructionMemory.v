module InstructionMemory #(parameter N = 10)
						  (input [15:0]ReadAddress,
						   input clk, rst,
						   output reg [15:0] Instruction);
						   
reg [N-1:0] Instructions [15:0];
always @(posedge clk, negedge rst)
begin
	if(!rst)
		Instruction = 0;
	else
		Instruction = Instructions [ReadAddress];
end
endmodule
