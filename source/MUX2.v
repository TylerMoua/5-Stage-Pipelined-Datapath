module MUX2(input [15:0] four, eight, twelve,
			input [1:0] offsetSelect,
			output reg [15:0] Result);
always @(*)
begin
	case (offsetSelect)
		//ALU Result
		2'b00: Result = four;
		//16 bit sign extended
		2'b01: Result = eight;
		//8 bit zero extended : 10, 11
		default: Result = twelve;
	endcase
end
endmodule
