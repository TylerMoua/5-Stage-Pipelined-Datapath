module MUX4(input [31:0]Btb, oneAway,
			input [15:0] Op,
			input hazard,
			input [2:0]ForwardToMux4,
			output reg [15:0] Result);
always @(*)
begin
	Result = Op;
	if(hazard)
	begin
		case (ForwardToMux4)
		3'b001: Result = Btb [15:0];
		3'b010: Result = Btb [31:16];
		3'b011: Result = oneAway [15:0];
		3'b100: Result = oneAway [31:16];
	endcase
	end

end
endmodule
