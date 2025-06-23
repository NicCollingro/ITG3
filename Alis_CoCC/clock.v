module clocks (
input wire clk, input wire halt , input wire reset , 
output reg cycle_clk = 0, output reg ram_clk = 0, output reg internal_clk = 0 
);
reg [2:0] cnt = 3'd1;

always @(posedge clk) begin
    if (halt) 
    else if (reset) cnt = 3'd4;
    else begin
    case (cnt)
        3'd1: cnt <= {cnt[1:0],1'd0};
        3'd2: cnt <= {cnt[1:0],1'd0};
        3'd4: cnt <= 3'd1;
        default: cnt = 3'dx; //für schlechten code :((
    endcase

    cycle_clk <= cnt[0];
    ram_clk <= cnt[1];
    internal_clk <= cnt[2];
    end
end
endmodule
