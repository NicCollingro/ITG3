module clocks (
input wire clk, input wire halt , input wire reset , 
output reg cycle_clk = 0, output reg ram_clk = 0, output reg internal_clk = 0 
);
reg [2:0] cnt = 3'd1;

always @(posedge clk) begin
    if (cnt == 3'd4) begin
        cnt <= 3'd1;
    end else begin
        cnt <= {cnt[1:0],0};
    end

    cycle_clk <= cnt[0];
    ram_clk <= cnt[1];
    internal_clk <= [2];
end
endmodule