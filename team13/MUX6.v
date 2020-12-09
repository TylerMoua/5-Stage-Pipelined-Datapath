module MUX6(input [15:0]A,B, ForwardValue,
			input StoreOffset, Forward,
			output reg [15:0] Result);
always @(*)
begin
	if(Forward)
	begin
		Result = ForwardValue;
	end
	else
	begin
	Result =  A;
	if(StoreOffset)
		Result = B;
	end
end
endmodule
