module RegisterFile(input [15:0]ReadAddress, 
					output reg [15:0] Instruction);
						   
reg [N-1:0] Instructions [15:0] 
always @(*)
begin
	Instruction = Instructions [ReadAddress];
end
endmodule
