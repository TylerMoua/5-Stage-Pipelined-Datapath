module InstructionMemory #(parameter N = 16)
						  (input [15:0]ReadAddress,
						   input clk, rst,
						   output reg [15:0] Instruction);
						   
reg [15:0] Instructions [N-1:0];
integer i;
always @(posedge clk, negedge rst)
begin
	Instructions[0]<= {16'b0001000000010000};

	if(rst==0)
	begin
		for (i = 0; i<16; i=i+1)
			Instructions[i]<=0;
	end
	else
	
		Instruction <= Instructions [ReadAddress];
end
endmodule
