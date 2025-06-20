module tristate_buffer(input wire oe, input wire[7:0] in, inout wire[7:0] out);
    assign out = oe ? in : 1'bz;
endmodule


module counter(output wire[7:0] out, input wire clk, input wire down, input wire reset, input wire set, input wire [7:0] in, input wire oe, output wire [7:0] out);
    reg [7:0] r_out = 8'b0;
    assign out = oe ? r_out : 8'bz;

    always @(posedgeclk) begin
        if (reset)
            r_out <= 0;
        else
            if(set)
                r_out <= in;
            else
                if (down)
                    r_out <= r_out - 1'b1;
                else
                    r_out <= r_out + 1'b1;
    end
endmodule