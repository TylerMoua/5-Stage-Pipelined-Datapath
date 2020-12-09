module SignExtendWB(input [15:0] a, b,
		  output reg [31:0] ResultA, ResultB);
always @(*)
begin

	ResultA = {a[15],a[15],a[15],a[15],
			   a[15],a[15],a[15],a[15],
			   a[15],a[15],a[15],a[15],
			   a[15],a[15],a[15],a[15],
			   a};
	ResultB = {b[15],b[15],b[15],b[15],
			   b[15],b[15],b[15],b[15],
			   b[15],b[15],b[15],b[15],
			   b[15],b[15],b[15],b[15],
			   b};
end
endmodule
