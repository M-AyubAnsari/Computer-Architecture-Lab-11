`timescale 1ns / 1ps
module MUX(
    input [31:0] Input1,
    input [31:0] Input2,
    input SelectionBit,
    output [31:0] Output1
);
    assign Output1 = (SelectionBit) ? Input2 : Input1;

endmodule
