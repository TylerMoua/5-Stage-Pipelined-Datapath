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
//initial
	//$monitor("\nPC: %h\nInstruction: %h,\nR1: %h R2: %h\nOP1: %h OP2: %h\nALUOUT: %h\n",
	//		 CPU.ProgramCounter.PC, CPU.IM.Instructions[0],CPU.RF.Registers[0], 
	//		 CPU.RF.Registers[1], CPU.RF.ReadData1, CPU.RF.ReadData2, CPU.MALU.Result);
initial
begin
	rst = 1'b0;
	#8 rst =1'b1;
//One Instruction:
	//5 cycles

$display("\nResults:\n--------------------------------------");
	@(posedge clk);
$display("\nPC: %h Instruction Fetch:", CPU.PCOut);
	$display("\nInstruction: %h", CPU.IM.Instructions[0]);
$display("\n--------------------------------------");

	@(posedge clk);
$display("\nPC: %h Instruction Decode:", CPU.PCOut);
	$display("\nRegister1 Location: %h Register2 Location: %h", CPU.RF.ReadReg1, CPU.RF.ReadReg2);
	$display("\nRegister1: %h Register2: %h", CPU.RF.Registers[0], CPU.RF.Registers[1]);
$display("\n--------------------------------------");

	@(posedge clk);
$display("\nPC: %h Execution:", CPU.PCOut);
	$display("\nALU Output: %h", CPU.MALU.Result);
$display("\n--------------------------------------");

		@(posedge clk);
$display("\nPC: %h WriteBack:", CPU.PCOut);
	$display("\nNew Register1: %h New Register2: %h", CPU.RF.Registers[0], CPU.RF.Registers[1]);
$display("\n--------------------------------------");

end

initial
	#300 $finish;

endmodule
