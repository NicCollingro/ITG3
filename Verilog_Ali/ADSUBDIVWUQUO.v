module top_level;
    reg  [7:0] in_a;
    reg  [7:0] in_b;
    wire [7:0] out;
    wire       carry;

    Volladdierer vad(.in_a(in_a), .in_b(in_b), .out_sum(out), .out_carry(carry));
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

module Volladdierer (
    input  [7:0] in_a,
    input  [7:0] in_b,
    output [7:0] out_sum,
    output       out_carry
);
    wire [7:0] c;
    addierer FA0 (in_a[0], in_b[0], 1'b0,     out_sum[0], c[0]);
    addierer FA1 (in_a[1], in_b[1], c[0],     out_sum[1], c[1]);
    addierer FA2 (in_a[2], in_b[2], c[1],     out_sum[2], c[2]);
    addierer FA3 (in_a[3], in_b[3], c[2],     out_sum[3], c[3]);
    addierer FA4 (in_a[4], in_b[4], c[3],     out_sum[4], c[4]);
    addierer FA5 (in_a[5], in_b[5], c[4],     out_sum[5], c[5]);
    addierer FA6 (in_a[6], in_b[6], c[5],     out_sum[6], c[6]);
    addierer FA7 (in_a[7], in_b[7], c[6],     out_sum[7], out_carry);
endmodule

module halfsub (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);
    
endmodule

