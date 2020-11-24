`include "CPU.v"

module CPU_Fixture();
reg clk, rst;
reg i;
CPU CPU(.clk(clk), .rst(rst));

initial
    $vcdpluson;
	
initial
begin
	//Here, Each clk cycle is #20 or 20 ns
	clk = 1'b0;
	forever #10 clk = ~clk;
end

initial
begin

	$monitor("\nPC: %h\nRegisters:\n[0]:%h\n[1]:%h\n[2]:%h\n[3]:%h\n[4]:%h\n[5]:%h\n[6]:%h\n[7]:%h",
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
	#180 $finish;

endmodule
