module ControlUnit(input [3:0] OpcodeID, OpcodeEX, OpcodeMEM, OpcodeWB, FunctionCode,
				   input Overflow,
				   output reg RegWrite, Branch, Jump, Halt, WriteOP2, MemRead, 
				   output reg MemWrite, StoreOffset, ALUSRC2,
				   output reg [1:0] MemToReg, OffsetSelect, BranchSelect, ALUSRC1, 
				   output reg [3:0] ALUOP);


always @(*)
begin
//Default all Signals to 0
//Signals will be turned on when needed.
	WriteOP2=0;
	RegWrite=0;
	Branch=0;
	Jump=0;
	Halt=0;
	WriteOP2=0;
	MemRead=0;
	ALUSRC1=0;
	ALUSRC2=0;
	MemToReg=00;
	MemWrite=0;
	OffsetSelect=00; 
	StoreOffset=0;
	BranchSelect=0;
	//Instructions in ID
	case (OpcodeID)
		//AND
		4'b1001:
		begin
			OffsetSelect=01;			
		end	
		//OR
		4'b1010:
		begin
			OffsetSelect=01;			
		end	
		//BLT
		4'b1100:
		begin
			Branch=1;
			OffsetSelect=01;
		end	
		//BGT
		4'b1101:
		begin
			Branch=1;
			OffsetSelect=01;	
			BranchSelect=01;
		end	
		//BEQ
		4'b1110:
		begin
			Branch=1;
			OffsetSelect=01;
			BranchSelect=10;
		end			
		//Jump
		4'b0010:
		begin
			Jump = 1;
			OffsetSelect = 10;
		end			
		//Halt
		4'b0011:
		begin
			Halt=1;
		end	
	endcase

	//Instructions in EX
	case (OpcodeEX)
		//A-TYPE
		4'b0001:
		begin
			ALUOP = OpcodeEX;		
		end
		//AND
		4'b1001:
		begin
			ALUOP = OpcodeEX;
			ALUSRC1 =01;
		end	
		//OR
		4'b1010:
		begin
			ALUOP = OpcodeEX;
			ALUSRC1 =01;
		end	
		//Load Byte Unsigned
		4'b0100:
		begin
			ALUOP = OpcodeEX;
			ALUSRC2 =1;
		end
		//Store Byte
		4'b0101:
		begin
			ALUOP = OpcodeEX;
			ALUSRC2 =1;
		end
		//Load
		4'b0110:
		begin
			ALUOP = OpcodeEX;
			ALUSRC2 =1;
		end
		//Store
		4'b0111:
		begin
			ALUOP = OpcodeEX;
			ALUSRC2 =1;
		end
		//BLT
		4'b1100:
		begin
			ALUOP = OpcodeEX;
			ALUSRC1 =10;
		end	
		//BGT
		4'b1101:
		begin
			ALUOP = OpcodeEX;			
			ALUSRC1 =10;
		end	
		//BEQ
		4'b1110:
		begin
			ALUOP = OpcodeEX;
			ALUSRC1 =10;
		end			
	endcase
	
	//Instructions in MEM
	case (OpcodeMEM)
		//Load Byte Unsigned
		4'b0100:
		begin
			MemRead = 1;
		end
		//Store Byte
		4'b0101:
		begin
			MemWrite = 1;
			StoreOffset = 1;
		end
		//Load
		4'b0110:
		begin
			MemRead = 1;
		end
		//Store
		4'b0111:
		begin
			MemWrite = 1;
		end
	endcase
	//Instructions in WB
	case (OpcodeWB)
		//A-TYPE
		4'b0001:
		begin
			MemToReg = 00;
			RegWrite = 1;
			if(FunctionCode == 4'b1111)
			 WriteOP2=1;
		end
		//AND
		4'b1001:
		begin
			MemToReg = 00;
			RegWrite = 1;
		end	
		//OR
		4'b1010:
		begin
			MemToReg = 00;
			RegWrite = 1;
		end	
		//Load Byte Unsigned
		4'b0100:
		begin
			MemToReg = 10;
			RegWrite = 1;
		end
		//Load
		4'b0110:
		begin
			MemToReg = 01;
			RegWrite = 1;
		end
	endcase
end
endmodule
