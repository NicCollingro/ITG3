module ALU(input wire [7:0] in_a, imput wire [7:0] in_b, 
input wire [2:0] mode, input wire eo,
output wire [7:0] out, output reg flag_zero = 0, 
output reg flag_carry = 0, input wire ee);
reg [7:0] r_out = 8'b0;
assign out = (eo) ?









endmodule
