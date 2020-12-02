module MEMWB(input [15:0]InstructionIn, ReadDataIn, 
			input [31:0] ALUResultIn,
			input clk, rst,
			output reg [31:0] ALUResultOut,
			output reg [15:0] ReadDataOut,InstructionOut);
						   
always @(posedge clk, negedge rst)
begin
	
	if(!rst)
	begin

	end
	else
	begin
		ALUResultOut= ALUResultIn;
		ReadDataOut<=ReadDataIn;
		InstructionOut<=InstructionIn;
	end
end
endmodule
