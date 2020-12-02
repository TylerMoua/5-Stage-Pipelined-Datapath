module BranchEquator(input [15:0] A, B, 
					 input [1:0]  BranchSelect,
					 input Branch, Jump,
					 output reg BranchingSoFlush);

reg Negative, Zero;

always @(*)
begin
	//Default Values:
	Negative = 1'b0;
	Zero = 1'b0;
	BranchingSoFlush=1'b0;
	//Test Result for flags:
	if(A < B)
		Negative = 1'b1;
	if (A == B)
		Zero = 1'b1;
	//Test Flags for BranchResult
	case(BranchSelect)
		//BLT
		2'b00: BranchingSoFlush = (Negative & Branch) | Jump;
		//BGT
		2'b01: BranchingSoFlush = (!Negative & !Zero & Branch) | Jump;
		//BEQ, covers 2'b10, 2'b11
		2'b10: BranchingSoFlush = (Zero & Branch) | Jump;
		2'b11: BranchingSoFlush = (Zero & Branch) | Jump;
		default: BranchingSoFlush = 0;
	endcase
end
endmodule
