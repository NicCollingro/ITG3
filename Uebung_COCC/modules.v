module tristate_buffer(input wire oe, input wire[7:0] in, inout wire[7:0] out);
    assign out = oe ? in : 1'bz;
endmodule


module counter(output wire[7:0] out, input wire clk, input wire down, input wire reset, input wire set, input wire [7:0] in, input wire oe);
    reg [7:0] r_out = 8'b0;
    assign out = oe ? r_out : 8'bz;

    always @(posedge clk) begin
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


module register(input wire en, input wire[7:0] in, input wire clk, output reg[7:0] out);
    always @(posedge clk) begin
        if (en)
            assign out = in;
    end
endmodule


module regblock(input wire we, input wire oe, input wire[2:0] oaddr, input wire[2:0] iaddr, input wire clk, input wire[7:0] idata, output wire[7:0] odata, output wire[7:0] rega, output wire[7:0] regb);
    reg [7:0] registers[7:0];

    assign odata = oe ? oaddr : 1'bz;
    assign rega = registers[0];
    assign regb = registers[1];

    always @(posedge clk) begin
        if (we)
            registers[iaddr] = idata;
    end
endmodule