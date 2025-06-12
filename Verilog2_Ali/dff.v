`include "dlat.v"

module D_FlipFlop(input wire D, input wire clk, output wire Q);
wire mitte;

D_Latch Latch (.D(D), .clk(~clk), .Q(mitte));
D_Latch catch (.D(mitte), .clk(clk), .Q(Q));

endmodule

