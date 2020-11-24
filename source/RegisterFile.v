module RegisterFile(input [3:0] ReadReg1,ReadReg2,WriteReg1,WriteReg2,
					input [15:0]  WriteData1, WriteData2,
					input clk, rst, RegWrite, WriteOP2,
					output reg [15:0] ReadData1, ReadData2, R15);
					   
reg [15:0] Registers [15:0];
integer i;

always @(posedge clk, negedge rst)
begin
	if(!rst)
	begin
		//for (i = 0; i<16; i=i+1)
		//	Registers[i]<=0;
	//Test Values:
		//reg 0 = 1+1 = 16h'0002
		Registers[0] <= 16'h0001;
		Registers[1] <= 16'h0001;
		//ref 2= f-e = 1111- 1110 = 16'h0001
		Registers[2] <= 16'h000f;
		Registers[3] <= 16'h000e;
		//Reg 4 = 16'h0ff0
		Registers[4] <= 16'hf000;
		Registers[5] <= 16'h0ff0;
		//Reg 6 = 16'hf0f0 Reg 7 = 16'h0f0f
		Registers[6] <= 16'h0f0f;
		Registers[7] <= 16'hf0f0;

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

always @(negedge clk)
begin
	//Unconditional Outputs:
	ReadData1 <= Registers [ReadReg1];
	ReadData2 <= Registers [ReadReg2];
	R15 <= Registers [15];
end
endmodule