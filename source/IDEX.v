module IDEX(input [15:0]OP1In, OP2In, InstructionIn,
			input [3:0] ALUOPIn,
			input clk, rst,
			output reg [3:0] ALUOPOut,
			output reg [15:0] OP1Out, OP2Out, InstructionOut);
						   
integer i;
always @(posedge clk, negedge rst)
begin
	
	if(!rst)
	begin
		OP1Out=0;
		OP2Out=0;
		ALUOPOut=0;
		InstructionOut=0;
	end
	else
	begin
		OP1Out=OP1In;
		OP2Out=OP2In;
		ALUOPOut=ALUOPIn;
		InstructionOut=InstructionIn;
	end
end
endmodule