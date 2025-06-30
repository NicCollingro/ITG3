module register(
  input  wire 		clk,		// clock
  input  wire[7:0]	in,		// input
  input  wire 		en,		// enable
  output reg[7:0] 	out = 8'b0	// output
);

  always @(posedge clk)
    if (en)
      out[7:0] <= in[7:0];

endmodule
