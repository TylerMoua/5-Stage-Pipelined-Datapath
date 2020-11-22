`include "BranchEquator.v"

module BranchEquator_Fixture;

reg [15:0] A, B;
reg [2:0]  BranchSelect;
reg Branch, Jump;
wire BranchingSoFlush;

initial
begin
	$display("\nResults:");
	$monitor("A= %b B= %b BranchingSoFlush = %b\n", A, B, BranchingSoFlush);
end
BranchEquator BE(.A(A), .B(B), .BranchSelect(BranchSelect), .Branch(Branch), .Jump(Jump), .BranchingSoFlush(BranchingSoFlush));

initial
        $vcdpluson;


initial
begin
	Jump = 1'b0;
	Branch = 1'b1;
	$display("\nBLT:");
	BranchSelect = 2'b00;
	A = 1;
	B = 0;
	#10;
	A = 1;
	B = 1;
	#10;
	A = 0;
	B = 1;
	#10;
	$display("\nBGT:");
	BranchSelect = 2'b01;
	A = 1;
	B = 0;
	#10;
	A = 1;
	B = 1;
	#10;
	A = 0;
	B = 1;
	#10;
	$display("\nBEQ:");
	BranchSelect = 2'b10;
	A = 1;
	B = 0;
	#10;
	A = 1;
	B = 1;
	#10;
	A = 0;
	B = 1;
	#10;
	$display("\nJump:");
	Jump = 1'b1;
	BranchSelect = 2'b00;
	A = 1;
	B = 0;
	#10;
	BranchSelect = 2'b01;
	A = 1;
	B = 1;
	#10;
	BranchSelect = 2'b11;
	A = 0;
	B = 1;
	#10;
	
end

initial
begin
	#140 $finish;
end

endmodule
