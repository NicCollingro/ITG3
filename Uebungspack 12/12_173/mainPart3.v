module top_level();

    reg clk = 1;
    always #1 clk = !clk;

    reg[2:0] cnt = 0;       //erstelle 3 bit großen bus als counter
    always @(posedge clk) cnt = cnt + 1;

    reg red = 1, yellow = 1, green = 0;
    wire red2 = 0, yellow2 = 0, green2 = 0;
    reg button = 0;

    always #1 $display("%b %f %b %b %b", clk, cnt, red, yellow, green);

    
    //Verhaltensbeschreibung

    always @(cnt) begin // immer wenn sich count ändert aufrufen
        red <= (~cnt[0] & ~cnt[1] & ~cnt[2]) | (cnt[2] & (cnt[1] | cnt[0]));
        yellow <= (~cnt[2] & cnt[0] & cnt[1]) | (~cnt[0] & ~cnt[1] & ~cnt[2]) | (cnt[2] & ~cnt[0] & ~cnt[1]);
        green <= ~cnt[2] & ( cnt[1] & ~cnt[0] | ~cnt[1] & cnt[0]);
    end

    //Strukturbeschreibung

    // Mit assign auf wires anstatt in extra registern zu speichern und ohne always, da einmal zugewiesen immer den Wert dessen ausgibt, was er zugewiesen bekommen hat.

    assign red2 = (~cnt[0] & ~cnt[1] & ~cnt[2]) | (cnt[2] & (cnt[1] | cnt[0]));
    assign yellow2 = (~cnt[2] & cnt[0] & cnt[1]) | (~cnt[0] & ~cnt[1] & ~cnt[2]) | (cnt[2] & ~cnt[0] & ~cnt[1]);
    assign green2 = ~cnt[2] & ( cnt[1] & ~cnt[0] | ~cnt[1] & cnt[0]);

    initial begin
        $dumpfile("testbench.vcd"); 
        $dumpvars(0, clk, cnt, red, yellow, green, red2, yellow2, green2);
        #40 $finish; 
    end

endmodule