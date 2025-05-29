// TOPLEVEL oberstes Modul (oder ist mit toplevel sowas wie das int main(); in C gemeint ?) 
module schaltung (clk, s,t,u);
    input clk;
    output reg s = 0,t = 0,u = 0;
    reg y;
    always @(posedge clk) begin
    s <= (s ^ t ^ u);
    t <= (s ^ t ^ u) | u;
    u <= t;

    // BA
    //  always @(posedge clk) begin
    //      y = (s ^ t ^ u)
    //      s = y
    //      t = (y | u)
    //      u = t
    end
endmodule

// man benötigt nur die positive taktflanke zu betrachten da flipflops nur bei positiver Taktflanke schalten
// und beide gates von dem flipßflop anbhängig sind

module test1;
    wire a, b , c;
    reg clk = 0;
    always #1 clk = ~clk;
    schaltung S(.clk(clk), .s(a), .t(b), .u(c));
    always 
        #1 $display("%4t %b    | %b | %b | %b", $time , clk , a,b,c);

    initial begin 
        $dumpfile("test");
        $dumpvars(0,clk , a, b, c);

        $display("   T  clk | a | b | c |\n--------------------------------");
        # 2 S.s = 1; S.t = 0; S.u = 0;
        # 2 S.s = 0; S.t = 0; S.u = 0;
        # 2 S.t = 1; S.s = 0; S.u = 0;
        # 2 S.t = 0; S.s = 0; S.u = 0;
        # 2 S.u = 1; S.s = 1; S.t = 0;
        # 2 S.u = 0; S.s = 1; S.t = 0;
        # 2 S.s = 1; S.t = 1; S.u = 0;
        # 2 S.s = 0; S.t = 0; S.u = 0;
        # 2 S.s = 1; S.u = 1; S.t = 0;
        # 2 S.s = 0; S.u = 0; S.t = 0;
        # 2 S.t = 1; S.u = 1; S.s = 0;
        # 2 S.t = 0; S.u = 0; S.s = 0;
        # 2 S.s = 1; S.t = 1; S.u = 1; 
        # 2 $finish;
    end
endmodule;
