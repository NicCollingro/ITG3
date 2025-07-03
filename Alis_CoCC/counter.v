module counter (input wire clk, input wire down, input wire reset,
input wire set, input wire [7:0] in, input wire oe,  output wire [7:0] out);
reg [7:0] r_out = 8'd0;
assign out = (oe) ? r_out : 8'bz;
always @(posedge clk) begin
    if (reset) begin
         r_out <= 8'd0;
    end
    else begin
        if(set) r_out <= in;
        else begin
            if (down) r_out <= r_out - 1'd1;
            else
            r_out <= r_out + 1;
        end 
    end
end
endmodule