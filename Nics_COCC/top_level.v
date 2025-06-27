`include "./COMPUTER.v"
module top_level();
    reg clk;
    always #1 clk = ~clk;

    computer COMPUTER(.clk(clk));
endmodule