module ControlUnit(input [3:0] Opcode, FunctionCode,
				   input Overflow,
				   output reg RegWrite, Branch, Jump, Halt, WriteOP2,
				   output reg [3:0] ALUOP);


always @(*)
begin
	WriteOP2=0;
	//NEED TO FIX SWAP CONTROL SIGNAL
	case (Opcode)
		//A-TYPE
		4'b0001:
		begin
			RegWrite = 1;
			ALUOP = Opcode;
			Branch = 0;
			Jump = 0;
			Halt = 0;
			if(FunctionCode == 4'b1111)
			 WriteOP2=1;
			
		end
	endcase
end
endmodule
