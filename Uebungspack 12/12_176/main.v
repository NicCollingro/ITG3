module full_adder(input [8:0] A, input [8:0] B, output reg c_out, output reg [8:0] sum);
    always @(A,B) begin
        {c_out, sum} = A + B;
    end
endmodule

/*module sub(input [8:0] A, input [8:0] B, output reg out_carry, output reg [8:0] out_diff);
    always @(A,B) begin
        {out_carry, out_diff} = A - B;
    end
endmodule*/

/*Wertetabelle für Halbsubstrahierer
A   B   c_in    c_out   diff
0   0   0       0       0
0   0   1       1       1   +
0   1   0       1       1   -
0   1   1       1       0   -
1   0   0       0       1
1   0   1       0       0
1   1   0       0       0
1   1   1       1       1   +

Offensichtlich ist diff A XOR B XOR C ~> A^B^C
der carry ist (~A & B) | (~A & ~B & C) | (A & B & C) => (~A & B) | (~(A^B) & C)
*/

module halfsub(input A, input B, input carry, output reg out_carry, output reg out_diff);
    always @(A,B,carry) begin
        out_diff = A^B^carry;
        out_carry = (~A & B) | (~A & carry) | (B & carry);
    end
endmodule

module subFromHalfSubs(input [8:0] A, input [8:0] B, output wire out_carry, output wire [8:0] out_diff);
    wire [9:0] carry_intern;
    assign carry_intern[0] = 1'b0;
    genvar i;
    for (i=0; i < 9; i=i+1) begin : halfsub
        halfsub S(A[i], B[i], carry_intern[i], carry_intern[i+1], out_diff[i]);
    end
    assign out_carry = carry_intern[9];
endmodule

module multiplier(input [8:0] A, input [8:0] B, output [8:0] prod_lo, output [8:0] prod_hi);
    genvar i;
    
    wire [8:0] value [8:0];
    wire[17:0] product;
    
    for (i=0; i<9; i=i+1) begin
            assign value[i] = A & {9{B[i]}};
    end

    assign product = (value[0] << 0) + (value[1] << 1) + (value[2] << 2) + (value[3] << 3) + (value[4] << 4) + (value[5] << 5) + (value[6] << 6) + (value[7] << 7) + (value[8] << 8);
    //addiere alle partials zusammen und bitshifte sie so, dass sie an der richtigen Position stehen.
    //Splitte das product in hi und lo
    assign prod_lo = product[8:0];
    assign prod_hi = product[17:9];
endmodule

module sqrt(input [8:0] A, output [8:0] Sqrt);
    //Da ich nur 8 bits bekomme kann ich das auch hardcoden. Ich bekomme maximal einen wert von 512 => max 22^2
    assign Sqrt = (A >= 484) ? 22 : (A >= 441) ? 21 : (A >= 400) ? 20 : (A >= 361) ? 19 : (A >= 324) ? 18 : (A >= 289) ? 17 : (A >= 256) ? 16 : (A >= 225) ? 15 : (A >= 196) ? 14 : (A >= 169) ? 13
        : (A >= 144) ? 12: (A >= 121) ? 11 : (A >= 100) ? 10 : (A >=  81) ?  9 : (A >=  64) ?  8 : (A >=  49) ?  7 : (A >=  36) ?  6 : (A >=  25) ?  5 : (A >=  16) ?  4 : (A >=   9) ?  3
        : (A >=   4) ?  2 : (A >=   1) ?  1 : 0;
endmodule


module top_level();
    reg [8:0] A= 25;
    reg [8:0] B = 256;
    wire [8:0] S;
    wire [8:0] C;

    sqrt Addr(A, S);

    initial begin
        #1; 
        $display("%b %f ", S, S);
        $finish;
    end


endmodule