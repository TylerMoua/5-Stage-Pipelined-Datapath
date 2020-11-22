module MEMWB(input [15:0]InstructionIn, 
			input [31:0] DataIn,
			input clk, rst,
			output reg [31:0] DataOut,
			output reg [15:0] InstructionOut);
						   
always @(posedge clk, negedge rst)
begin
	
	if(!rst)
	begin

	end
	else
	begin
		DataOut<=DataIn;
		InstructionOut<=InstructionIn;
	end
end
endmodule
