module DataMemory #(parameter N = 100)
						  (input [15:0]Address, WriteData,
						   input clk, rst, memWrite,
						   output [15:0] ReadData);

reg [7:0] Data [N-1:0];

assign ReadData = {Data [Address],Data [Address+1]};

always @(posedge clk, negedge rst)
begin
	
	if(!rst)
	begin
		//Test Value
		//for (i = 0; i<16; i=i+1)
		//	Instructions[i]<=0;
		Data[0]<=8'h3c;
		Data[1]<=8'hAD;
		
		Data[2]<=8'h00;
		Data[3]<=8'h00;	
		
		Data[4]<=8'h14;
		Data[5]<=8'h63;

		Data[6]<=8'hDA;
		Data[7]<=8'hED;
		
		Data[8]<=8'hFE;		
		Data[9]<=8'hEB;
		//Data[A]
		Data[10]<=8'hFF;
		Data[11]<=8'hFF;
		//Data[E]
		Data[14]<=8'hCC;		
		Data[15]<=8'hCC;
		
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
