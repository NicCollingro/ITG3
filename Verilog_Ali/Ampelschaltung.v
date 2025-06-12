module top_level();
    reg clk = 0;
    reg g,y,r;
    always #1 clk = ~clk;         //knöpfe starten ja bei 1 hast du gemeint sollte aber
    reg [2:0] cnt;                // keinen Unterschied machen 
    reg [2:0] tk;                 // mit knopfdruch fange ich einfach ab wenn der knopf
    reg knopf  = 1;               // gedrückt wurde ausserhalb vom posedge 
    reg knopfdruck = 1;           // keine Ahnung wies einfacher geht maybe ohne posedge aber     
    always @(negedge knopf) begin // würde es ja nicht zünden wenn gerade keine taktänderun ist
        knopfdruck <= 0;
    end
    always @(posedge clk) begin 
        if (knopfdruck == 0 && cnt == 3'd6) begin
            tk <= tk + 1;
            if (tk == 3'd7) begin 
                r <= 1;
                y <= 0;
                g <= 0;
                $display ("HELOOOOOO");
                knopfdruck <= 1;
                cnt <= cnt + 3'd1;
                tk <= 3'd0;
            end
        end else cnt  <= cnt + 3'd1;
    end

    always @(clk) begin
        case (cnt)
            3'b111: begin
                r = 1;
                y = 1;
                g = 0;
            end
            3'd0, 3'd1: begin
                r = 0;
                y = 0;
                g = 1;
            end
            3'd2, 3'd3: begin
                r = 0;
                y = 1;
                g = 0;
            end
            default: begin
                r = 1;
                y = 0;
                g = 0;
            end
        endcase
        end
    
    // Testbench
    always 
        #2 $display("%4t %b    | %b | %b | %b  |   %b", $time , cnt ,g,y,r, knopfdruck);
    
    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0, top_level);    
        $display("   T  cnt | g | y | r | knopfdruck |\n--------------------------------");
        cnt = 3'd0; tk = 3'd0; knopf = 1;
        #2 knopf = 0;
        #4 knopf = 1;
        #100 $finish;
    end
endmodule