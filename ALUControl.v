`timescale 1ns / 1ps
module ALUControl(
    input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] ALUCtrl
);
always @(*) begin
    // Default assignment to prevent latches
    ALUCtrl = 4'b0000;

    case (ALUOp)
        2'b00: ALUCtrl = 4'b0010; // ADD
        2'b01: ALUCtrl = 4'b0110; // Branch
        2'b10: begin
            case ({funct7, funct3})
                10'b0000000000: ALUCtrl = 4'b0010; // ADD
                10'b0100000000: ALUCtrl = 4'b0110; // SUB
                10'b0000000111: ALUCtrl = 4'b0000; // AND
                10'b0000000110: ALUCtrl = 4'b0001; // OR
                default: ALUCtrl = 4'b0010;
            endcase
        end
        default: ALUCtrl = 4'b0000; // added to fix synthesis warning
    endcase
end

endmodule
