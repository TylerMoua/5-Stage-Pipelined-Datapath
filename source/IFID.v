module IFID(input [15:0]PCIN, InstructionIn, OldInstruction,
			input clk, rst, FlushIn, Halt, StopPC,
			output reg FlushOut,
			output reg [15:0] PCOUT, InstructionOut);
						   
always @(posedge clk, negedge rst)
begin
	
	if((!rst)||(Halt))
	begin

	end
	else
	if(StopPC)
	begin
	InstructionOut<=OldInstruction;
	end
	else
	begin
		InstructionOut<=InstructionIn;
		PCOUT <= PCIN;
		FlushOut <=FlushIn;
	end
end
endmodule
