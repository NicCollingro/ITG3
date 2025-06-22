module alu(input wire clk, input wire [7:0] in_a, input wire [7:0] in_b, 
input wire [2:0] mode, input wire eo,
inout wire [7:0] out, output reg flag_zero = 0, 
output reg flag_carry = 0, input wire ee);

reg [7:0] r_out = 8'b0;
assign out = (eo) ? r_out : 8'bz;
wire [7:0] add;
wire [7:0] sub;
wire [7:0] und;
wire [7:0] oder;
wire [7:0] xoder;
wire cad, subc;
Volladdierer vadder(.in_a(in_a), .in_b(in_b),.out_sum(add), .out_carry(cad));
Vollsubtrahierer nadder(.in_a(in_a), .in_b(in_b),.out_diff(sub), .out_carry(subc));
Band land(.a(in_a), .b(in_b), .out(und));
Bor gore(.a(in_a), .b(in_b), .out(oder));
Bixbi hixbi(.a(in_a), .b(in_b), .out(xoder));

always @(posedge clk) begin
    if (ee) begin
        case (mode)
            3'b000: begin //add
                r_out <= add;
                flag_carry <= cad;
                if  (add == 8'd0) flag_zero <= 1;
            end     
            3'b001: begin //adc
                r_out <= (add + cad);
                flag_carry <= cad;
                if  ((add + cad) == 8'd0) flag_zero <= 1;
            end   
            3'b010: begin //sub
                r_out <= sub;
                flag_carry <= subc;
                if  (sub == 8'd0) flag_zero <= 1;
            end   
            3'b011: begin // inc
                r_out <= in_a + 8'd1;
            end    
            3'b100: begin // dec
                r_out <= in_a - 8'd1;
            end    
            3'b101: begin // and
                r_out <= und;
                flag_carry <= 0;
                if (und == 8'd0) flag_zero <= 1;
            end   
            3'b110: begin // or
                r_out <= oder;
                flag_carry <= 0;
                if (oder == 8'd0) flag_zero <= 1;
            end    
            3'b111: begin //xor
                r_out <= xoder;
                flag_carry <= 0;
                if (xoder == 8'd0) flag_zero <= 1;
            end    
            default: r_out <= 8'bx;
        endcase
    end
    
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
    output wire diff,
    output wire cout
    
);
    assign diff = a ^ b ^ cin;
    assign cout = (~a & b) | ((~(a ^ b)) & cin);
endmodule

module Vollsubtrahierer (
    input  [7:0] in_a,
    input  [7:0] in_b,
    output [7:0] out_diff,
    output       out_carry  
);
    wire [7:0] cin;

    halfsub S0 (in_a[0], in_b[0], 1'b0,     out_diff[0], cin[0]);
    halfsub S1 (in_a[1], in_b[1], cin[0], out_diff[1], cin[1]);
    halfsub S2 (in_a[2], in_b[2], cin[1], out_diff[2], cin[2]);
    halfsub S3 (in_a[3], in_b[3], cin[2], out_diff[3], cin[3]);
    halfsub S4 (in_a[4], in_b[4], cin[3], out_diff[4], cin[4]);
    halfsub S5 (in_a[5], in_b[5], cin[4], out_diff[5], cin[5]);
    halfsub S6 (in_a[6], in_b[6], cin[5], out_diff[6], cin[6]);
    halfsub S7 (in_a[7], in_b[7], cin[6], out_diff[7], out_carry);
endmodule

module Band (
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] out
);
    assign out = a & b;
endmodule

module Bor (
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] out
);
    assign out = a | b;
endmodule

module Bixbi (
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] out
);
    assign out = a ^ b;
endmodule
