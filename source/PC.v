module PC(input [15:0] NewPC,
		  input clk, rst,
		  input Halt StopPC,
		  output reg [15:0] PC);
reg [15:0] PreviousPC;
always @(posedge clk, negedge rst)
begin
	//Not functional yet.
	//More logic is needed to deal with these control signals
	if(!rst)
		begin
		if(Halt)
			PC = PreviousPC;
		else if(StopPC)
			PC = PreviousPC;
		else
		begin
			//Output expected with no hazards in execution.
			PreviousPC = PC;
			PC = NewPC;
		end
	end
	else
		//Tbh not sure what to implement here:
		begin
		PC = 0;
		PreviousPC = 0;
		end
end
endmodule
