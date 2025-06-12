`include "dlat.v"

module MYdff(input D, input clk, output Q);
    wire S;
    wire nclk;
    assign nclk = ~clk;
    MYdlat master(.D(D), .clk(clk), .Q(S));
    MYdlat slave(.D(S), .clk(nclk), .Q(Q));
endmodule