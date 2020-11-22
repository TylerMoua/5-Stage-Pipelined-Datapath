module ALUControlUnit(input [3:0] ALUOP, FunctionCode,
				   output reg [2:0] ALUControl);

always @(*)
begin
	case (ALUOP)
		//A-TYPE
		4'b0001:
		begin
			case (FunctionCode)
				//ADD
				4'b0000: ALUControl = 000;
				//SUB
				4'b0001: ALUControl = 001;
				//MOVE
				4'b1110: ALUControl = 010;
				//SWAP
				4'b1111: ALUControl = 011;
				default ALUControl = 011;
			endcase
		end
	endcase
end
endmodule