module top_level ();
reg clk = 0;
always #1 clk = ~clk;

reg sda_r;
reg oe = 0;
wire inout sda;
assign sda = oe ? sda_r : 1'bz;
reg io1;
reg [7:0] wr = 8'b10100101;

volcol fokke (.clk(clk), .sda(sda), .oe(oe));

always @(posedge clk) begin
    case



        default: sda_r <= x;
    endcase
end
endmodule

module volcol (input wire clk, inout sda, input wire ~oe)
reg sda_r;
assign sda = oe ? sda_r : 1'bz;
reg [7:0] Din;
always @(posedge clk) begin
    case (oe)
        1'd0: begin
            Din[0] <= sda_r;
            Din[0] <= Din << 1'b1; 
        end
        1'd1: begin
            Din[0] <= sda_r;
            Din[0] <= Dinn >> 1'd1;
        end

        default: sda_r <= x; 
endcase
end
endmodule