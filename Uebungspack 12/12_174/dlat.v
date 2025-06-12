module MYdlat(input D, input clk, output Q);
    wire X;
    wire Y;
    wire NQ;

    assign X = ~(D & clk);
    assign Y = ~(clk & X);

    assign Q = ~(X & NQ);
    assign NQ = ~(Y & Q);
endmodule