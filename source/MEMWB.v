module MEMWB(input [15:0]InstructionIn, ReadDataIn, OP1In,
			input [31:0] ALUResultIn,
			input clk, rst,
			output reg [31:0] ALUResultOut, OneAwayForward,
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

//Forwarding:
always @(*)
begin
//If we have a load word:
		if((InstructionIn[15:12] == 4'b0110)||(InstructionIn[15:12]  == 4'b0100))
			OneAwayForward<=ReadDataIn;
		//if we have a store word:
		else if((InstructionIn[15:12] == 4'b0101)||(InstructionIn[15:12]  == 4'b0111))
			OneAwayForward<={16'h0000,OP1In};
		else
			OneAwayForward<=ALUResultIn;
end
endmodule
