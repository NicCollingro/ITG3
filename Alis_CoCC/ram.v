module ram ( input wire clk, input wire we, input wire oe,
input wire [7:0] addr, inout wire [7:0] bus
);
reg[7:0] mem[0:255];
reg [7:0] r;
assign bus = (oe & we) ? r : 8'bz;

always @(posedge clk) begin
if (oe) begin
    if (we) begin
        r <= mem[addr];
    end else begin
        mem[addr] <= bus
    end
end
end

initial begin
    $readmemh("rom.hex", mem)
end
endmodule