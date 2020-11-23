`include "ControlUnit.v"

module ControlUnit_Fixture;

reg [3:0] Opcode, FunctionCode;
reg Overflow;
wire RegWrite, Branch, Jump, Halt, WriteOP2;
wire [3:0] ALUOP;

initial
begin
	$display("\nResults:");
	$monitor("\nSignals:\nRegWrite: %h\nBranch: %h\nJump: %h\nHalt: %h\nWriteOP2: %h\nALUOP: %h",
			 RegWrite, Branch, Jump, Halt, WriteOP2, ALUOP);
end

ControlUnit CU(.Opcode(Opcode), .FunctionCode(FunctionCode), .Overflow(Overflow),
			   .RegWrite(RegWrite), .Branch(Branch), .Jump(Jump),
			   .Halt(Halt), .WriteOP2(WriteOP2), .ALUOP(ALUOP));
			   
initial
    $vcdpluson;
	

initial
begin
	Overflow = 0;
	Opcode=4'h1;
	FunctionCode=4'h0;
	#10;
	FunctionCode=4'h1;
	#10;
	FunctionCode=4'he;
	#10;
	FunctionCode=4'hf;
	#10;

	
end

initial
begin
	#100 $finish;
end

endmodule
