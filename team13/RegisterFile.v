module RegisterFile(input [3:0] ReadReg1,ReadReg2,WriteReg1,WriteReg2,
					input [15:0]  WriteData1, WriteData2,
					input clk, rst, RegWrite, WriteOP2,
					output reg [15:0] ReadData1, ReadData2, R15);
					   
reg [15:0] Registers [15:0];
integer i;

//Unconditional Outputs:
//Fix issue with instructions that are 3 away
always@(*)
begin
	ReadData1 = Registers [ReadReg1];
	ReadData2 = Registers [ReadReg2];
	R15 = Registers [15];
	if(WriteReg1 == ReadReg1)
	begin
		ReadData1 = WriteData1;
	end
end


always @(posedge clk, negedge rst)
begin
	if(!rst)
	begin
		for (i = 0; i<16; i=i+1)
			Registers[i]<=0;
	//Test Values:
		Registers[0] <= 16'h0000;
		Registers[1] <= 16'h0e12;
		Registers[2] <= 16'h0045;
		Registers[3] <= 16'hF08F;
		Registers[4] <= 16'hF076;
		Registers[5] <= 16'h0084;
		Registers[6] <= 16'h6789;
		Registers[7] <= 16'h00EB;
		Registers[8] <= 16'hFF56;
		Registers[12] <= 16'hCC89;
		Registers[13] <= 16'h0002;



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