`include "InstructionMemory.v"

module InstructionMemory_Fixture;

reg [15:0]ReadAddress;
reg clk, rst;
wire [15:0] Instruction;

initial
begin
	$display("\nResults:");
end
InstructionMemory IM(.ReadAddress(ReadAddress),.clk(clk), .rst(rst), .Instruction(Instruction));
initial
    $vcdpluson;
	
initial
begin
	clk = 1'b0;
	forever #10 clk = ~clk;
end

initial
begin

	rst = 1'b0;
	#8 rst =1'b1;
end

initial
begin
	ReadAddress = 0;
	@(posedge clk);
	ReadAddress = 1;
	@(posedge clk);
	ReadAddress = 2;
	@(posedge clk);
	ReadAddress = 3;
	@(posedge clk);
	ReadAddress = 4;


	
end

initial
begin
	#100 $finish;
end

endmodule
