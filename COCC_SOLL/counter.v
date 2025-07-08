module counter(
  input wire 		clk,		// clock
  input wire 		oe,		// enable output latch
  input wire[7:0] 	in,		// set counter=in with set==1
  input wire 		set,		// set counter=in
  input wire 		reset,		// async reset
  input wire 		down,		// decrement counter
  output wire[7:0]	out		// counter value
);

  reg[7:0] r_out = 8'b0;
  assign out = (oe) ? r_out : 8'bz;
  
  always @(posedge clk) begin
    if (reset)
      r_out <= 0;
    else 
      if (set)
        r_out <= in;
      else 
        if (down)
          r_out <= r_out - 1'b1;
        else
          r_out <= r_out + 1'b1;
  end

endmodule
