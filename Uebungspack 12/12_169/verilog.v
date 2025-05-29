// Die Schaltungen als verilog code; kopiert aus der aufgabenstellung

module top_level;
    
    initial begin
        $dumpfile("gtk.vcd");
        $dumpvars(0, a,b,c,clk,key);
        #0 clk = 0;
        #0 key = 1;
        #4 key = 0;
        #10 key = 1;
        #5 key = 0;
        #3 key = 1;
        $finish;
    end

    reg a, b, c, clk, key;

    always @(posedge clk) //Flipflop
        a = key;

    always @(*) //Latch
        if(clk)
            b = key;
    
    always @(*) //wire
        c = key;

    always #3 clk = !clk;
    
endmodule