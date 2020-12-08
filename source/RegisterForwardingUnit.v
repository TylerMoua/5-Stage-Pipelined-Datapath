module RegisterForwardingUnit(input [3:0] OP1, OP2, BTBOP1, BTBOP2, OAOP1, OAOP2, OpcodeMEM, OpcodeWB, FunctionCodeMEM, FunctionCodeWB,
							  input [3:0] IDOP1, OpcodeEX,
							  output reg [2:0] ForwardToMux3,ForwardToMux4, ForwardToMux5,
							  output reg [1:0]HazardDetected);
							 
always @(*)
begin
	HazardDetected=00;
	ForwardToMux3=000;
	ForwardToMux4=000;
	ForwardToMux5=000;

//Branch Hazards: 
//IDOP1 deals with Mux4 Hazard[1] for branch hazards
	if(IDOP1 == OP1)
	begin
		ForwardToMux4 = 001;
		HazardDetected[1]=1;
	end
	else if(IDOP1 == BTBOP1)
	begin
		ForwardToMux4 = 011;
		HazardDetected[1]=1;
	end
	
	//Test for OP2 IF Swap(Only time that OP2 changes)
	if((OpcodeMEM == 0001)&& (FunctionCodeMEM ==1111))
	begin
		if(IDOP1 == OP2)
		begin
			ForwardToMux4 = 010;
			HazardDetected=1;
		end 
	end
	else if((OpcodeWB == 0001)&& (FunctionCodeWB ==1111))
	if(IDOP1 == BTBOP2)
	begin
		ForwardToMux4 = 100;
		HazardDetected=1;
	end

//OTHER:
//OP1 Deals with Mux5
	if(OP1 == BTBOP1)
	begin
		//if load
		if((OpcodeMEM == 4'b0110)||(OpcodeMEM == 4'b0100))
			ForwardToMux5 = 011;
		else
			ForwardToMux5 = 001;
		HazardDetected[0]=1;
	end
	else if(OP1 == OAOP1)
	begin
		ForwardToMux5 = 011;
		HazardDetected[0]=1;
	end
	
	//Test for OP2 IF Swap(Only time that OP2 changes)
	if((OpcodeMEM == 0001)&& (FunctionCodeMEM ==1111))
	begin
		if(OP1 == BTBOP2)
		begin		
		//if load
		if((OpcodeMEM == 4'b0110)||(OpcodeMEM == 4'b0100))
			ForwardToMux5 = 011;
		else
			ForwardToMux5 = 001;
			HazardDetected[0]=1;
		end 
	end
	else if((OpcodeWB == 0001)&& (FunctionCodeWB ==1111))
	if(OP1 == OAOP2)
	begin
		ForwardToMux5 = 100;
		HazardDetected[0]=1;
	end
	
//OP2 Deals with Mux3 and ONLY with A or B Type instructions.
	if((OpcodeEX==0001) || (OpcodeEX== 0100)|| (OpcodeEX== 0101)||
		(OpcodeEX==0110) || (OpcodeEX== 0111))
	begin
		if(OP2 == BTBOP1)
		begin		
		//if load
		if((OpcodeMEM == 4'b0110)||(OpcodeMEM == 4'b0100))
			ForwardToMux3 = 011;
		else
			ForwardToMux3 = 001;
			HazardDetected[0]=1;
		end
		else if(OP2 == OAOP1)
		begin
			ForwardToMux3 = 011;
			HazardDetected[0]=1;
		end
		
		//Test for OP2 IF Swap(Only time that OP2 changes)
		if((OpcodeMEM == 0001)&& (FunctionCodeMEM ==1111))
		begin
			if(OP2 == BTBOP2)
			begin
			//if load
			if((OpcodeMEM == 4'b0110)||(OpcodeMEM == 4'b0100))
				ForwardToMux3 = 011;
			else
				ForwardToMux3 = 001;
				HazardDetected[0]=1;
			end 
		end
		else if((OpcodeWB == 0001)&& (FunctionCodeWB ==1111))
		begin
			if(OP2 == OAOP2)
			begin
				ForwardToMux3 = 100;
				HazardDetected[0]=1;
			end
		end
	end
end
endmodule
