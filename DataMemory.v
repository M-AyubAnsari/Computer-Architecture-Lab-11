`timescale 1ns / 1ps
module DataMemory(
    input clk,
    input MemRead,
    input MemWrite,
    input [31:0] addr,
    input [31:0] writeData,
    output [31:0] readData
);
(* ram_style = "distributed" *) reg [31:0] memory [0:255];

integer i;
initial begin
    for (i = 0; i < 256; i = i + 1)
        memory[i] = 32'b0;
end

always @(posedge clk) begin
    if (MemWrite)
        memory[addr[9:2]] <= writeData;
end

assign readData = memory[addr[9:2]];

endmodule
