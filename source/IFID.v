module IFID(input [15:0]PCIN, InstructionIn,
			input clk, rst,
			output reg [15:0] PCOUT, InstructionOut);
						   
integer i;
always @(posedge clk, negedge rst)
begin
	
	if(!rst)
	begin
		InstructionOut=0;
		PCOUT=0;
	end
	else
	begin
		InstructionOut=InstructionIn;
		PCOUT = PCIN;
	end
end
endmodule
