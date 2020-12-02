module RegisterFile(input [3:0] ReadReg1,ReadReg2,WriteReg1,WriteReg2,
					input [15:0]  WriteData1, WriteData2,
					input clk, rst, RegWrite, WriteOP2,
					output [15:0] ReadData1, ReadData2, R15);
					   
reg [15:0] Registers [15:0];
integer i;

	//Unconditional Outputs:
	assign ReadData1 = Registers [ReadReg1];
	assign ReadData2 = Registers [ReadReg2];
	assign R15 = Registers [15];

always @(posedge clk, negedge rst)
begin
	if(!rst)
	begin
		//for (i = 0; i<16; i=i+1)
		//	Registers[i]<=0;
	//Test Values:
		Registers[0] <= 16'h0000;
		Registers[1] <= 16'h0001;
		Registers[2] <= 16'h0002;
		Registers[3] <= 16'h0003;
		Registers[4] <= 16'h0004;
		Registers[5] <= 16'h0005;
		Registers[6] <= 16'h0006;
		Registers[7] <= 16'h0007;
		
		Registers[15] <= 16'h0000;


	end
	else
	begin
		if(RegWrite)
		begin
			Registers [WriteReg1] <= WriteData1;
			if(WriteOP2)
				Registers [WriteReg2] <= WriteData2;
		end
	end	
end

endmodule