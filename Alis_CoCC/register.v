module register(
  input  wire 		clk,		
  input  wire[7:0]	in,		
  input  wire 		en,		
  output reg[7:0] 	out = 8'b0	
);

  always @(posedge clk)
    if (en)
      out[7:0] <= in[7:0];

endmodule

/*
module register (input wire clk , input wire en, 
input wire [7:0] in, output wire [7:0] out);
wire h1, h2, h3, h4, h5, h6, h7;
assign h1 = (en) ? in[0] : out[0];
assign h2 = (en) ? in[1] : out[1];
assign h3 = (en) ? in[2] : out[2];
assign h4 = (en) ? in[3] : out[3];
assign h5 = (en) ? in[4] : out[4];
assign h6 = (en) ? in[5] : out[5];
assign h7 = (en) ? in[6] : out[6];
assign h8 = (en) ? in[7] : out[7];

D_FlipFlop d1(h1, clk, out[0]);
D_FlipFlop d2(h2, clk, out[1]);
D_FlipFlop d3(h3, clk, out[2]);
D_FlipFlop d4(h4, clk, out[3]);
D_FlipFlop d5(h5, clk, out[4]);
D_FlipFlop d6(h6, clk, out[5]);
D_FlipFlop d7(h7, clk, out[6]);
D_FlipFlop d8(h8, clk, out[7]);

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
*/