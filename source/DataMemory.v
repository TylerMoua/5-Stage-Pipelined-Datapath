module DataMemory #(parameter N = 16)
						  (input [15:0]Address, WriteData,
						   input clk, rst, memWrite,
						   output [15:0] ReadData);

reg [15:0] Data [N-1:0];

assign ReadData = Data [Address];

always @(posedge clk, negedge rst)
begin
	
	if(!rst)
	begin
		//Test Value
		//for (i = 0; i<16; i=i+1)
		//	Instructions[i]<=0;
		Data[0]<=16'h0000;
		Data[1]<=16'h0001;
		Data[2]<=16'h0010;
		Data[3]<=16'h0100;		
		Data[3]<=16'h1000;
	end
	else
	begin
		if(memWrite)
		begin
			Data [Address] <= WriteData;
		end
	end	
end
endmodule
