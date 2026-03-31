`timescale 1ns / 1ps
module TopLevelProcessor(
    input clk,
    input reset,
    output [31:0] PC_out,
    output [31:0] alu_result_out
);

// Wires
wire [31:0] PC, NextPC, Instruction;
wire [31:0] PCIncrement, BranchAdders;
wire [31:0] readData1, readData2, writeData;
wire [31:0] Immediate;
wire [31:0] alu_in2, alu_result;
wire [31:0] mem_read_data;
wire [3:0] ALUCtrl;
wire zero;


// Control signals
wire RegWrite, MemRead, MemWrite, MemtoReg, ALUSrc, Branch;
wire [1:0] ALUOp;
wire PCSrc;

// Program Counter
ProgramCounter PPC (
    .clk(clk),
    .reset(reset),
    .NextPC(NextPC),
    .PC(PC)
);

// Instruction Memory
InstructionMemory IM (
    .addr(PC),
    .Instruction(Instruction)
);

// Control Unit
ControlUnit CU (
    .opcode(Instruction[6:0]),
    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemtoReg(MemtoReg),
    .ALUSrc(ALUSrc),
    .Branch(Branch),
    .ALUOp(ALUOp)
);

// Register File
RegisterFile RF (
    .clk(clk),
    .RegWrite(RegWrite),
    .rs1(Instruction[19:15]),
    .rs2(Instruction[24:20]),
    .rd(Instruction[11:7]),
    .writeData(writeData),
    .readData1(readData1),
    .readData2(readData2)
);

// Immediate Generator
ImmediateGenerator IMM (
    .Instruction(Instruction),
    .Immediate(Immediate)
);

// ALU Control
ALUControl ALUCTRL (
    .ALUOp(ALUOp),
    .funct3(Instruction[14:12]),
    .funct7(Instruction[31:25]),
    .ALUCtrl(ALUCtrl)
);

// ALUSrc MUX
MUX ALU_MUX (
    .Input1(readData2),
    .Input2(Immediate),
    .SelectionBit(ALUSrc),
    .Output1(alu_in2)
);

// ALU
ALU alu (
    .a(readData1),
    .b(alu_in2),
    .ALUCtrl(ALUCtrl),
    .result(alu_result),
    .zero(zero)
);

// Data Memory
DataMemory DM (
    .clk(clk),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .addr(alu_result),
    .writeData(readData2),
    .readData(mem_read_data)
);

// Register Writeback MUX
MUX WB_MUX (
    .Input1(alu_result),
    .Input2(mem_read_data),
    .SelectionBit(MemtoReg),
    .Output1(writeData)
);

// Program Counter Logic
ProgramCounterAdder PC_ADD (
    .PC(PC),
    .PCIncrement(PCIncrement)
);

BranchAdder BR_ADD (
    .PC(PC),
    .Immediate(Immediate),
    .BranchAdders(BranchAdders)
);

assign PCSrc = Branch & zero;

MUX PC_MUX (
    .Input1(PCIncrement),
    .Input2(BranchAdders),
    .SelectionBit(PCSrc),
    .Output1(NextPC)
);
assign PC_out = PC;
assign alu_result_out = alu_result;

endmodule
