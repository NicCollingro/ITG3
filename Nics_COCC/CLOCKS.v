//`include "symbols.vh"
module clocks(input wire clk, input wire halt, input wire reset, output wire cycle_clk, output wire ram_clk, output wire internal_clk);
    reg [2:0] cnt = 3'b001;

    always @(posedge clk) begin
        case(cnt)
            3'b001: cnt <= 3'b010;
            3'b010: cnt <= 3'b100;
            3'b100: cnt <= 3'b001;
        endcase
    end

    assign cycle_clk = (cnt == 3'b001 & ~halt)  ? 1 : 0;
    assign mem_clk = (cnt == 3'b010 & ~halt) ? 1 : 0;
    assign internal_clk = (cnt == 3'b100 & ~halt) ? 1 : 0;
endmodule