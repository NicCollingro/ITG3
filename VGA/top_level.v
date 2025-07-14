`include "vga"

module top_level (
input wire CLOCK_50, output wire GPIO_000, 
output wire GPIO_001, output wire GPIO_003,
output wire GPIO_005 ,output wire GPIO_007);

vga vögeah(.CLOCK_50(CLOCK_50), .o_hsync(GPIO_), .o_vsync(GPIO_), 
.o_red(GPIO_), .o_grn(GPIO_), .o_blu(GPIO_));

endmodule