`timescale 1ns / 1ps
module RegisterFile(
    input clk,
    input RegWrite,
    input [4:0] rs1, rs2, rd,
    input [31:0] writeData,
    output [31:0] readData1,
    output [31:0] readData2
);
(* ram_style = "distributed" *) reg [31:0] registers [31:0];

integer i;
initial begin
    for (i = 0; i < 32; i = i + 1)
        registers[i] = 32'b0;
end

assign readData1 = registers[rs1];
assign readData2 = registers[rs2];

always @(posedge clk) begin
    if (RegWrite && rd != 0)
        registers[rd] <= writeData;
end

endmodule
