module ram ( input wire clk, input wire we, input wire oe,
input wire [7:0] addr    
);
reg[7:0] mem[0:255];
endmodule