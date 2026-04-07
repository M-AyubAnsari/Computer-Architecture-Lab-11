`timescale 1ns / 1ps
module InstructionMemory(
    input [31:0] addr,
    output [31:0] Instruction
);
(* rom_style = "distributed" *) reg [31:0] memory [0:255];

integer i;
initial begin
    for (i = 0; i < 256; i = i + 1)
        memory[i] = 32'b0;
    $readmemh("Program.mem", memory);
end

assign Instruction = memory[addr[9:2]];

endmodule
