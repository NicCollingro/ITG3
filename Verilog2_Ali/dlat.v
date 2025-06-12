module D_Latch(input wire D, input wire clk, output wire Q);
wire a;
wire b;
wire nq;

assign a = ~((~D) && clk);
assign b = ~(D && clk);

assign Q = ~(a && nq);
assign nq = ~(b && Q); 

endmodule

