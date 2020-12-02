`include "RegisterFile.v";
`include "InstructionMemory.v";
`include "DataMemory.v";
`include "MainALU.v";
`include "PC.v";
`include "ControlUnit.v";
`include "ALUControlUnit.v";
`include "IFID.v";
`include "IDEX.v";
`include "EXMEM.v";
`include "MEMWB.v";
`include "MUX7.v";



module CPU (input clk, rst);
//Data Wires
wire [31:0] ALUResultEX, ALUResultMEM, ALUResultWB, ResultWB, NewPC;
wire [15:0] InstructionIF,InstructionID, InstructionEX, InstructionMEM, InstructionWB;
wire [15:0] ReadDataMEM, ReadDataWB, PCOut,OP1ID, OP2ID, OP1EX, OP2EX, OP1MEM, R15, PCToAdd;
//Control Signals
wire Overflow, Branch, Jump, Halt, WriteOP2, RegWrite;
wire MemRead, ALUSRC1, ALUSRC2, MemWrite, StoreOffset;
wire [3:0] ALUOPID, ALUOPEX;		
wire [2:0] ALUControl;
wire [1:0] MemToReg, OffsetSelect, BranchSelect;

//Components:
//IF:
			
//For now we use halt
PC ProgramCounter(.NewPC(NewPC[15:0]), .clk(clk), .rst(rst), 
				.Halt(Halt), .StopPC(Halt), .PC(PCOut));

MainALU PCALU(.A(PCOut), .B(16'h0002), .ALUControl(3'b000), .Result(NewPC));
				
InstructionMemory IM(.ReadAddress(PCOut), .clk(clk),.rst(rst),
				.Instruction(InstructionIF));
				
IFID IFID(.PCIN(PCOut),.InstructionIn(InstructionIF), .clk(clk), .rst(rst), 
			.PCOUT(PCToAdd), .InstructionOut(InstructionID));

//ID:

//WE SHOULD BE USING InstructionID. need to fix. For now, us InstructionIF to test other data.
RegisterFile RF(.ReadReg1(InstructionID[11:8]), .ReadReg2(InstructionID[7:4]),
				.WriteReg1(InstructionWB[11:8]), .WriteReg2(InstructionWB[7:4]), 
				.WriteData1(ResultWB[15:0]), .WriteData2(ResultWB[31:16]),
				.clk(clk), .rst(rst), .RegWrite(RegWrite), .WriteOP2(WriteOP2),
				.ReadData1(OP2ID), .ReadData2(OP1ID), .R15(R15));
				

ControlUnit CU(.OpcodeID(InstructionID[15:12]),.OpcodeEX(InstructionEX[15:12]),
				.OpcodeMEM(InstructionMEM[15:12]), .OpcodeWB(InstructionWB[15:12]), 
				.FunctionCode(InstructionWB[3:0]),.Overflow(Overflow), .OffsetSelect(OffsetSelect),
				.MemToReg(MemToReg), .StoreOffset(StoreOffset), .MemRead(MemRead),
				.ALUSRC1(ALUSRC1), .ALUSRC2(ALUSRC2), .MemWrite(MemWrite),
				.BranchSelect(BranchSelect),.RegWrite(RegWrite), .ALUOP(ALUOPID), 
			    .Branch(Branch), .Jump(Jump), .Halt(Halt), .WriteOP2(WriteOP2));
					
				
IDEX IDEX(.InstructionIn(InstructionID), .OP1In(OP1ID),.OP2In(OP2ID), .clk(clk), 
			.rst(rst), .ALUOPIn(ALUOPID), .ALUOPOut(ALUOPEX), .OP1Out(OP1EX),
			.OP2Out(OP2EX), .InstructionOut(InstructionEX));
//EX:
ALUControlUnit ACU(.ALUOP(ALUOPEX), .FunctionCode(InstructionEX[3:0]), 
				.ALUControl(ALUControl));

MainALU MALU(.A(OP2EX), .B(OP1EX), .ALUControl(ALUControl), 
			.Overflow(Overflow),.Result(ALUResultEX));

EXMEM EXMEM(.InstructionIn(InstructionEX), .OP1In(OP1EX), .ALUResultIn(ALUResultEX),
			.clk(clk), .rst(rst), .ALUResultOut(ALUResultMEM), .InstructionOut(InstructionMEM),
			.OP1Out(OP1MEM));		
//MEM:

DataMemory DM(.Address(ALUResultMEM[15:0]), .WriteData(OP1MEM),.clk(clk), .rst(rst), .memWrite(MemWrite),.ReadData(ReadDataMEM));

MEMWB MEMWB(.InstructionIn(InstructionMEM), .ReadDataIn(ReadDataMEM),.ALUResultIn(ALUResultMEM), .clk(clk), .rst(rst),
			.ReadDataOut(ReadDataWB), .InstructionOut(InstructionWB), .ALUResultOut(ALUResultWB));
			
MUX7 M7 (.alu(ALUResultWB), .eight(ReadDataWB), .sixteen(ReadDataWB), .memToReg(MemToReg), .Result(ResultWB));
//WB:
endmodule
