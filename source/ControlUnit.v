module ControlUnit(input [3:0] OpcodeID, OpcodeWB, FunctionCode,
				   input Overflow,
				   output reg RegWrite, Branch, Jump, Halt, WriteOP2,
				   output reg [3:0] ALUOP);


always @(*)
begin
	WriteOP2=0;
	//NEED TO FIX SWAP CONTROL SIGNAL
	case (OpcodeID)
		//A-TYPE
		4'b0001:
		begin
			ALUOP = OpcodeID;
			Branch = 0;
			Jump = 0;
			Halt = 0;
			
		end
	endcase
	case (OpcodeWB)
		//A-TYPE
		4'b0001:
		begin
			RegWrite = 1;
			if(FunctionCode == 4'b1111)
			 WriteOP2=1;
			
		end	
	endcase
end
endmodule
