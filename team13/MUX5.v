module MUX5(input [31:0] Btb, oneAway,
			input [15:0] SEIMMD, Op1, 
			input hazard, ALUSRC,
			input [2:0] ForwardToMux5,
			output reg [15:0] Result);
always @(*)
begin
	case (ALUSRC)
		1'b0: Result = Op1;
		1'b1: Result = SEIMMD;
	endcase
	if(hazard)
	begin
		case (ForwardToMux5)
		3'b001: Result = Btb [15:0];
		3'b010: Result = Btb [31:16];
		3'b011: Result = oneAway [15:0];
		3'b100: Result = oneAway [31:16];
	endcase
	end
end
endmodule
