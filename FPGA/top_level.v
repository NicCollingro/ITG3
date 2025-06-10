module top_level(CLOCK_50,GPIO_023,GPIO_021,GPIO_019, led);
input CLOCK_50, GPIO_23,GPIO_021,GPIO_019;
output [7:0] led;
reg [2:0] cols, [3:0] rows, [3:0] keycode;
cols[0] = GPIO_023;
cols[1] = GPIO_021;
cols[2] = GPIO_019;
reg  [26:0] clock 26'd0;
reg clk;
always @(posedge CLOCK_50) begin
    clock <= clock + 1;
    clk <= clock[24];
end
keypad paddie(.CLOCK_50(CLOCK_50), .cols(.cols))
keycode, rows = paddie;
reg [1:0] count;
reg [3:0] input1, [3:0] input2, [3:0] input3;
always @(posedge clk)begin
    case(count)
/*
    2'd0: begin
        case (input1):begin
            4'd10: begin
            if (keycode <= 4'd5) begin 
            count <= count +1;
            input1 <= keycode;
            led[7:4] <= keycode;  
            end else count = count + 4'd1;
            end
        end
            default: begin
                if (keycode <= 4'd9)begin
                    if (keycode != 4'd1) begin
                    count <= count +1
                    input1 <= keycode;
                    led[7:4] <= keycode;

                    end else input1 <= 4'd10;
                end
            end
        endcase
    end
*/

    endcase
    
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
        7'1110110: keycode <= 4'd1;
        7’1110101: keycode <= 4'd2;
        7'1110011: keycode <= 4'd3;
        7'1101110: keycode <= 4'd4;
        7'1101101: keycode <= 4'd5;
        7'1101011: keycode <= 4'd6;
        7'1011110: keycode <= 4'd7;
        7'1011101: keycode <= 4'd8;
        7'1011101: keycode <= 4'd9;
        7'0111110: keycode <= 4'd10;
        7'0111101: keycode <= 4'd0;
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
    input  [3:0] a,
    input  [3:0] b,
    output [7:0] out
);
    wire [3:0] pp0 = a & {4{b[0]}};
    wire [3:0] pp1 = a & {4{b[1]}};
    wire [3:0] pp2 = a & {4{b[2]}};
    wire [3:0] pp3 = a & {4{b[3]}};

    wire [3:0] sum1, sum2, sum3;
    wire       carry1, carry2, carry3;

    wire [4:0] shifted_pp1 = {1'b0, pp1};
    wire [5:0] shifted_pp2 = {2'b0, pp2};
    wire [6:0] shifted_pp3 = {3'b0, pp3};

    wire [4:0] stage1_sum;
    wire [5:0] stage2_sum;
    wire [6:0] stage3_sum;

    add4er add1 (
        .in_a (pp0),
        .in_b (shifted_pp1[3:0]),
        .out_sum (sum1),
        .out_carry (carry1)
    );
    assign stage1_sum = {carry1, sum1};

    add4er add2 (
        .in_a (stage1_sum[3:0]),
        .in_b (shifted_pp2[3:0]),
        .out_sum (sum2),
        .out_carry (carry2)
    );
    assign stage2_sum = {carry2, sum2, stage1_sum[4]};

    add4er add3 (
        .in_a (stage2_sum[3:0]),
        .in_b (shifted_pp3[3:0]),
        .out_sum (sum3),
        .out_carry (carry3)
    );
    assign stage3_sum = {carry3, sum3, stage2_sum[5], stage2_sum[4]};

    assign out = {stage3_sum[6:0], pp0[0]};

endmodule
