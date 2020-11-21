module BranchEquator(input [15:0]A, B, 
		   input [2:0] BranchSelect,
		   output reg [31:0] BranchResult);

wire [15:0] Result1, Result2;

always @(*)
begin

	//Default Values:
	Negative = 1'b0;
	Zero = 1'b0;
	Overflow = 1'b0;
	Result2= 0;
	case (BranchSelect)
		//ADD
		3'b000: Result1 = A + B;
		//SUB
		3'b001: Result1 = A - B;
		//MOVE
		3'b010: Result1 = B;
		//SWAP
		3'b011: 
		begin
			Result1 = B;
			Result2 = A;
		end
		//AND
		3'b100: Result1 = A & B;
		//OR - 101, 110, or 111
		3'b101: Result1 = A | B;
		default: Result1 = A | B;

	endcase
	
	//Final assignment:
	BranchResult={Result2, Result1};
end
endmodule
