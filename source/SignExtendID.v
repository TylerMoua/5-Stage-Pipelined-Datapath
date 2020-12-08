module SignExtendID(input [3:0] a,
					input [11:0]b,
		  output reg [15:0] ResultA, ResultB);
always @(*)
begin
	//Zero Extention, we don't access negative memory locations
	ResultA = {12'h000,a};
	//SignExtention
	ResultB = {4'h0, b};
end
endmodule
