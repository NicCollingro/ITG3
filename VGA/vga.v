module vga (
input wire CLOCK_25,
output wire o_hsync,
output wire o_vsync,
output wire o_red,
output wire o_grn,
output wire o_blu
);

reg [11:0] x,y;


// hsync und vsync hab ich ja mit der negedge von hsync in 
// Vsync implementiert weil trust is geuil so habibi
/*
hsync hippi ( .i_clk(CLOCK_25), .o_hsync(o_sync), .o_hblank);
vsync vsynchi ( .i_clk(o_blank), .o_vsync(o_vsync), .o_vblank(o_vblank));
*/

endmodule
