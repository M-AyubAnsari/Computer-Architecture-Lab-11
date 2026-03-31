`timescale 1ns / 1ps
module ProgramCounter(
    input clk,
    input reset,
    input [31:0] NextPC,
    output reg [31:0] PC
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 32'b0;
        else
            PC <= NextPC;
    end

endmodule
