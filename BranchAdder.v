`timescale 1ns / 1ps
module BranchAdder(
    input [31:0] PC,
    input [31:0] Immediate,
    output [31:0] BranchAdders
);
    assign BranchAdders = PC + Immediate;

endmodule
