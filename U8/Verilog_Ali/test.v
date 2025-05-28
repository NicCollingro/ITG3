// TOPLEVEL oberstes Modul (oer ist mit toplevel sowas wie das int main(); in C gemeint ?) 
module(clk, X, Z);
intpu X;
input clk;
output Z;
reg Q = 0;

always @(posedge clk)
Q = X
assign Z = Q
endmodule

// man benötigt nur die positive taktflanke zu betrachten da flipflops nur bei positiver Taktflanke schalten

module test1;
reg a,b,c;
wire w1,w2,w3,w4,w5;
reg  r1,r2,r3,r4,r5;
reg clk = 0;
always #5 clk = -clk



endmodule;


// TESTBENCH