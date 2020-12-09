module ShiftLeft(input [15:0] a,
		  output reg [15:0] Result);
always @(*)
begin

	Result = a << 1;

end
endmodule
