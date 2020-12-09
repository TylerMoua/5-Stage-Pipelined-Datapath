`include "cpu.v"

module cpu_fixture();
reg clk, rst;
reg i;
cpu cpu(.clk(clk), .rst(rst));

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

	$monitor("\nPC: %h\nRegisters:\n[0]:%h\n[1]:%h\n[2]:%h\n[3]:%h\n[4]:%h\n[5]:%h\n[6]:%h\n[7]:%h\n[8]:%h\n[9]:%h\n[10]:%h\n[11]:%h\n[12]:%h\n[13]:%h\n[14]:%h\n[15]:%h\n\nMemory:\n[0]:%h\n[1]:%h\n[2]:%h\n[3]:%h\n[4]:%h\n[5]:%h\n[6]:%h\n[7]:%h\n[8]:%h\n[9]:%h\n[A]:%h\n[B]:%h\n[C]:%h\n[D]:%h\n[E]:%h\n[F]:%h",
			cpu.ProgramCounter.PC,
			cpu.RF.Registers[0], cpu.RF.Registers[1], cpu.RF.Registers[2], 
			cpu.RF.Registers[3], cpu.RF.Registers[4], cpu.RF.Registers[5],
			cpu.RF.Registers[6], cpu.RF.Registers[7], cpu.RF.Registers[8], 
			cpu.RF.Registers[9], cpu.RF.Registers[10], cpu.RF.Registers[11], 
			cpu.RF.Registers[12], cpu.RF.Registers[13],cpu.RF.Registers[14], 
			cpu.RF.Registers[15],
			
			cpu.DM.Data[0], cpu.DM.Data[1], cpu.DM.Data[2], cpu.DM.Data[3], 
			cpu.DM.Data[4], cpu.DM.Data[5], cpu.DM.Data[6], cpu.DM.Data[7], 
			cpu.DM.Data[8], cpu.DM.Data[9], cpu.DM.Data[10], cpu.DM.Data[11], 
			cpu.DM.Data[12], cpu.DM.Data[13], cpu.DM.Data[14], cpu.DM.Data[15]);	
			
end

initial

begin
	rst = 1'b0;
	#8 rst =1'b1;
end

initial
	#580 $finish;

endmodule
