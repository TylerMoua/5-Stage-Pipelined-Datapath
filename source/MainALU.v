module MainALU(input signed [15:0]Op1, Op2, 
		   input [2:0] ALUControl,
		   output reg Overflow,
		   output reg signed [31:0] Result);

reg signed [16:0] Result1;
reg signed [15:0] Result2;

always @(*)
begin
	//Default:
	Overflow = 1'b0;
	case (ALUControl)
		//ADD
		3'b000: 
		begin
			Result1 = Op1 + Op2;
			Overflow = Result1[16];	
		end
		//SUB
		3'b001: 
		begin	
			Result1 = Op1 - Op2;
			Overflow = Result1[16];	
		end
		//MOVE
		3'b010: Result1 = Op2;
		//SWAP
		3'b011: 
		begin
			Result1 = Op2;
			Result2 = Op1;
		end
		//AND
		3'b100: Result1 = Op1 & Op2;
		//OR - 101, 110, or 111
		3'b101: Result1 = Op1 | Op2;
		default: Result1 = Op1 | Op2;
	endcase
	Result={Result2, Result1[15:0]};
end
endmodule
