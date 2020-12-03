module RegisterForwardingUnit(input [3:0] OP1, BTBOP1, BTBOP2, OAOP1, OAOP2,
							  output reg [1:0] ForwardToMux3, ForwardToMux4, ForwardToMux5,
							  output reg HazardDetected);
							 
always @(*)
begin
	ForwardToMux3=00;
	ForwardToMux4=00;
	ForwardToMux5=00;
	
	if(OP1 == BTBOP1)
	begin
		ForwardToMux5 = 01;
		HazardDetected=1;
	end
	else if(OP1 == OAOP1)
	begin
		ForwardToMux5 = 10;
		HazardDetected=1;
	end
	
	if(OP1 == BTBOP2)
	begin
		ForwardToMux3 = 01;
		HazardDetected=1;
	end 
	else if(OP1 == OAOP2)
	begin
		ForwardToMux3 = 10;
		HazardDetected=1;
	end
end
endmodule
