`include "RegisterFile.v";
`include "InstructionMemory.v";
`include "MainALU.v";
`include "PC.v";
`include "ControlUnit.v";
`include "ALUControlUnit.v";

module CPU (input clk, rst);
//Data Wires
wire[31:0] Result,NewPC;
wire [15:0] PCOut, Instruction, OP1, OP2, R15;
//Control Signals
wire Overflow, Branch, Jump, Halt, WriteOP2, RegWrite;
wire [3:0] ALUOP;		
wire [2:0] ALUControl;
//For now we use halt
PC ProgramCounter(.NewPC(NewPC[15:0]), .clk(clk), .rst(rst), 
				.Halt(Halt), .StopPC(Halt), .PC(PCOut));

MainALU PCALU(.A(PCOut), .B(16'h0001), .ALUControl(3'b000), .Result(NewPC));

InstructionMemory IM(.ReadAddress(PCOut), .clk(clk),.rst(rst),
				.Instruction(Instruction));

ControlUnit CU(.Opcode(Instruction[15:12]), .Overflow(Overflow), 
				.RegWrite(RegWrite), .ALUOP(ALUOP), 
			   .Branch(Branch), .Jump(Jump), .Halt(Halt), .WriteOP2(WriteOP2));
			   
ALUControlUnit ACU(.ALUOP(ALUOP), .FunctionCode(Instruction[3:0]), 
				.ALUControl(ALUControl));

RegisterFile RF(.ReadReg1(Instruction[11:8]), .ReadReg2(Instruction[7:4]),
				.WriteReg1(Instruction[11:8]), .WriteReg2(Instruction[7:4]), 
				.WriteData1(Result[15:0]), .WriteData2(Result[31:16]),
				.clk(clk), .rst(rst), .RegWrite(RegWrite), .WriteOP2(WriteOP2),
				.ReadData1(OP2), .ReadData2(OP1), .R15(R15));	

MainALU MALU(.A(OP2), .B(OP1), .rst(rst), .ALUControl(ALUControl), .Overflow(Overflow), 
			.Result(Result));


endmodule
