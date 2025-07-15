`include "hsync.v"
`include "vsync.v"

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
    clk <= ~clk;
end

reg [11:0] ix [11:0];
reg [11:0] y = 12'd0;
wire o_hblank, o_vblank;
hsync hippi ( .i_clk(clk), .o_hsync(o_hsync), .o_hblank(o_hblank));
vsync vsynchi ( .i_clk(o_hsync), .o_vsync(o_vsync), .o_vblank(o_vblank));

reg [11:0] test= 12'd100;
reg [2:0] rgb = 3'd0;
always @(posedge clk) begin
    ix[y] <= ix[y] + 1;
end

always @(negedge o_hblank) begin
    y <= (o_vblank) ? 0 : y + 1;
end

always @(*) begin
    /*
    if ((ix[y] - 5)*(ix[y] - 5)+ (y-5)*(y-5) == test) begin 
        rgb <= 3'b100;
    end
    else begin
        rgb <= 3'b000;
    end
    */

    case (ix[y])
        12'd0:rgb <= 3'b000;
        12'd80:rgb <= 3'b001;
        12'd160:rgb <= 3'b010;
        12'd240:rgb <= 3'b011;
        12'd320:rgb <= 3'b100;
        12'd400:rgb <= 3'b101;
        12'd480:rgb <= 3'b110;
        12'd560:rgb <= 3'b111;
        12'd640:rgb <= 3'b000;
        default:  rgb <= 3'b000;
    endcase
end

assign {o_red, o_grn, o_blu} = rgb;

endmodule
