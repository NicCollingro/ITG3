module hsync(input wire i_clk, output wire o_hsync 1'd1, output reg o_hblank = 1'd0);
    reg [4:0] out = 5'd0;
    always @(posedge i_clk) begin
        case (out)
            3'd0: begin
                out <= out + 5'd1;
                o_hblank <= 1'd0;
                o_hsync <= 1'd1;
            end 
            3'd22: begin
                out <= out + 5'd1;
                o_hblank <= 1'd1;
            end 
            3'd26: begin
                out <= out + 5'd1;
                o_hblank <= 1'd1;
                o_hsync <= 1'd0;
            end 
            3'd29: begin
                out <= out + 5'd1;
                o_hblank <= 1'd1;
                o_hsync <= 1'd1;
            end
            default: out <= out + 5'd1;
        endcase
    end

endmodule