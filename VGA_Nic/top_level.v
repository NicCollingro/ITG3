`include "VGA.v"
module top_level(input wire CLOCK_50, output wire GPIO_000, output  wire GPIO_001, output wire GPIO_007, output wire GPIO_005, output wire GPIO_003);
    wire R,G,B,HSYNC,VSYNC;

    assign R = GPIO_007;
    assign G = GPIO_005;
    assign B = GPIO_003;

    assign HSYNC = GPIO_000;
    assign VSYNC = GPIO_001;

<<<<<<< HEAD
    vga test(.CLOCK_50(CLOCK_50), .i_sel(2'b0), .o_hsync(GPIO_000), .o_vsync(GPIO_001), .o_red(GPIO_007), .o_grn(GPIO_005), .o_blu(GPIO_003));
=======
    vga test(.CLOCK_50(CLOCK_50), .i_sel(2'b0), .o_hsync(HSYNC), .o_vsync(VSYNC), .o_red(R), .o_grn(G), .o_blu(B));
>>>>>>> Aljoscha
endmodule