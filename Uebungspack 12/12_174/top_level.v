`include "dff.v"

module top_level();
    reg clk = 0;
    always #1 clk = ~clk;
    wire dff;
    wire dlatch;
    reg in;

    MYdlat MYLatch(.D(in), .clk(clk), .Q(dlatch));

    MYdff MYFlipFlop(.D(in), .clk(clk), .Q(dff));

    //Aufgabe 2

    wire wX, wY;

    MYdff UpperFF(.D(wY), .clk(clk), .Q(wX));
    MYdff LowerFF(.D(wX), .clk(clk), .Q(wY));

    initial begin
        $monitor("%t %b %b %b %b", $time, dlatch, dff, in, clk);
        #0 in = 0;
        #3 in = 1;
        #2 in = 0;
        #5 in = 1;
        #6 $finish;
    end

endmodule