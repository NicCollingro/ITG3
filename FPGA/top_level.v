module top_level(
    input wire CLOCK_50, GPIO_023, GPIO_021, GPIO_019, GPIO_017,
    output wire GPIO_015, GPIO_013, GPIO_011, GPIO_009,
    output reg [7:0] led
    );
    
    wire [3:0] keycode;
    reg [26:0] clock = 26'd0;
    reg clk;
    
    reg knopfdruck = 0;
    reg [1:0] count = 2'd0;
    reg [3:0] input1 = 4'd0;
    reg [3:0] input2 = 4'd0;
    reg [7:0] result;
    wire [7:0] mult;

    keypad paddie(.CLOCK_50(CLOCK_50), .keycode(keycode), .cols({GPIO_023, GPIO_021, GPIO_019, GPIO_017}),
                .rows({GPIO_015, GPIO_013, GPIO_011, GPIO_009}));

    mult4 multi(.a(input1), .b(input2), .out(mult));

    wire hilfe = ~(GPIO_023 & GPIO_021 & GPIO_019 & GPIO_017);
    
    always @(posedge CLOCK_50) begin
        if (hilfe) knopfdruck <= 1;
        else knopfdruck <= 0;
        end

    always @(posedge knopfdruck) begin
        case(count)
            2'd0: begin
                case (input1)
                    4'd15: begin
                        if (keycode <= 4'd9) begin
                            input1 <= keycode;
                            led [7:4] <= keycode;
                            count <= count +4'd1;
                        end else count <= count + 4'd1;
                    end
                    4'd10: begin
                    if (keycode <= 4'd5) begin
                        input1 <= (input1 + keycode);
                        led[7:4] <= input1;
                        end else count = count + 4'd1;
                    end
                    default: begin
                        case (keycode)
                            4'd0: input1 <= 4'd15;
                            4'd1: input1 <= 4'd10;
                            4'd10: count <= count + 4'd1;
                            4'd11: count <= count + 4'd1;
                            default: begin
                                input1 <= keycode;
                                led [7:4] <= keycode;
                            end
                        endcase
                   end

                endcase
            end
            
            2'd1: begin
                case (input2)
                    4'd15: begin
                        if (keycode <= 4'd9) begin
                            input2 <= keycode;
                            led [3:0] <= keycode;
                            count <= count + 4'd1;
                        end else count <= count + 4'd1;
                    end
                    4'd10: begin
                    if (keycode <= 4'd5) begin
                        input2 <= (input2 + keycode);
                        led[3:0] <= input2;
                    end else count = count + 4'd1;
                    end
                    default: begin
                        case (keycode)
                            4'd0: input2 <= 4'd15;
                            4'd1: input2 <= 4'd10;
                            4'd10: count <= count + 4'd1;
                            4'd11: count <= count + 4'd1;
                            default: begin
                                input2 <= keycode;
                                led [3:0] <= keycode;
                            end
                        endcase
                   end
                endcase
            end
            
            2'd2: begin
                led <= mult;
                if (keycode == 4'd11) begin
                    input1 <= 4'd0;
                    input2 <= 4'd0;
                    led <= 8'd0;
                    count <= 4'd0;
                end
            end
            
            default: begin
                input1 <= 4'd0;
                input2 <= 4'd0;
                led <= 8'd0;
                count <= 2'd0;
            end
        endcase
    end
   
endmodule

module keypad(input CLOCK_50, output reg [3:0] keycode,
              input [3:0] cols, output reg [3:0] rows = 4'b1110); 

    always @(posedge CLOCK_50) begin
        case (rows)
            4'b1110: rows <= 4'b1101;
            4'b1101: rows <= 4'b1011;
            4'b1011: rows <= 4'b0111;
            4'b0111: rows <= 4'b1110;
            default: rows <= 4'b1110;
        endcase
        
        case({rows,cols})
            8'b11101101: keycode <= 4'd1;
            8'b11101011: keycode <= 4'd2;
            8'b11100111: keycode <= 4'd3;
            8'b11011101: keycode <= 4'd4;
            8'b11011011: keycode <= 4'd5;
            8'b11010111: keycode <= 4'd6;
            8'b10111101: keycode <= 4'd7;
            8'b10111011: keycode <= 4'd8;
            8'b10110111: keycode <= 4'd9;
            8'b01111101: keycode <= 4'd10;
            8'b01111011: keycode <= 4'd0;
            8'b01110111: keycode <= 4'd11;
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

    wire [4:0] stage1_sum;
    wire [5:0] stage2_sum;
    wire [6:0] stage3_sum;

    add4er add1 (
        .in_a (pp0),
        .in_b ({1'b0, pp1[3:1]}),
        .out_sum (sum1),
        .out_carry (carry1)
    );
    assign stage1_sum = {carry1, sum1, pp1[0]};

    add4er add2 (
        .in_a (stage1_sum[4:1]),
        .in_b ({1'b0, pp2[3:1]}),
        .out_sum (sum2),
        .out_carry (carry2)
    );
    assign stage2_sum = {carry2, sum2, stage1_sum[0], pp2[0]};

    add4er add3 (
        .in_a (stage2_sum[5:2]),
        .in_b ({1'b0, pp3[3:1]}),
        .out_sum (sum3),
        .out_carry (carry3)
    );
    assign stage3_sum = {carry3, sum3, stage2_sum[1:0], pp3[0]};

    assign out = {stage3_sum[6:0], pp0[0]};
endmodule
