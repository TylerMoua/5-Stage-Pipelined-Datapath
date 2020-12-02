module MUX1(input [15:0]A,B, 
			input BranchingSoFlush,
			output reg [15:0] Result);
always @(*)
begin
	Result =  A;
	if(BranchingSoFlush)
		Result = B;

end
endmodule
