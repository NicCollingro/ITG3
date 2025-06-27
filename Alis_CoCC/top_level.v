module top_level (input wire CLOCK_50, output wire [7:0] led);

reg [24:0] help;
reg clk;
always @(posedge CLOCK_50) begin
    help <= help 1'd1;
    clk <= help[23];
end

computer combo(.clk(clk));

endmodule