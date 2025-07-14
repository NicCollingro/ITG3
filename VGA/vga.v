module vga (
input wire CLOCK_50,
output wire o_hsync,
output wire o_vsync,
output wire o_red,
output wire o_grn,
output wire o_blu
);
reg clk= 0;
always @(CLOCK_50) begin
    clk = ~clk;
end

reg [11:0] ix [11:0],
reg [11:0] y = 0;
wire o_hblank, o_vblank;
hsync hippi ( .i_clk(clk), .o_hsync(o_hsync), .o_hblank(o_hblank));
vsync vsynchi ( .i_clk(o_blank), .o_vsync(o_vsync), .o_vblank(o_vblank));

reg [11:0] test= 12'd100;

always @(posedge clk) begin
    ix[y] <= ix + 1;
    if ((ix - 5)*(ix - 5)+ (y-5)*(y-5) == test)
end

always @(negedge o_hblank) begin
    y <= o_vblank ? 0 : y + 1;
end



endmodule
