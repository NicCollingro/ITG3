module top_level();

    reg clk = 1;
    always #1 clk = !clk;

    reg[2:0] cnt = 0;       //erstelle 3 bit großen bus als counter
    always @(posedge clk) cnt = cnt + 1;

    reg red = 1, yellow = 1, green = 0;
    reg red2 = 0, yellow2 = 0, green2 = 0;

    always #1 $display("%b %f %b %b %b", clk, cnt, red, yellow, green);

    
    //Verhaltensbeschreibung

    always @(cnt) begin // immer wenn sich count ändert aufrufen
        red <= (~cnt[0] & ~cnt[1] & ~cnt[2]) | (cnt[2] & (cnt[1] | cnt[0]));
        yellow <= (~cnt[2] & cnt[0] & cnt[1]) | (~cnt[0] & ~cnt[1] & ~cnt[2]) | (cnt[2] & ~cnt[0] & ~cnt[1]);
        green <= ~cnt[2] & ( cnt[1] & ~cnt[0] | ~cnt[1] & cnt[0]);
    end

    //Strukturbeschreibung

    //Die Strukturbeschreibung ist in der Musterlösung genau gleich zur Verhaltensbeschreibung


    initial begin
        $dumpfile("testbench.vcd"); 
        $dumpvars(0, clk, cnt, red, yellow, green);
        #40 $finish; 
    end

endmodule