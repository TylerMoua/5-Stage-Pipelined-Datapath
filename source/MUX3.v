module MUX3(input [31:0] Btb, oneAway,
			input [15:0] SEIMMD, Op2, R15,
			input hazard, 
			input [1:0] ALUSRC, 
			input [2:0] ForwardToMux3,
			output reg [15:0] Result);
always @(*)
begin
	case (ALUSRC)
		2'b00: Result = Op2;
		2'b01: Result = SEIMMD;
		2'b10: Result = R15;
	endcase
	if(hazard)
	begin
		case (ForwardToMux3)
		3'b001: Result = Btb [15:0];
		3'b010: Result = Btb [31:16];
		3'b011: Result = oneAway [15:0];
		3'b100: Result = oneAway [31:16];
	endcase
	end
end
endmodule
