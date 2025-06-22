module tristate_buffer (input wire oe, inout wire [7:0] out, input wire [7:0] in);
assign out = (oe) ? in : 8'bz;
endmodule
