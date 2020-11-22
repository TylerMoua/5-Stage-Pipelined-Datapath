module ControlUnit(input [3:0] Opcode,
				   input Overflow,
				   output reg RegWrite, Branch, Jump, Halt, WriteOP2,
				   output reg [3:0] ALUOP);

always @(*)
begin
	//NEED TO FIX SWAP CONTROL SINAL
	case (Opcode)
		//A-TYPE
		4'b0001:
		begin
		RegWrite = 1;
		ALUOP = 4'b0001;
		Branch = 0;
		Jump = 0;
		Halt = 0;
		WriteOP2 = 0;
		end
	endcase
end
endmodule
