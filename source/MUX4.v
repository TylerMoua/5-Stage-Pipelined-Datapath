module MUX4(input [15:0] Op1, Op2, Btb, oneAway,
			input hazard,
		  input Jump,ForwardToMux4,
		  output reg [15:0] Result);
always @(*)
begin
	case (Jump)
		1'b0: Result = Op2;
		1'b1: Result = Op1;
	endcase
	if(hazard)
	begin
		case (ForwardToMux4)
		1'b0: Result = Btb;
		1'b0: Result = oneAway;
	endcase
	end
end
endmodule
