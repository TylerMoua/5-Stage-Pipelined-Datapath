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
		//AND
		4'b1001: ALUControl = 100;
		//OR
		4'b1010: ALUControl = 101;
		//All other cases require adding. Branching not handled here.
		default: ALUControl = 000;
	endcase
end
endmodule
