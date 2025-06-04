module top_level();

    reg clk = 1;
    always #1 clk = !clk;

    reg[2:0] cnt = 0;       //erstelle 3 bit großen bus als counter
    always @(posedge clk) cnt = cnt + 1;

    reg red = 1, yellow = 1, green = 0;

    reg button = 0, btnsafestate = 0;


    always @(cnt) begin
        if(cnt == 0 && button == 1) begin
            btnsafestate = 1;
            button = 0;
        end
        else if(cnt == 0 && button == 0) begin
            btnsafestate = 0;
        end
        else if(button == 1 && btnsafestate == 1) begin
            button = 0; // verhindert 2 Rotphasen hintereinander
        end
    end

    always #1 $display("%b %f %b %b %b %b %b", clk, cnt, button, btnsafestate, red, yellow, green);

    always @(cnt) begin
        if(btnsafestate == 0) begin
            red = (~cnt[0] & ~cnt[1] & ~cnt[2]) | (cnt[2] & (cnt[1] | cnt[0]));
            yellow = (~cnt[2] & cnt[0] & cnt[1]) | (~cnt[0] & ~cnt[1] & ~cnt[2]) | (cnt[2] & ~cnt[0] & ~cnt[1]);
            green = ~cnt[2] & ( cnt[1] & ~cnt[0] | ~cnt[1] & cnt[0]);
        end
        else begin
            red = 1;
            yellow = 0;
            green = 0;
        end
    end


    initial begin
        $dumpfile("testbench.vcd"); 
        $dumpvars(0, clk, cnt, red, yellow, green, button);
        #10 button = 1;
        #60 $finish;
    end

endmodule