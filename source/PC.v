module PC(input [15:0] NewPC,
		  input clk, rst, Halt, StopPC,
		  output reg [15:0] PC);

always @(posedge clk, negedge rst)
begin
	if(!rst)
	begin
		PC <= 0;
	end
	else
	begin
		//If we have a halt, do nothing
		if(Halt)
		begin
		
		end
		else 	
		begin
			if(StopPC ==1'b1)
			begin
				PC <= NewPC-4'h0002;
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
