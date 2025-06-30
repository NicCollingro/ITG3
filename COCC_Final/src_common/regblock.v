module regblock(
  input wire 		clk,
  input wire 		we,		// write enable
  input wire[2:0] 	iaddr,		// reg-addr to write to
  input wire[7:0] 	idata,		// input data (??? über data_bus!)
  input wire 		oe,		// enable output latch
  input wire[2:0] 	oaddr,		// reg-addr to read from
  output wire[7:0] 	odata,		// tristate Output auf Daten-Bus
  output wire[7:0] 	rega,		// direct access to accumulator
  output wire[7:0] 	regb		// and reg B for CPU/ALU
);

  reg[7:0] registers[0:7];
  assign rega = registers[0];
  assign regb = registers[1];

  assign odata = (oe) ? registers[oaddr] : 8'bz;

  always @(posedge clk)
    if (we)
      registers[iaddr] <= idata;

endmodule
