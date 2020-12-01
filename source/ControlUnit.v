module ControlUnit(input [3:0] OpcodeID, OpcodeWB, FunctionCode,
				   input Overflow,
				   output reg RegWrite, Branch, Jump, Halt, WriteOP2, MemRead, ALUSRC1, ALUSRC2, memToReg,
				   output reg OffsetSelect, StoreOffset,
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
			memWrite=0;
		end
		//Load Byte Unsigned
		4'b1001:
		begin
			RegWrite=1;
			MemRead=1;
			ALUOP = 0100;
			memWrite=0;
			
			
		end
		//C-Type
		4'b1001:
		begin
		end
		//D-Type
		4'b1001:
		begin
		end
	endcase
	
////////////////////////////////////////////
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
