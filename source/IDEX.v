module IDEX(input [15:0]OP1In, OP2In, InstructionIn, SEImmdIn, R15In,
			input [3:0] ALUOPIn,
			input clk, rst, flush, StopPC,
			output reg [3:0] ALUOPOut,
			output reg [15:0] OP1Out, OP2Out, InstructionOut,SEImmdOut, R15Out);
						   
always @(posedge clk, negedge rst)
begin
	
	if(!rst)
	begin
	end
	else if ((flush)||(StopPC==1'b1))
	begin
		InstructionOut <= 16'hxxxx;
	end
	else
	begin
		SEImmdOut <=SEImmdIn;
		OP1Out<=OP1In;
		OP2Out<=OP2In;
		ALUOPOut<=ALUOPIn;
		InstructionOut<=InstructionIn;
		R15Out <= R15In;
	end
end
endmodule
