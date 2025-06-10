module top_level(CLOCK_50,GPIO_023,GPIO_021,led,
 GPIO_019);
input CLOCK_50, 
reg [2:0] cols, [3:0] rows, [3:0] keycode;
keypad paddie(.CLOCK_50(CLOCK_50), .cols(.cols))
reg  [26:0] clock 26'd0;
reg clk;
always @(posedge CLOCK_50) begin
    clock <= clock + 1;
    clk <= clock[25];
end

always @(posedge clk)begin

end

endmodule

module keypad(input CLOCK_50; output reg [3:0] keycode,
input [2:0] cols, output reg [3:0] rows = 4'b1110); 
reg  [26:0] clock 26'd0;
reg clk;
always @(posedge CLOCK_50) begin
    clock <= clock + 1;
    clk <= clock[20];
end



always @(posedge clk) begin
    case (rows)
        4'1110:  rows <= 4'b1101;
        4'1101:  rows <= 4'b1011;
        4'1011:  rows <= 4'b0111;
        4'0111:  rows <= 4'b1110;

    endcase
    case({rows,cols})
        7'1110110: keycode <= 4'd0;
        7’1110101: keycode <= 4'd1;
        7'1110011: keycode <= 4'd2;
        7'1101110: keycode <= 4'd3;
        7'1101101: keycode <= 4'd4;
        7'1101011: keycode <= 4'd5;
        7'1011110: keycode <= 4'd6;
        7'1011101: keycode <= 4'd7;
        7'1011101: keycode <= 4'd8;
        7'0111110: keycode <= 4'd9;
        7'0111101: keycode <= 4'd10;
        7'0111011: keycode <= 4'd11;
        default: keycode <= keycode;
    endcase
end
endmodule

module addierer (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
    );
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module add4er (
    input  [3:0] in_a,
    input  [3:0] in_b,
    output [3:0] out_sum,
    output       out_carry
);
    wire [3:0] c;
    addierer FA0 (in_a[0], in_b[0], 1'b0,     out_sum[0], c[0]);
    addierer FA1 (in_a[1], in_b[1], c[0],     out_sum[1], c[1]);
    addierer FA2 (in_a[2], in_b[2], c[1],     out_sum[2], c[2]);
    addierer FA3 (in_a[3], in_b[3], c[2],     out_sum[3], out_carry);

    endmodule

module mult4 (
    input  [3:0] wire a,
    input  [3:0] wire b,
    output [7:0] wire out,
    );
    wire [4:0] help = 5'd0;
    reg [3:0] help2 = 4'd0;
    4addierer 4A0 (a ,4'd0, help[3:0], help[4]);
    help2[0] = help[0];
    4addierer 4A1 (a ,help[4:1], help[3:0], help[4]);
    help[1] = help[0];
    4addierer 4A2 (a ,help[4:1], help[3:0], help[4]);
    help[2] = help[0];
    4addierer 4A3 (a ,help[4:1], help[3:0], help[4]);
    out[2:0] = help;
    out[7:3] = 4A3

endmodule