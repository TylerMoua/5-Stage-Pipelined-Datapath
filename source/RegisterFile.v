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
		Registers[0] <= 16'h0001;
		Registers[1] <= 16'h0001;
		ReadData1 <= 0;
		ReadData2 <= 0;
	end
	else
	begin
		if(RegWrite)
		begin
			Registers [WriteReg1] <= WriteData1;
			if(WriteOP2)
				Registers [WriteReg2] <= WriteData2;
			//Unconditional Outputs:
		ReadData1 <= Registers [ReadReg1];
	ReadData2 <= Registers [ReadReg2];
		end
	end
	

	R15 <= Registers [15];
	
end
endmodule