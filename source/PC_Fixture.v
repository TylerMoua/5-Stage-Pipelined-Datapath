`include "PC.v"

module PC_Fixture;

reg [15:0] NewPC;
reg clk, rst;
reg Halt, StopPC;
wire [15:0] PC;


PC ProgramCounter(.NewPC(NewPC), .clk(clk), .rst(rst), .Halt(Halt), .StopPC(StopPC), .PC(PC));

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
	Halt = 0;
	StopPC = 0 ;
	NewPC = 16'h0000;
	@(posedge clk);
	NewPC = 16'h0010;
	@(posedge clk);
	NewPC = 16'h0100;
	@(posedge clk);
	Halt = 1;
	NewPC = 16'h1000;
	@(posedge clk);
end

initial
	#100 $finish;


endmodule
