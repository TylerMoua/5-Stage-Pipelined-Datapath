module MUX5(input [15:0] SEIMMD, Op1, Btb, oneAway,
			input hazard,
		  input [2:0] ALUSRC,
		  input [1:0] ForwardToMux5,
		  output reg [15:0] Result);
always @(*)
begin
	case (ALUSRC)
		3'b000: Result = Op1;
		3'b001: Result = SEIMMD;
	endcase
	if(hazard)
	begin
		case (ForwardToMux5)
		2'b01: Result = Btb;
		2'b10: Result = oneAway;
	endcase
	end
end
endmodule
