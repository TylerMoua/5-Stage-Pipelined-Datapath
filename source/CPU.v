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
`include "MUX1.v";
`include "MUX2.v";
`include "MUX3.v";
`include "MUX5.v";
`include "MUX7.v";
`include "BranchEquator.v"
`include "SignExtendID.v"
`include "SignExtendWB.v"
`include "ZeroExtend.v"



module CPU (input clk, rst);
//Data Wires
wire [31:0] ALUResultEX, ALUResultMEM, ALUResultWB, ResultWB, NewPC;
wire [31:0] SEData, SEByte;
wire [15:0] PCMUXResult, InstructionIF,InstructionID, InstructionEX;
wire [15:0] InstructionMEM, InstructionWB, SEImmdID, SEImmdEX;
wire [15:0] ReadDataMEM, ReadDataWB, PCOut,OP1ID, OP2ID, OP1EX, OP2EX;
wire [15:0] OP1MEM, R15ID, R15EX, JBPC,PCToAdd, Four, Eight, Twelve;
wire[15:0]  M3Result, M5Result, ReadDataExtended;

//Control Signals
wire Overflow, Branch, Jump, Halt, WriteOP2, RegWrite;
wire MemRead, ALUSRC1, ALUSRC2, MemWrite, StoreOffset, BranchingSoFlush;
wire [3:0] ALUOPID, ALUOPEX;		
wire [2:0] ALUControl;
wire [1:0] MemToReg, OffsetSelect, BranchSelect;

//Hazard Signals

//DataPath:
//IF:

MUX1 M1(.A(NewPC[15:0]),.B(JBPC),.BranchingSoFlush(BranchingSoFlush),.Result(PCMUXResult));

PC ProgramCounter(.NewPC(PCMUXResult), .clk(clk), .rst(rst), 
				.Halt(Halt), .StopPC(Halt), .PC(PCOut));

MainALU PCALU(.Op1(PCOut), .Op2(16'h0002), .ALUControl(3'b000), .Result(NewPC));
				
InstructionMemory IM(.ReadAddress(PCOut), .clk(clk),.rst(rst),
				.Instruction(InstructionIF));
				
IFID IFID(.PCIN(NewPC[15:0]),.InstructionIn(InstructionIF), .clk(clk), .rst(rst), 
			.PCOUT(PCToAdd), .InstructionOut(InstructionID));

//ID:
RegisterFile RF(.ReadReg1(InstructionID[11:8]), .ReadReg2(InstructionID[7:4]),
				.WriteReg1(InstructionWB[11:8]), .WriteReg2(InstructionWB[7:4]), 
				.WriteData1(ResultWB[15:0]), .WriteData2(ResultWB[31:16]),
				.clk(clk), .rst(rst), .RegWrite(RegWrite), .WriteOP2(WriteOP2),
				.ReadData1(OP1ID), .ReadData2(OP2ID), .R15(R15ID));

ControlUnit CU(.OpcodeID(InstructionID[15:12]),.OpcodeEX(InstructionEX[15:12]),
				.OpcodeMEM(InstructionMEM[15:12]), .OpcodeWB(InstructionWB[15:12]), 
				.FunctionCode(InstructionWB[3:0]),.Overflow(Overflow), .OffsetSelect(OffsetSelect),
				.MemToReg(MemToReg), .StoreOffset(StoreOffset), .MemRead(MemRead),
				.ALUSRC1(ALUSRC1), .ALUSRC2(ALUSRC2), .MemWrite(MemWrite),
				.BranchSelect(BranchSelect),.RegWrite(RegWrite), .ALUOP(ALUOPID), 
			    .Branch(Branch), .Jump(Jump), .Halt(Halt), .WriteOP2(WriteOP2));
				
BranchEquator BE(.A(OP2ID), .B(OP1ID), .BranchSelect(BranchSelect),
				 .Branch(Branch), .Jump(Jump),.BranchingSoFlush(BranchingSoFlush));	
				 
SignExtendID SEID1(.a(InstructionID[3:0]), .b(InstructionID[11:0]), 
				   .ResultA(Four), .ResultB(Twelve));		  
				   
ZeroExtend ZEID(.a(InstructionID[7:0]), .Result(Eight));				   
				   
MUX2 	M2(.four(Four),.eight(Eight),.twelve(Twelve),
				.offsetSelect(OffsetSelect),.Result(SEImmdID));
				
IDEX 	IDEX(.InstructionIn(InstructionID), .OP1In(OP1ID),.OP2In(OP2ID), .clk(clk), 
			 .rst(rst), .ALUOPIn(ALUOPID), .ALUOPOut(ALUOPEX), .OP1Out(OP1EX),
			 .SEImmdIn(SEImmdID),.OP2Out(OP2EX), .InstructionOut(InstructionEX),
			 .SEImmdOut(SEImmdEX), .R15In(R15ID), .R15Out(R15EX));
//EX:
MUX3	M3(.SEIMMD(SEImmdEX), .Op2(OP2EX), .Btb(), .oneAway(), .R15(R15EX),
			//For now, 0
		   .hazard(0),.ALUSRC(ALUSRC1),.ForwardToMux3(),
		   .Result(M3Result));
		   
MUX5	M5(.SEIMMD(SEImmdEX), .Op1(OP1EX), .Btb(), .oneAway(),
			//For now, 0
		   .hazard(0),.ALUSRC(ALUSRC2),.ForwardToMux5(),
		   .Result(M5Result));
		   
ALUControlUnit ACU(.ALUOP(ALUOPEX), .FunctionCode(InstructionEX[3:0]), 
				.ALUControl(ALUControl));

MainALU MALU(.Op1(M5Result), .Op2(M3Result), .ALUControl(ALUControl), 
			.Overflow(Overflow), .Result(ALUResultEX));

EXMEM EXMEM(.InstructionIn(InstructionEX), .OP1In(OP1EX), .ALUResultIn(ALUResultEX),
			.clk(clk), .rst(rst), .ALUResultOut(ALUResultMEM), .InstructionOut(InstructionMEM),
			.OP1Out(OP1MEM));		
//MEM:
DataMemory DM(.Address(ALUResultMEM[15:0]), .WriteData(OP1MEM),.clk(clk), .rst(rst), .memWrite(MemWrite),.ReadData(ReadDataMEM));

MEMWB MEMWB(.InstructionIn(InstructionMEM), .ReadDataIn(ReadDataMEM),.ALUResultIn(ALUResultMEM), .clk(clk), .rst(rst),
			.ReadDataOut(ReadDataWB), .InstructionOut(InstructionWB), .ALUResultOut(ALUResultWB));
			
//WB:
ZeroExtend ZEWB(.a(ReadDataWB[7:0]), .Result(ReadDataExtended));				   

SignExtendWB SEWB(.a(ReadDataExtended), .b(ReadDataWB), .ResultA(SEByte), .ResultB(SEData));

MUX7 M7(.alu(ALUResultWB), .eight(SEByte), .sixteen(SEData), .memToReg(MemToReg), .Result(ResultWB));

endmodule
