module MainALU(input [15:0]A, B, 
		   input [2:0] ALUControl,
		   output reg [15:0] Result,
		   output reg Zero, Negative, Overflow);
always @(*)
begin
	Negative = 1'b0;
	Zero = 1'b0;
	Overflow = 1'b0;
	
	case (ALUControl)
		//ADD
		3'b000: Result = A + B;
		//SUB
		3'b001: Result = A - B;
		//MOVE
		3'b010: Result = B;
		//SWAP --NEED TO FIX
		3'b011: Result = A;
		//AND
		3'b100: Result = A & B;
		//OR - 101, 110, or 111
		3'b101: Result = A | B;
		default: Result = A | B;

	endcase
	
	if(Result > 0)
		Negative = 1'b1;
end
endmodule
