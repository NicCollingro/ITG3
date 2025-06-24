`include "symbols.vh"
module ram(inout wire[7:0] data_bus, input wire we, input wire oe, input wire[7:0] addr, input wire clk);
reg[7:0] mem[0:255];

assign data_bus = (oe & ~we) ? mem[addr] : 8'bz;

always @(posedge clk) begin
    mem[addr] <= data_bus;
end

initial begin
    $readmemh("/Initials/rom.hex", mem);
end
endmodule