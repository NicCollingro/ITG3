module top_level ();
    reg D,clk;
    wire Q;
    always #1 clk = ~clk;

initial begin
    D  = 0;
    clk = 0;
    $dumpfile("test");
    $dumpvars(0,D,clk,Q);

    # 2 D = 1;
    # 4 D = 0;
    # 2 D = 1;
    # 2 D = 0;
    # 4 D = 1;
    # 10 $finish;
end
endmodule

module DLV (input wire D, input wire clk, output reg Q);
    reg [1:0] verz;
    reg sp;

    always @(clk) begin                  //unsicher op ich es mit dem # als delay machen
        verz <= verz + 2'd1;             //solte oder nicht das geht aber auch 
        if (clk == 1'd1) sp <= D;
        if (verz == 2'd3) Q <= sp;
    end
    
    always @(D) begin
        if (clk == 1'd1) sp <= D;
        
    end
endmodule