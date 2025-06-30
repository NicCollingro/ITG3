module ram(
  input wire		clk,		// Clock
  input wire[7:0]	addr,		// Memory-Addresse
  input wire 		we,       	// Write Enable (write if we is high else read)
  input wire 		oe,             // Enable Output
  inout wire[7:0] 	data_bus	// Bidirektionaler Datenbus
);

  // 256 Bytes of RAM, wow ;D
  reg[7:0] mem[0:255];

  // lesender Zugriff kontinuierlich
  // Bidirektionaler Datenbus kann nicht gleichzeitig 
  // zu schreibende und gelesene Daten enthalten => Tristate
  assign data_bus = (oe & ~we) ? mem[addr] : 8'bz;

  // schreibender Zugriff taktsynchron
  always @(posedge clk) 
    if (we) 
      mem[addr] <= data_bus;

  // copy ROM to RAM, synthesizable with quartus
  initial begin
    $readmemh("rom.hex", mem);
  end

endmodule
