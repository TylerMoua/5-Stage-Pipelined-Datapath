module EXMEM(input [15:0]InstructionIn, OP1In, OP2In,
			input [31:0] ALUResultIn,
			input clk, rst,
			output reg [31:0] ALUResultOut, BTBForward,
			output reg [15:0] InstructionOut, OP1Out);
						   
always @(posedge clk, negedge rst)
begin
	
	if(!rst)
	begin

	end
	else
	begin
		OP1Out<=OP1In;
		ALUResultOut<=ALUResultIn;
		InstructionOut<=InstructionIn;
		BTBForward <= ALUResultIn;
	end
end
endmodule
