module MainALU(input [15:0]A, B, 
		   input [2:0] ALUControl,
		   output reg [15:0] Result,
		   output reg Zero, Negative, Overflow);
always @(*)
begin

	//Default Values:
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
	
	//Flag Assignemnts:
	if(Result < 3'b000)
		Negative = 1'b1;
	if (Result == 3'b000)
		Zero = 1'b1;
		
	/*
	Check for overlow with the following:
	if we have a negative result with two positive values (Left)
	Ex. (1) & ~(0) & ~(0)  = 1
	OR
	we have a positive result with two negative values (Right)
	Ex. ~(0) & 1 & 1  = 1
	*/
	if ((Result[15]&(~A[15])&(~B[15])) | (~Result[15]&A[15]&B[15]))
		Overflow = 1'b1;

end
endmodule
