`timescale 1ns / 1ps
module ProgramCounterTestBench;
reg clk, reset;
reg PCSrc;
wire [31:0] PC, NextPC, PCIncrement, BranchAdders;
wire [31:0] Immediate;

ProgramCounter PC_inst (
    .clk(clk),
    .reset(reset),
    .NextPC(NextPC),
    .PC(PC)
);

ProgramCounterAdder PC_ADD (
    .PC(PC),
    .PCIncrement(PCIncrement)
);

BranchAdder BR_ADD (
    .PC(PC),
    .Immediate(32'd8), // example branch offset
    .BranchAdders(BranchAdders)
);

MUX PC_MUX (
    .Input1(PCIncrement),
    .Input2(BranchAdders),
    .SelectionBit(PCSrc),
    .Output1(NextPC)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    PCSrc = 0;

    #10 reset = 0;

    // Sequential execution
    #20;

    // Branch taken
    PCSrc = 1;
    #10;

    // Back to sequential
    PCSrc = 0;
    #20;

    $finish;
end

endmodule
