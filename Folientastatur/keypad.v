module keycode(input CLOCK_50, input [2:0] cols, output reg [3:0] rows, output reg [3:0] keycode);

    reg [19:0] counter; 

    wire clk;

    reg [2:0] rows_slc = 0;

    always @(posedge CLOCK_50) begin
        counter = counter + 1;
    end

    assign clk = counter[19];

    always @(posedge clk) begin
        rows_slc <= rows_slc + 1;
        rows <= ~(4'b0001 << rows_slc);
    end

    case({rows, cols})
        7'b1110_110: keycode <= 4'd0;
        7'b1110_101: keycode <= 4'd1;
        7'b1110_011: keycode <= 4'd2;
        7'b1101_110: keycode <= 4'd3;
        7'b1101_101: keycode <= 4'd4;
        7'b1101_011: keycode <= 4'd5;
        7'b1011_110: keycode <= 4'd6;
        7'b1011_101: keycode <= 4'd7;
        7'b1011_011: keycode <= 4'd8;
        7'b0111_110: keycode <= 4'd9;
        7'b0111_101: keycode <= 4'd10;
        7'b0111_011: keycode <= 4'd11;
    endcase
endmodule