module keycode(input CLOCK_50, input [3:0] cols, output reg [3:0] rows, output reg [3:0] keycode);

    reg [19:0] counter; 

    wire clk;

    reg [1:0] rows_slc = 0;

    always @(posedge CLOCK_50) begin
        counter = counter + 1;
    end

    assign clk = counter[19];

    always @(posedge clk) begin
        rows_slc <= rows_slc + 1;
        rows <= ~(4'b0001 << rows_slc);
    end

    always @(posedge clk) begin
        case({rows, cols})
            8'b1110_1110: keycode <= 4'd0;
            8'b1110_1101: keycode <= 4'd1;
            8'b1110_1011: keycode <= 4'd2;
            8'b1110_0111: keycode <= 4'd3;
            8'b1101_1110: keycode <= 4'd4;
            8'b1101_1101: keycode <= 4'd5;
            8'b1101_1011: keycode <= 4'd6;
            8'b1101_0111: keycode <= 4'd7;
            8'b1011_1110: keycode <= 4'd8;
            8'b1011_1101: keycode <= 4'd9;
            8'b1011_1011: keycode <= 4'd10;
            8'b1011_0111: keycode <= 4'd11;
            8'b0111_1110: keycode <= 4'd12;
            8'b0111_1101: keycode <= 4'd13;
            8'b0111_1011: keycode <= 4'd14;
            8'b0111_0111: keycode <= 4'd15;
        endcase
    end
endmodule