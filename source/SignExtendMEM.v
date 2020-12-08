module SignExtendMEM(input [7:0] a,
		  output reg [15:0] Result);
always @(*)
begin
	//We don't access negative memory
	Result = {8'h00, a};

end
endmodule
