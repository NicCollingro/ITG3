`include "dff.v"

module top_level();
reg D,clk;
always #1 clk = ~clk;
wire Q;

D_FlipFlop flopper (.D(D), .clk(clk), .Q(Q));

initial begin
    D  = 0;
    clk = 0;
    $dumpfile("test");
    $dumpvars(0,D,clk,Q);


    # 2 D = 1;
    # 4 D = 0;
    # 2 D = 1;
    # 2 D = 0;
    # 4 D = 1;
    # 10 $finish;
end
endmodule
