module regblock(
  input wire 		clk,
  input wire 		we,		
  input wire[2:0] 	iaddr,		
  input wire[7:0] 	idata,		
  input wire 		oe,		
  input wire[2:0] 	oaddr,		
  output wire[7:0] 	odata,		
  output wire[7:0] 	rega,		
  output wire[7:0] 	regb		
);

  reg[7:0] registers[0:7];
  assign rega = registers[0];
  assign regb = registers[1];

  assign odata = (oe) ? registers[oaddr] : 8'bz;

  always @(posedge clk)
    if (we)
      registers[iaddr] <= idata;

endmodule