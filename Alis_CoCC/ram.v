module ram ( input wire clk, input wire we, input wire oe,
input wire [7:0] addr, inout wire [7:0] bus 
);
reg[7:0] mem[0:255]; 
assign bus = (oe & ~we) ? mem[addr] : 8'bz;

always @(posedge clk) begin
    if (we) begin
        mem[addr] <= bus;
    end
end

initial begin
    $readmemh("alutest.hex", mem);
end
endmodule