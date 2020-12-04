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
`include "MUX4.v";
`include "MUX5.v";
`include "MUX7.v";
`include "BranchEquator.v"
`include "SignExtendID.v"
`include "SignExtendWB.v"
`include "SignExtendMEM.v"
`include "ZeroExtend.v"
`include "ShiftLeft.v"
`include "RegisterForwardingUnit.v"
`include "BCHazardControlUnit.v"



module CPU (input clk, rst);
//Data Wires
wire [31:0] JBPC, ALUResultEX, ALUResultMEM, ALUResultWB, ResultWB, NewPC;
wire [31:0] SEData, SEByte, BTBForward, OneAwayForward;
wire [15:0] PCMUXResult, InstructionIF,InstructionID, InstructionEX;
wire [15:0] InstructionMEM, InstructionWB, SEImmdID, SEImmdEX,Op1ToStore;
wire [15:0] PCALU2OP, PCALU2OPShifted,SEOp1,Op1ToStore1;
wire [15:0] ReadDataMEM, ReadDataWB, PCOut,OP1ID, OP2ID, OP1EX, OP2EX;
wire [15:0] OP1MEM, R15ID, R15EX, PCToAdd, Four, Eight, Twelve;
wire [15:0]  M3Result, M5Result, ReadDataExtended;

//Control Signals
wire  StopPC, Overflow, Branch, Jump, Halt, WriteOP2, RegWrite, Hazard, ALUSRC2;
wire MemRead, MemWrite, StoreOffset, BranchingSoFlush, BranchingSoFlushEX;
wire [3:0] ALUOPID, ALUOPEX;		
wire [2:0] ALUControl,  ForwardToMux4, ForwardToMux3, ForwardToMux5;
wire [1:0] MemToReg, ALUSRC1, OffsetSelect, BranchSelect;

//Hazard Signals

//DataPath:
//IF:

MUX1 M1(.A(NewPC[15:0]),.B(JBPC[15:0]),.BranchingSoFlush(BranchingSoFlush),.Result(PCMUXResult));

PC ProgramCounter(.NewPC(PCMUXResult), .clk(clk), .rst(rst), 
				.Halt(Halt), .StopPC(StopPC), .PC(PCOut));

MainALU PCALU1(.Op1(PCOut), .Op2(16'h0002), .ALUControl(3'b000), .Result(NewPC));
				
InstructionMemory IM(.ReadAddress(PCOut), .clk(clk),.rst(rst),
				.Instruction(InstructionIF));
				
IFID IFID(.PCIN(NewPC[15:0]),.InstructionIn(InstructionIF), .clk(clk), .rst(rst), .Halt(Halt), 
			.PCOUT(PCToAdd), .InstructionOut(InstructionID), .FlushIn(BranchingSoFlush),
			 .FlushOut(BranchingSoFlushEX), .StopPC(StopPC),
			 .OldInstruction(InstructionID));

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
				
	 
SignExtendID SEID1(.a(InstructionID[3:0]), .b(InstructionID[11:0]), 
				   .ResultA(Four), .ResultB(Twelve));		  
				   
ZeroExtend ZEID(.a(InstructionID[7:0]), .Result(Eight));				   
				   
MUX2 	M2(.four(Four),.eight(Eight),.twelve(Twelve),
				.offsetSelect(OffsetSelect),.Result(SEImmdID));
								   
MUX4 	M4(.Op(SEImmdID), 
			.Btb(BTBForward), .oneAway(OneAwayForward),.ForwardToMux4(ForwardToMux4),
			.hazard(Hazard),
		  .Result(PCALU2OP));
		  
ShiftLeft SL(.a(PCALU2OP), .Result(PCALU2OPShifted));

MainALU PCALU2(.Op1(PCToAdd), .Op2(PCALU2OPShifted), .ALUControl(3'b000), .Result(JBPC));

BranchEquator BE(.Op1(OP1ID),.Hazard(Hazard), .R15(R15ID), .BranchSelect(BranchSelect),
				.BTB(BTBForward), .OneAway(OneAwayForward), .HazardSelect(ForwardToMux4),
				 .Branch(Branch), .Jump(Jump),.BranchingSoFlush(BranchingSoFlush));	
							
IDEX 	IDEX(.InstructionIn(InstructionID), .OP1In(OP1ID),.OP2In(OP2ID), .clk(clk),
			 .StopPC(StopPC),
			 .rst(rst), .ALUOPIn(ALUOPID), .ALUOPOut(ALUOPEX), .OP1Out(OP1EX),
			 .SEImmdIn(SEImmdID),.OP2Out(OP2EX), .InstructionOut(InstructionEX),
			 .SEImmdOut(SEImmdEX), .R15In(R15ID), .R15Out(R15EX),.flush(BranchingSoFlushEX));
//EX:
MUX3	M3(.SEIMMD(SEImmdEX), .Op2(OP2EX), .Btb(BTBForward), .oneAway(OneAwayForward), .R15(R15EX),
		   .hazard(Hazard),.ALUSRC(ALUSRC1),.ForwardToMux3(ForwardToMux3),
		   .Result(M3Result));
		   
MUX5	M5(.SEIMMD(SEImmdEX), .Op1(OP1EX), .Btb(BTBForward), .oneAway(OneAwayForward),
		   .hazard(Hazard),.ALUSRC(ALUSRC2),.ForwardToMux5(ForwardToMux5),
		   .Result(M5Result));
		   
ALUControlUnit ACU(.ALUOP(ALUOPID), .FunctionCode(InstructionEX[3:0]), 
				.ALUControl(ALUControl));

MainALU MALU(.Op1(M5Result), .Op2(M3Result), .ALUControl(ALUControl), 
			.Overflow(Overflow), .Result(ALUResultEX));

EXMEM EXMEM(.InstructionIn(InstructionEX), .OP1In(OP1EX), .OP2In(OP2EX), 
				.ALUResultIn(ALUResultEX),
			.clk(clk), .rst(rst), .ALUResultOut(ALUResultMEM), .InstructionOut(InstructionMEM),
			.OP1Out(OP1MEM),.BTBForward(BTBForward));
			
RegisterForwardingUnit RFU(.IDOP1(InstructionID[11:8]), .IDOP2(InstructionID[7:4]),
						   .OP1(InstructionEX[11:8]), .OP2(InstructionEX[7:4]),
						   .BTBOP1(InstructionMEM[11:8]),.BTBOP2(InstructionMEM[7:4]), 
						   .OAOP1(InstructionWB[11:8]), .OAOP2(InstructionWB[7:4]),
						   .ForwardToMux3(ForwardToMux3), .ForwardToMux4(ForwardToMux4), 
						   .ForwardToMux5(ForwardToMux5), .HazardDetected(Hazard),
						   .OpcodeMEM(InstructionMEM[15:12]), .FunctionCodeMEM(InstructionMEM[3:0]),
						   .OpcodeWB(InstructionWB[15:12]), .FunctionCodeWB(InstructionWB[3:0]));

BCHazardControlUnit	BCHCU(.IDOP(InstructionID[15:12]),.EXOP(InstructionEX[15:12]), 
						  .MEMOP(InstructionMEM[15:12]),.WBOP(InstructionWB[15:12]),
						  .Hazard(Hazard),.StopPC(StopPC));	
						  
//MEM:
SignExtendMEM SEMEM(.a(OP1MEM[7:0]), .Result(SEOp1));

MUX1 M1MEM(.A(OP1MEM), .B(SEOp1), .BranchingSoFlush(StoreOffset), .Result(Op1ToStore));

DataMemory DM(.Address(ALUResultMEM[15:0]), .WriteData(Op1ToStore),.clk(clk), .rst(rst), .memWrite(MemWrite),.ReadData(ReadDataMEM));

MEMWB MEMWB(.InstructionIn(InstructionMEM), .ReadDataIn(ReadDataMEM),.ALUResultIn(ALUResultMEM), 
			.clk(clk), .rst(rst), .OpsIn(BTBForward), .OneAwayForward(OneAwayForward),
			.ReadDataOut(ReadDataWB), .InstructionOut(InstructionWB), .ALUResultOut(ALUResultWB));
			
//WB:
ZeroExtend ZEWB(.a(ReadDataWB[7:0]), .Result(ReadDataExtended));				   

SignExtendWB SEWB(.a(ReadDataExtended), .b(ReadDataWB), .ResultA(SEByte), .ResultB(SEData));

MUX7 M7(.alu(ALUResultWB), .eight(SEByte), .sixteen(SEData), .memToReg(MemToReg), .Result(ResultWB));

endmodule
