module MUX3(input [15:0] SEIMMD, Op2, Btb, oneAway, R15,
			input hazard,
		  input [2:0] ALUSRC,ForwardToMux3,
		  output reg [15:0] Result);
always @(*)
begin
	case (ALUSRC)
		3'b000: Result = Op2;
		3'b001: Result = SEIMMD;
		3'b010: Result = R15;
	endcase
	if(hazard)
	begin
		case (ForwardToMux3)
		3'b011: Result = Btb;
		default: Result = oneAway;
	endcase
	end
end
endmodule
