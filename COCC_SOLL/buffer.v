module buffer(
  input  wire 		clk,		// clock
  input  wire[7:0]	in,		// input
  input  wire 		oe,		// output enable
  input  wire 		we,		// write enable
  output wire[7:0] 	out		// output
);

  reg[7:0] buffer;

  assign out = (oe) ? buffer : 8'bz;

  always @(posedge clk)
    if (we)
      buffer <= in;
endmodule
