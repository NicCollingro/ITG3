module top_level (input wire CLOCK_50, output wire [7:0] led);

/*
reg [24:0] help;
reg clk;
always @(posedge CLOCK_50) begin
    help <= help + 1'd1;
    clk <= help[23];
end
*/

reg clk = 0;
always #1 clk = ~clk;
computer combo(.clk(clk));

initial begin
$dumpfile("test2.vcd");
$dumpvars(0, combo);

#10000 $finish;
end

endmodule