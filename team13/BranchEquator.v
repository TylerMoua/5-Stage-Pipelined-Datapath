module BranchEquator(input [15:0] Op1,R15,
					 input [31:0] BTB, OneAway,
					 input [1:0]   BranchSelect,
					 input [2:0] HazardSelect,
					 input Hazard, Branch, Jump, 
					 output reg BranchingSoFlush);

reg Negative, Zero;
reg [15:0] Operand;

always @(*)
begin
	//Default Values:
	Negative = 1'b0;
	Zero = 1'b0;
	BranchingSoFlush=1'b0;
	Operand = Op1;
	
	if(Hazard)
	begin
		case(HazardSelect)
		3'b001: Operand = BTB [15:0];
		3'b010: Operand = BTB [31:16];
		3'b011: Operand = OneAway [15:0];
		3'b100: Operand = OneAway [31:16];
		endcase
	end
	//Test Result for flags:
	if(Operand < R15)
		Negative = 1'b1;
	if (Operand == R15)
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
