module top_level;
    reg clk = 0, key;
    wire a, b, c, d, e, f;
    always #5 clk = !clk;

    schaltung S(clk, a, b, c, d, e, f);

    initial begin
        $dumpfile("gtk.vcd");
        $dumpvars(0, clk, a, b, c, d, e, f);
        //ich lasse monitor weg, da ich gtk wave benutze

        //startzustände
        #0 S.a = 0; S.b = 0; S.c = 0; S.d = 0; S.e = 0; S.f = 0;
        #10 S.a = 0; S.b = 0; S.c = 1; S.d = 0; S.e = 0; S.f = 1;
        #10 S.a = 0; S.b = 1; S.c = 0; S.d = 0; S.e = 1; S.f = 0;
        #10 S.a = 0; S.b = 1; S.c = 1; S.d = 0; S.e = 1; S.f = 1;
        #10 S.a = 1; S.b = 0; S.c = 0; S.d = 1; S.e = 0; S.f = 0;
        #10 S.a = 1; S.b = 0; S.c = 1; S.d = 1; S.e = 0; S.f = 1;
        #10 S.a = 1; S.b = 1; S.c = 0; S.d = 1; S.e = 1; S.f = 0;
        #10 S.a = 1; S.b = 1; S.c = 1; S.d = 1; S.e = 1; S.f = 1;
        #10 $finish;
    end
endmodule