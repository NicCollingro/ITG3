module flankdet(a,b,z);
input a;
input b;
output reg z = 0;
reg n = a;
always @(a or b) begin
    z = ~z;
end
endmodule

module test();
    wire z;
    reg a,b;
    flankdet flanki(.a(a), .b(b), .z(z));

    always 
        #1 $display("%4t    | %b | %b | %b", $time , a,b,z);
    initial begin
        $display("   T | a | b | z |\n--------------------------------");
            a = 0; b = 0;
        #2  a = 1; b = 0;

    end
endmodule