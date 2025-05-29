module D_Flipflop(clk,key,Q);
    input clk;
    input key;
    output reg Q = 0;

    always @(posedge clk) begin 
        Q <= key;
    end
endmodule

module D_Latch(clk,key,Q);
    input clk;
    input key;
    output reg Q = 0;
    always @(*) begin
        if(clk) Q = key;
    end
endmodule

module wire_key(key,Q);
    input key;
    output reg Q;
    always @(*) begin
        Q = key;
    end
endmodule

module Top_Level();
    reg key = 0;
    wire a , b, c;
    reg clk = 0;
    always #5 clk = ~clk;
    D_Flipflop dff(.clk(clk), .key(key), .Q(a));
    D_Latch dl(.clk(clk), .key(key), .Q(b));
    wire_key wk(.key(key), .Q(c));
    always
        #1 $display("%4t %b    | %b | %b | %b | %b ", $time , clk , a,b,c,key);
    initial begin
        $display("   T  clk | a | b | c |Key|\n--------------------------------");
        #2 key = 1;
        #4 key = 0;
        #6 key = 1;
        #8 key = 0;
        #10 key = 1;
        #12 key = 0;
        #14 $finish;
    end
endmodule