module SignExtendMEM(input [7:0] a,
		  output reg [15:0] Result);
always @(*)
begin

	Result = {a[7],a[7],a[7],a[7],
			  a[7],a[7],a[7],a[7],
			  a};

end
endmodule
