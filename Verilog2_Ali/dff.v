module top_level();

reg D,clk;

always #1 clk = ~clk;
wire Q;

D_FlipFlop flopper (.D(D), .clk(clk), .Q(Q));

initial begin
    D  = 0; clk = 0;
    $dumpfile("test");
    $dumpvars(0,clk , D, Q);


    #2 D = 1;clk = 0;
    #4 D = 0;
    #2 D = 1;
    #2 D = 0;
    #4 D = 1;
end

endmodule



module D_FlipFlop(input wire D, input wire clk, output wire Q);
wire mitte;
D_Latch Latch1(.D(D), .clk(~clk), .Q(mitte));
D_Latch Latch2(.D(mitte), .clk(clk), .Q(Q));

endmodule

module D_Latch(input wire D, input wire clk, output Q);
wire a;
wire b;
wire nq;

assign a = ~(~D & clk);
assign b = ~(D & clk);

assign Q = ~(a & nq);
assign nq = ~(b & Q); 

endmodule