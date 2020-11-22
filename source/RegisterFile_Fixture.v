`include "RegisterFile.v"

module RegisterFile_Fixture;

reg [3:0] ReadReg1,ReadReg2,WriteReg1,WriteReg2;
reg [15:0]  WriteData1, WriteData2;
reg clk, rst, RegWrite, WriteOP2;
wire [15:0] ReadData1, ReadData2, R15;

initial
begin
	$display("\nResults:");
	$monitor("\nRead Data1: %b\nRead Data2: %b\nR15:%b\n", ReadData1, ReadData2, R15);
end
RegisterFile RF(.ReadReg1(ReadReg1), .ReadReg2(ReadReg2),.WriteReg1(WriteReg1),.WriteReg2(WriteReg2), .WriteData1(WriteData1), .WriteData2(WriteData2),
				.clk(clk), .rst(rst), .RegWrite(RegWrite), .WriteOP2(WriteOP2),. ReadData1(ReadData1), .ReadData2(ReadData2), .R15(R15));

initial
    $vcdpluson;
	
initial
begin
	clk = 1'b0;
	forever #8 clk = ~clk;
end

initial
begin
	rst = 1'b0;
	#8 rst =1'b1;
end

initial
begin
	$display("\nWriting:");
	WriteReg1 = 4'b1111;
	WriteData1 = 65535;
	WriteReg2 = 4'b1010;
	WriteData2 = 2000;	
	RegWrite = 1;
	WriteOP2 = 1;	
	ReadReg1 = 4'b1111;
	ReadReg2 = 4'b1010;
	@(posedge clk);
	$display("\nReading:");

	
end

initial
begin
	#100 $finish;
end

endmodule
