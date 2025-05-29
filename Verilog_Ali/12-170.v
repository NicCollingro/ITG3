// TOPLEVEL oberstes Modul (oder ist mit toplevel sowas wie das int main(); in C gemeint ?) 
module schaltung (clk, s,t,u);
    input clk;
    output reg s = 1,t = 0,u = 0;
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
    wire a, b, c;
    reg clk = 0;
    always #5 clk = ~clk;
    schaltung sch(.clk(clk), .s(a), .t(b), .u(c));
    always 
        #1 $display("%4t %b    | %b | %b | %b", $time , clk , a,b,c);

    initial begin 
        $display("   T  clk | a | b | c |\n--------------------------------");
        # 50 $finish;
    end
endmodule;

// Für einen Ba müsste ich einfrach nur <= zu = machen und vorher die wires an irgendwelche register zum starten anschließen glaub ich