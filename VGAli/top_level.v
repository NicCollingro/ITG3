`include "vga.v"

module mop_level ();
reg CLOCK_50 = 0;
always #1 CLOCK_50 <= ~CLOCK_50;
wire h,v,r,g,b;
top_level top(.CLOCK_50(CLOCK_50), .GPIO_000(h), .GPIO_001(v), .GPIO_007(r), .GPIO_005(g), .GPIO_003(b));

initial begin
    $dumpfile("bitthelfensiemir");
    $dumpvars(0, mop_level);
    #1000000 $finish;
end

endmodule

module top_level (
input wire CLOCK_50, output wire GPIO_000, 
output wire GPIO_001, output wire GPIO_003,
output wire GPIO_005 ,output wire GPIO_007);

vga vga(.CLOCK_50(CLOCK_50), .o_hsync(GPIO_000), .o_vsync(GPIO_001), .o_red(GPIO_007), .o_grn(GPIO_005), .o_blu(GPIO_003));

endmodule