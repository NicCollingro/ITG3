module top_level();

    reg clk = 1;
    always #1 clk = !clk;

    reg[2:0] cnt = 0;       //erstelle 3 bit großen bus als counter
    always @(posedge clk) cnt = cnt + 1;

    wire red = 1, yellow = 1, green = 0;

    reg button = 0;

    always @(cnt == 0) button = ~button;

    always #1 $display("%b %f %b %b %b", clk, cnt, red, yellow, green);

    always @(cnt == 0 & ~button) begin
         // immer wenn sich count ändert aufrufen
        assign red <= (~cnt[0] & ~cnt[1] & ~cnt[2]) | (cnt[2] & (cnt[1] | cnt[0]));
        assign yellow <= (~cnt[2] & cnt[0] & cnt[1]) | (~cnt[0] & ~cnt[1] & ~cnt[2]) | (cnt[2] & ~cnt[0] & ~cnt[1]);
        assign green <= ~cnt[2] & ( cnt[1] & ~cnt[0] | ~cnt[1] & cnt[0]);
    end

    always @(cnt == 0 & button) begin
        assign red = 1;
        assign yellow = 0;
        assign green = 0;
    end

    initial begin
        $dumpfile("testbench.vcd"); 
        $dumpvars(0, clk, cnt, red, yellow, green, red2, yellow2, green2);
        #40 $finish;
    end

endmodule