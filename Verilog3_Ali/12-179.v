module top_level ();

endmodule

module volcol (input wire clk, inout sda, input wire oe)
reg sda_r;
assign sda = oe ? sda_r : 1'bz;
reg [7:0] Din;
always @(posedge clk) begin
    case (oe)
        1'd0: begin
            Din[0] <= Din << 1'b1;
            Din[0] <= sda; 
        end
        1'd1: begin
                    
        end

        default:
endcase
end
endmodule