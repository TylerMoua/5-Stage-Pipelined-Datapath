module BCHazardControlUnit(input [3:0] IDOP, EXOP, MEMOP, WBOP,
							input [1:0]Hazard,
							output reg StopPC);
						   
always @(*)
begin
	StopPC = 00;
	//if we have an A type hazard:
	if(Hazard[0])
	begin
		//if we have an A-type in ID:
		if(IDOP == 4'b0001)
		begin
			//if we have a LW in EX:
			if((EXOP == 4'b0110)||(EXOP == 4'b0100))
				StopPC=01;
		end
	end
	
	if(Hazard[1])
	begin
		//If we have a branch in ID:
		if((IDOP == 4'b1100)||(IDOP == 4'b1101)||(IDOP == 4'b1110))
		begin

			//if we have a A-type in EX:
			if(IDOP == 4'b0001)
			begin
				StopPC= 01;
			end
			//If we have a LW in MEM
			else if((MEMOP == 4'b0110)||(MEMOP == 4'b0100))
			begin
				StopPC=01;
			end
			//If we have a LW in EX
			else if((EXOP == 4'b0110)||(EXOP == 4'b0100))
			begin
				StopPC=01;
			end
		end
		
		
	end
end
endmodule
