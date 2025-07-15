`include "symbols.vh"

module hsync(input i_clk, output reg o_hsync, output reg o_hblank);
    reg [11:0] count = 0;

    always @(posedge i_clk) begin
        count <= (count >= `HTOT) ? 0 : count + 1;
        o_hsync <= (count >= `HSRT && count < `HEND) ? 0 : 1;
        o_hblank <= (count <= `HRES) ? 0 : 1;
    end
endmodule

module vsync(input i_clk, output reg o_vsync, output reg o_vblank);
    reg [11:0] count = 0;

    always @(posedge i_clk) begin
        o_vsync <= (count >= `VSRT && count < `VEND) ? 0 : 1;
        o_vblank <= (count <= `VRES) ? 0 : 1;
        count <= (count >= `VTOT) ? 0 : count + 1;
    end
endmodule

module vga(input wire CLOCK_50, input wire [1:0] i_sel, output wire o_hsync, output wire o_vsync, output wire o_red, output wire o_grn, output wire o_blu);
    reg [14:0] radius = 100;
    reg CLOCK_HALF = 0;
    always @(posedge CLOCK_50) CLOCK_HALF = ~ CLOCK_HALF;
    wire pixclk = `BASECLK;

    hsync hs(.i_clk(pixclk), .o_hsync(o_hsync), .o_hblank(hblank));
    vsync vs(.i_clk(o_hsync), .o_vsync(o_vsync), .o_vblank(vblank));

    reg [22:0] x = 0;
    reg [22:0] y = 0;

    reg [100:0] sum = 0;

    always @(posedge pixclk)
        x <= hblank ? 0 : x+1;
    
    always @(posedge hblank)
        y <= vblank ? 0 : y+1;

    reg[9:0] cnt1 = 'b0;
    always @(posedge pixclk)
        cnt1 <= (vblank || hblank) ? 0 : cnt1+1;

    reg[11:0] cnt2 = 'b0;
    always @(posedge o_vsync)
        cnt2 <= cnt2 + 1;

    reg [6:0] cnt3 = 'b0;
    always @(negedge o_vsync)
        cnt3 =  cnt3 + 1;
    
    reg [2:0] color = 3'b0;

    always @(*) begin
        sum = (x-320)*(x-320) + (y-240)*(y-240);
        color = ( sum < (radius*radius)+100 && sum > (radius*radius)-100) ? {1'b1, 1'b1, 1'b1} | 3*{(x == 640 || x == 1 || y == 480 || y == 1) ? 1'b1 : 1'b0} : { 1'b0, 1'b0, 1'b0};
    end

assign {o_red, o_grn, o_blu} = color;

endmodule