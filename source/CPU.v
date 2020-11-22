`include "RegisterFile.v";
`include "InstructionMemory.v";
`include "MainALU.v";
`include "PC.v";
`include "ControlUnit.v";
`include "ALUControlUnit.v";
`include "IFID.v";
`include "IDEX.v";


module CPU (input clk, rst);
//Data Wires
wire[31:0] Result,NewPC;
wire [15:0] PCOut,InstructionIF,InstructionID, InstructionEX;
wire [15:0] OP1ID, OP2ID, OP1EX, OP2EX, R15, PCToAdd;
//Control Signals
wire Overflow, Branch, Jump, Halt, WriteOP2, RegWrite;
wire [3:0] ALUOPID, ALUOPEX;		
wire [2:0] ALUControl;

//Components:
//For now we use halt
//IF:
PC ProgramCounter(.NewPC(NewPC[15:0]), .clk(clk), .rst(rst), 
				.Halt(Halt), .StopPC(Halt), .PC(PCOut));

MainALU PCALU(.A(PCOut), .B(16'h0001), .ALUControl(3'b000), .Result(NewPC));
				
InstructionMemory IM(.ReadAddress(PCOut), .clk(clk),.rst(rst),
				.Instruction(InstructionIF));
				
IFID IFID(.PCIN(PCOut),.InstructionIn(InstructionIF), .clk(clk), .rst(rst), 
			.PCOUT(PCToAdd), .InstructionOut(InstructionID));

//ID:
RegisterFile RF(.ReadReg1(InstructionID[11:8]), .ReadReg2(InstructionID[7:4]),
				.WriteReg1(InstructionID[11:8]), .WriteReg2(InstructionID[7:4]), 
				.WriteData1(Result[15:0]), .WriteData2(Result[31:16]),
				.clk(clk), .rst(rst), .RegWrite(RegWrite), .WriteOP2(WriteOP2),
				.ReadData1(OP2ID), .ReadData2(OP1ID), .R15(R15));
				

ControlUnit CU(.Opcode(InstructionID[15:12]), .Overflow(Overflow), 
				.RegWrite(RegWrite), .ALUOP(ALUOPID), 
			   .Branch(Branch), .Jump(Jump), .Halt(Halt), .WriteOP2(WriteOP2));
					
				
IDEX IDEX(.InstructionIn(InstructionID), .OP1In(OP1ID),.OP2In(OP2ID), .clk(clk), 
			.rst(rst), .ALUOPIn(ALUOPID), .ALUOPOut(ALUOPEX), .OP1Out(OP1EX),
			.OP2Out(OP2EX), .InstructionOut(InstructionEX));
//EX:
ALUControlUnit ACU(.ALUOP(ALUOPEX), .FunctionCode(InstructionEX[3:0]), 
				.ALUControl(ALUControl));


MainALU MALU(.A(OP2EX), .B(OP1EX), .rst(rst), .ALUControl(ALUControl), 
			.Overflow(Overflow),.Result(Result));


endmodule
