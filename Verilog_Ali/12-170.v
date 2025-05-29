// TOPLEVEL oberstes Modul (oder ist mit toplevel sowas wie das int main(); in C gemeint ?) 
module schaltung (clk, s,t,u);
    input clk;
    output reg s = 0,t = 0,u = 0;
    reg y;
    always @(posedge clk) begin
    s <= (s ^ t ^ u);
    t <= (s ^ t ^ u) | u;
    u <= t;
    end
endmodule

// man benötigt nur die positive taktflanke zu betrachten da flipflops nur bei positiver Taktflanke schalten
// und beide gates von dem flipßflop anbhängig sind

module test1;
    reg a = 0, b = 0, c = 0;
    reg clk = 0;
    always #1 clk = ~clk;
    schaltung sch(.clk(clk), .s(a), .t(b), .u(c));
    always 
        #1 $display("%4t %b    | %b | %b | %b", $time , clk , a,b,c);

    initial begin 
        $dumpfile("test");
        $dumpvars(0,clk , a, b, c);

        $display("   T  clk | a | b | c |\n--------------------------------");
        # 2 a = 1;
        # 4 a = 0;
        # 6 b = 1;
        # 8 b = 0;
        # 10 c = 1;
        # 12 c = 0;
        # 14 a = 1; b = 1;
        # 16 a = 0; b = 0;
        # 18 a = 1; c = 1:
        # 20 a = 0; c = 0;
        # 22 b = 1; c = 1;
        # 24 b = 0; c = 0;
        # 26 a = 1; b = 1; c = 1; 
        # 30 $finish;
    end
endmodule;

// Für einen Ba müsste ich einfrach nur <= zu = machen und vorher die wires an irgendwelche register zum starten anschließen glaub ich