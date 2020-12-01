module MUX7(input [31:0] alu,eight,sixteen,
		  input [1:0] memToReg,
		  output [31:0] Result);
always @(*)
begin
	case (memToReg)
		//ALU Result
		2'b0: Result = alu;
		//16 bit sign extended
		2'b0: Result = sixteen;
		//8 bit zero extended
		default: Result = eight;
	endcase
end
endmodule
