`timescale 1ns / 1ps
module ALU(
    input [31:0] a,
    input [31:0] b,
    input [3:0] ALUCtrl,
    output reg [31:0] result,
    output zero
);
always @(*) begin
    case (ALUCtrl)
        4'b0010: result = a + b;
        4'b0110: result = a - b;
        4'b0000: result = a & b;
        4'b0001: result = a | b;
        default: result = 0;
    endcase
end
assign zero = (result == 0);

endmodule
