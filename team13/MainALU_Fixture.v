`include "MainALU.v"

module MainALU_fixture;

reg [15:0]A,B;
reg [2:0] ALUControl;
wire Overflow;
wire [31:0] Result;

initial
begin
	$display("\nResults:");
	$monitor("A= %h B= %h R = %h \nOverFlow: %b\n", A, B, Result, Overflow);
end
MainALU alu(.A(A), .B(B), .ALUControl(ALUControl), .Overflow(Overflow), .Result(Result));

initial
begin
	$display("\nAddition:");
	ALUControl=3'b000;
	A = 16'hffff;
	B = 16'hffff;
	#10;
	A = 1;
	B = 1;
	#10;
	$display("\nSub:");
	ALUControl=3'b001;
	A = 16'hffff;
	B = 16'h0001;
	#10;
	A = 16'h0000;
	B = 16'h0001;
	#10;
	A = 16'h0010;
	B = 16'h0001;
	#10;
	$display("\nMove:");
	ALUControl=3'b010;
	A = 5;
	B = 2;
	#10;
	$display("\nSwap:");
	ALUControl=3'b011;
	A = 5;
	B = 2;
	#10;
	$display("\nAND:");
	ALUControl=3'b100;
	A = 16'h0f0f;
	B = 16'h0fff;
	#10;
	$display("\nOR:");
	ALUControl=3'b101;
	A = 16'h0f0f;
	B = 16'h0fff;
end

initial
begin
	#140 $finish;
end

endmodule
