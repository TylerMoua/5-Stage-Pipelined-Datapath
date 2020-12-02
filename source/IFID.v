module IFID(input [15:0]PCIN, InstructionIn,
			input clk, rst, FlushIn,
			output reg FlushOut,
			output reg [15:0] PCOUT, InstructionOut);
						   
always @(posedge clk, negedge rst)
begin
	
	if(!rst)
	begin

	end
	else if(FlushIn)
	begin
	end
	else
	begin
		InstructionOut<=InstructionIn;
		PCOUT <= PCIN;
		FlushOut <=FlushIn;
	end
end
endmodule
