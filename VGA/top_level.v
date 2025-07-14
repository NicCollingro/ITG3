`include "vga.v"

module top_level (
input wire CLOCK_50, output wire GPIO_000, 
output wire GPIO_001, output wire GPIO_003,
output wire GPIO_005 ,output wire GPIO_007);

vga vga(.CLOCK_50(CLOCK_50), .o_hsync(GPIO_000), .o_vsync(GPIO_001), .o_red(GPIO_007), .o_grn(GPIO_005), .o_blu(GPIO_003));

endmodule