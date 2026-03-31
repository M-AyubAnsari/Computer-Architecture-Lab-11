`timescale 1ns / 1ps
module ImmediateGenerator(
    input [31:0] Instruction,
    output reg [31:0] Immediate
);
    always @(*) begin
        case (Instruction[6:0]) // opcode
            // I-type 
            7'b0000011,
            7'b0010011: 
                Immediate  = {{20{Instruction[31]}}, Instruction[31:20]};
            // S-type
            7'b0100011:
                Immediate = {{20{Instruction[31]}}, Instruction[31:25], Instruction[11:7]};

            // B-type
            7'b1100011:
                Immediate = {{19{Instruction[31]}}, Instruction[31], Instruction[7],Instruction[30:25], Instruction[11:8], 1'b0};
                
            default:
                Immediate = 32'b0;
        endcase
    end

endmodule
