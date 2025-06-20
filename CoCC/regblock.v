module regblock (input wire clk input wire we, 
input wire[2:0] oaddr, input wire[2:0] iaddr,
input wire[7:0] idata, input wire oe,
output wire[7:0] odata); 
reg[7:0] registers[0:7];


always @(posedge clk) begin


end
endmodule