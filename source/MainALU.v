module MainALU(input signed [15:0]A, B, 
		   input [2:0] ALUControl,
		   input rst,
		   output reg Overflow,
		   output reg signed [31:0] Result);

reg signed [16:0] Result1;
reg signed [15:0] Result2;

always @(*)
begin
	//Default:
	Overflow = 1'b0;
	if(!rst)
		Result = 0;
	else
	begin
		case (ALUControl)
			//ADD
			3'b000: 
			begin
				Result1 = A + B;
			end
			//SUB
			3'b001: 
			begin	
				Result1 = A - B;
			end
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
		
		Overflow = Result1[16];	
		Result={Result2, Result1[15:0]};
	end
end
endmodule
