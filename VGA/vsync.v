module vsync(input wire i_clk, output reg o_vsync = 1'd1, output reg o_vblank = 1'd0);
reg [3:0] out = 4'd0;

always @(negedge i_clk) begin
    case (out)
        4'd0: begin
            out <= out + 4'd1;
            o_vsync <= 1'd1;
            o_vblank <= 1'd0;
        end
        4'd9: begin
            out <= out + 4'd1;
            o_vsync <= 1'd1;
            o_vblank <= 1'd1;
        end
        4'd11: begin
            out <= out + 4'd1;
            o_vsync <= 1'd0;
            o_vblank <= 1'd1;
        end
        4'd12: begin
            out <= out + 4'd1;
            o_vsync <= 1'd1;
            o_vblank <= 1'd1;
        end
        default: out <= out + 4'd1;
    endcase


end
endmodule