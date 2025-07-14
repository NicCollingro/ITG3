`include "symbols.vh"

module hsync(input wire i_clk, output reg o_hsync = 1'd1, output reg o_hblank = 1'd0);
    reg [11:0] cnt = 12'd0;

    always @(posedge i_clk) begin
        cnt <= (cnt < `HTOT) ? cnt + 12'd1 : 12'd0;
        o_hsync <= (`HSRT <= cnt && cnt <= `HEND) ? 0 : 1;
        o_hblank <= (cnt > `HRES) ? 1 : 0;
    end

endmodule