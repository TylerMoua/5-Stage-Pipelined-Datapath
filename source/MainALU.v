module MainALU(input [15:0]A, B, 
		   input [2:0] ALUControl,
		   output reg [31:0] Result,
		   output reg Zero, Negative, Overflow);

wire [15:0] Result1, Result2;

always @(*)
begin

	//Default Values:
	Negative = 1'b0;
	Zero = 1'b0;
	Overflow = 1'b0;
	Result2= 0;
	case (ALUControl)
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
	
	//Flag Assignemnts:
	if(Result1 < 3'b000)
		Negative = 1'b1;
	if (Result1 == 3'b000)
		Zero = 1'b1;
		
	/*
	Check for overlow with the following:
	if we have a negative result with two positive values (Left)
	Ex. (1) & ~(0) & ~(0)  = 1
	OR
	we have a positive result with two negative values (Right)
	Ex. ~(0) & 1 & 1  = 1
	Note that we are testing result1
	*/
	if ((Result1[15]&(~A[15])&(~B[15])) | (~Result1[15]&A[15]&B[15]))
		Overflow = 1'b1;

	//Final assignment:
	Result={Result2, Result1};
end
endmodule
