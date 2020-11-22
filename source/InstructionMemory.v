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
		for (i = 0; i<16; i=i+1)
			Instructions[i]<={16'h1010};
		
	end
	else
	
		Instruction <= Instructions [ReadAddress];
end
endmodule
