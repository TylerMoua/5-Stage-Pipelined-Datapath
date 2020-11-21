module BranchEquator(input [15:0] A, B, 
					 input [2:0]  BranchSelect,
					 input Branch, Jump,
					 wire  [15:0] Result,
					 wire Negative, Zero, BranchResult;
					 output reg BranchingSoFlush);

wire [15:0] Result1, Result2;

always @(*)
begin

	//Default Values:
	Negative = 1'b0;
	Zero = 1'b0;
	Result = A - B;
	
	//Test Result for flags:
	if(Result1 < 3'b000)
		Negative = 1'b1;
	if (Result1 == 3'b000)
		Zero = 1'b1;
	
	//Test Flags for BranchResult
	case(BranchSelect)
	begin
		//BLT
		2'b00: BranchingSoFlush = (Negative & Branch) | Jump;
		//BGT
		2'b01: BranchingSoFlush = (!Negative & Branch) | Jump;
		//BEQ, covers 2'b10, 2'b11
		default: BranchingSoFlush = (Zero & Branch) | Jump;
	endcase
end
endmodule
