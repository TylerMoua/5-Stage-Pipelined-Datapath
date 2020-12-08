module PC(input [15:0] NewPC,
		  input clk, rst, Halt, StopPC,
		  output reg StayHalted,
		  output reg [15:0] PC);

always @(posedge clk, negedge rst)
begin
	if(!rst)
	begin
		PC <= 0;
		StayHalted <= 0;
	end
	else
	begin
		//If we have a halt, do nothing
		if(Halt || StayHalted)
		begin
			StayHalted = 1;
		end
		else 	
		begin
			if(StopPC ==1'b1)
			begin
				PC <= NewPC-16'h0002;
			end
			else
			begin
				//Output expected with no hazards in execution.
				PC <= NewPC;
			end
		end
	end
end
endmodule
