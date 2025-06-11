module D_FlipFlop(input wire D, input wire clk, output Q);

assign clk = !clk;
wire mitte;
D_Latch Latch1(.D(D), .clk(clk), .Q(mitte));
assign clk = !clk;
D_Latch Latch2(.D(mitte), .clk(clk), .Q(Q));

endmodule

module D_Latch(input wire D, input wire clk, output Q);
wire a;
wire b;

assign a = !((!D) && clk);
assign b = !(D && clk);

wire nq;

assign Q = !(a && nq);
assign nq = !(b && Q); 

endmodule