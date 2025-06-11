module D_Latch(input wire D, input wire clk, output Q);
wire a;
wire b;

assign a = !((!D) && clk);
assign b = !(D && clk);

wire nq;

assign Q = !(a && nq);
assign nq = !(b && Q); 

endmodule