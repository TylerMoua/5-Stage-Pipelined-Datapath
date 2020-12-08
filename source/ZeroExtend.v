module ZeroExtend(input [7:0] a,
		  output reg [15:0] Result);
always @(*)
begin
	Result = {8'h00,a};
end
endmodule
