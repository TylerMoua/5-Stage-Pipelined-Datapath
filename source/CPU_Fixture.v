`include "CPU.v"

module CPU_Fixture();
reg clk, rst;
reg i;
CPU CPU(.clk(clk), .rst(rst));

initial
    $vcdpluson;
	
initial
begin
	clk = 1'b0;
	forever #10 clk = ~clk;
end

initial
begin

	$monitor("\nPC: %h\nRegisters:\n%h\n%h\n%h\n%h\n%h\n%h\n%h\n%h",
			CPU.ProgramCounter.PC,
			CPU.RF.Registers[0], CPU.RF.Registers[1], CPU.RF.Registers[2], 
			CPU.RF.Registers[3], CPU.RF.Registers[4], CPU.RF.Registers[5],
			CPU.RF.Registers[6], CPU.RF.Registers[7]);			
end

initial

begin
	rst = 1'b0;
	#8 rst =1'b1;
end

initial
	#220 $finish;

endmodule
