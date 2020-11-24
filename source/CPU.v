`include "RegisterFile.v";
`include "InstructionMemory.v";
`include "MainALU.v";
`include "PC.v";
`include "ControlUnit.v";
`include "ALUControlUnit.v";
`include "IFID.v";
`include "IDEX.v";
`include "EXMEM.v";
`include "MEMWB.v";


module CPU (input clk, rst);
//Data Wires
wire [31:0] ResultEX, ResultMEM, ResultWB, NewPC;
wire [15:0] InstructionIF,InstructionID, InstructionEX, InstructionMEM, InstructionWB;
wire [15:0] PCOut,OP1ID, OP2ID, OP1EX, OP2EX, OP1MEM, R15, PCToAdd;
//Control Signals
wire Overflow, Branch, Jump, Halt, WriteOP2, RegWrite;
wire [3:0] ALUOPID, ALUOPEX;		
wire [2:0] ALUControl;

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
				

ControlUnit CU(.Opcode(InstructionID[15:12]), .FunctionCode(InstructionWB[3:0]), .Overflow(Overflow), 
				.RegWrite(RegWrite), .ALUOP(ALUOPID), 
			   .Branch(Branch), .Jump(Jump), .Halt(Halt), .WriteOP2(WriteOP2));
					
				
IDEX IDEX(.InstructionIn(InstructionID), .OP1In(OP1ID),.OP2In(OP2ID), .clk(clk), 
			.rst(rst), .ALUOPIn(ALUOPID), .ALUOPOut(ALUOPEX), .OP1Out(OP1EX),
			.OP2Out(OP2EX), .InstructionOut(InstructionEX));
//EX:
ALUControlUnit ACU(.ALUOP(ALUOPEX), .FunctionCode(InstructionEX[3:0]), 
				.ALUControl(ALUControl));

MainALU MALU(.A(OP2EX), .B(OP1EX), .rst(rst), .ALUControl(ALUControl), 
			.Overflow(Overflow),.Result(ResultEX));

EXMEM EXMEM(.InstructionIn(InstructionEX), .OP1In(OP1EX), .ALUResultIn(ResultEX),
			.clk(clk), .rst(rst), .ALUResultOut(ResultMEM), .InstructionOut(InstructionMEM),
			.OP1Out(OP1MEM));		
//MEM:


MEMWB MEMWB(.InstructionIn(InstructionMEM), .DataIn(ResultMEM), .clk(clk), .rst(rst),
			.DataOut(ResultWB), .InstructionOut(InstructionWB));
//WB:

endmodule
