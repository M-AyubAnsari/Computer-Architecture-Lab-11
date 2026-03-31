`timescale 1ns / 1ps
module ProgramCounterAdder(
    input [31:0] PC,
    output [31:0] PCIncrement
);

    assign PCIncrement = PC + 32'd4;

endmodule
