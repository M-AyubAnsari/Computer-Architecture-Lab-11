`timescale 1ns / 1ps
module TopLevelProcessorTestBench;

    reg clk;
    reg rst;
    wire [31:0] PC_out;
    wire [31:0] alu_result_out;
    TopLevelProcessor uut (
        .clk(clk),
        .reset(rst),
        .PC_out(PC_out),
        .alu_result_out(alu_result_out)
    );

    // Clock generation: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // Simulation sequence
    initial begin
        // Apply reset
        rst = 1;
        #20 rst = 0;  // release reset

        #1000;

        $stop;  // end simulation
    end

    // Monitor PC and ALU results
    initial begin
        $monitor("Time=%0t | PC=%h | ALU Result=%h", $time, PC_out, alu_result_out);
    end

endmodule
