`include "symbols.vh"

module vsync(input wire i_clk, output reg o_vsync = 1'd1, output reg o_vblank = 1'd0);

reg [11:0] cnt = 12'd0;

    always @(posedge i_clk) begin
        cnt <= (cnt < `VTOT) ? cnt + 12'd1 : 12'd0;
        o_vsync <= (`VSRT <= cnt && cnt < `VEND) ? 0 : 1;
        o_vblank <= (cnt <= `VRES) ? 0 : 1;
    end
endmodule