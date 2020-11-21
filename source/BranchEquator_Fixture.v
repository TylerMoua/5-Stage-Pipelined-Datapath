`include "BranchEquator.v"

module BranchEquator_Fixture;

reg [15:0] A, B;
reg [2:0]  BranchSelect;
reg Branch, Jump;
wire Overflow, BranchingSoFlush;

initial
begin
	$display("\nResults:");
	$monitor("A= %b B= %b BranchingsoFlush = %b\n", A, B, BranchingSoFlush);
end
ALU alu(A, B, CTRL, R);

initial
begin
	Jump = 1b'0;
	Branch = 1'b1;
	$display("\nBLT:");
	BranchSelect = 2'b00;
	A = 20;
	B = 15;
	#10;
	A = 10;
	B = 10;
	#10;
	A = 15;
	B = 20;
	#10;
	$display("\nBGT:");
	BranchSelect = 2'b01;
	A = 20;
	B = 15;
	#10;
	A = 10;
	B = 10;
	#10;
	A = 15;
	B = 20;
	#10;
	$display("\nBEQ:");
	BranchSelect = 2'b10;
	A = 20;
	B = 15;
	#10;
	A = 10;
	B = 10;
	#10;
	A = 15;
	B = 20;
	#10;
	$display("\nJump:");
	Jump = 1'b1;
	BranchSelect = 2'b00;
	A = 20;
	B = 15;
	#10;
	BranchSelect = 2'b01;
	A = 10;
	B = 10;
	#10;
	BranchSelect = 2'b10;
	A = 15;
	B = 20;
	#10;
	
end

initial
begin
	#140 $finish;
end

endmodule
