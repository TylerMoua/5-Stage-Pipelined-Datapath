module RegisterFile(input [3:0] ReadReg1,ReadReg2,WriteReg1,WriteReg2,
					input [15:0]  WriteData1, WriteData2,
					input clk, rst, RegWrite, WriteOP2,
					output reg [15:0] ReadData1, ReadData2, R15);
					   
reg [15:0] Registers [15:0];
integer i;

always @(posedge clk, negedge rst)
begin
	if(rst==0)
	begin
		for (i = 0; i<16; i=i+1)
			Registers[i]=0;
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
	
	//Unconditional Outputs:
	ReadData1 <= Registers [ReadReg1];
	ReadData2 <= Registers [ReadReg2];
	R15 <= Registers [15];
	
end
endmodule