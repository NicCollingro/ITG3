module register (input wire clk , input wire en, 
input wire [7:0] in, output wire [7:0] out);
wire h1, h2, h3, h4, h5, h6, h7;
assign h1 = (en) ? in[0] : out[0];
assign h1 = (en) ? in[1] : out[1];
assign h1 = (en) ? in[2] : out[2];
assign h1 = (en) ? in[3] : out[3];
assign h1 = (en) ? in[4] : out[4];
assign h1 = (en) ? in[5] : out[5];
assign h1 = (en) ? in[6] : out[6];
assign h1 = (en) ? in[7] : out[7];

D_FlipFlop d1(h1, clk, out[0]);
D_FlipFlop d1(h1, clk, out[1]);
D_FlipFlop d1(h1, clk, out[2]);
D_FlipFlop d1(h1, clk, out[3]);
D_FlipFlop d1(h1, clk, out[4]);
D_FlipFlop d1(h1, clk, out[5]);
D_FlipFlop d1(h1, clk, out[6]);
D_FlipFlop d1(h1, clk, out[7]);

endmodule 


module D_FlipFlop(input wire D, input wire clk, output wire Q);
wire mitte;

D_Latch Latch (.D(D), .clk(~clk), .Q(mitte));
D_Latch catch (.D(mitte), .clk(clk), .Q(Q));

endmodule

module D_Latch(input wire D, input wire clk, output wire Q);
wire a;
wire b;
wire nq;

assign a = ~((~D) && clk);
assign b = ~(D && clk);

assign Q = ~(a && nq);
assign nq = ~(b && Q); 

endmodule