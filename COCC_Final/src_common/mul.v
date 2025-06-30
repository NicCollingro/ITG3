// Kombinatorische unsigned integer Multiplikation
//
// {hi, lo} = in_a * in_b
//
// Erzeugung der Partialsumme aus den Bits von in_b

module mul(
  input  wire[7:0] in_a,
  input  wire[7:0] in_b,
  output wire[7:0] out_lo,
  output wire[7:0] out_hi,
  output wire      carry
);

  generate
  genvar j;
  for (j=0; j<8; j=j+1) begin : partial
    wire[7:0] val = {in_a[7] & in_b[j], 
                     in_a[6] & in_b[j], 
                     in_a[5] & in_b[j], 
                     in_a[4] & in_b[j], 
                     in_a[3] & in_b[j], 
                     in_a[2] & in_b[j], 
                     in_a[1] & in_b[j], 
                     in_a[0] & in_b[j]};
  end
  endgenerate
    
  assign {carry, out_hi, out_lo} =   (partial[0].val << 0)
                                   + (partial[1].val << 1)
                                   + (partial[2].val << 2)
                                   + (partial[3].val << 3)
                                   + (partial[4].val << 4)
                                   + (partial[5].val << 5)
                                   + (partial[6].val << 6)
                                   + (partial[7].val << 7);
endmodule
