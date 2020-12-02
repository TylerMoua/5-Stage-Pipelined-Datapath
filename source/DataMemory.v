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
		Data[0]<=16'haaaa;
		Data[1]<=16'h1111;
		Data[2]<=16'h2222;
		Data[3]<=16'h3333;		
		Data[4]<=16'h4444;
		Data[5]<=16'h5555;
		Data[6]<=16'h6666;
		Data[7]<=16'h7777;
		Data[8]<=16'h8888;		
		Data[9]<=16'h9999;
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
