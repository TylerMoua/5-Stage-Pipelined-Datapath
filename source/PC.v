module PC(input [15:0] NewPC,
		  input clk, rst, Halt, StopPC,
		  output reg [15:0] PC);
reg [15:0] PreviousPC;
always @(posedge clk, negedge rst)
begin
	if(!rst)
	begin
		PC = 0;
		PreviousPC = 0;
	end
	else
	begin
	//May not be functional yet.
	//May need more logic is needed to deal with these control signals
		if(Halt)
			PC <= PreviousPC;
		else if(StopPC)
			PC <= PreviousPC;
		else
		begin
			//Output expected with no hazards in execution.
			PreviousPC <= NewPC;
			PC <= NewPC;
		end
	end
end
endmodule
