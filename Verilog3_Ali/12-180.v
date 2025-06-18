module top_level (); // Steuereinheit
reg clk = 0;
always #1 clk = ~clk; // Frage wweiter unten
wire [7:0] Databus;
reg re1, re2, re3;
reg we1, we2, we3;
wire [7:0] fremd1;
wire [7:0] fremd2; 
wire [7:0] fremd3;

HOST_A a(.clk(clk), .Databus(Databus), .fremd(fremd1), .re(re1), .we(we1));
HOST_B b(.clk(clk), .Databus(Databus), .fremd(fremd2), .re(re2), .we(we2));
HOST_C c(.clk(clk), .Databus(Databus), .fremd(fremd3), .re(re3), .we(we3));

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, top_level);
        #2;
        re1 = 0; re2 = 0; re3 = 0;
        we1 = 0; we2 = 0; we3 = 0;
        #2; 
        we1 = 1; 
        #2;
        re2 = 1;
        #2;
        we1 = 0; re2 = 0;
        #2;
        we2 = 1;
        #2;
        re1 = 1;
        #2;
        we2 = 0; re1 = 0;
        #2
        we2 = 1; re2 = 1;
        #2
        re1 = 1;
        #2
        we2 = 0; re2 = 0; re1 = 0;
        #2 $finish;
    end

endmodule

module HOST_A (input wire clk, inout wire [7:0] Databus, output reg [7:0] fremd,
input wire re, input wire we);
reg [7:0] host_id = 8'b11111111;
reg [7:0] db_r = 8'b11111111; // init da sonst Databus für n Tackt auf xxxxxxxx kann 
assign Databus = (we && !re) ? db_r : 8'bz; // geht das schöner weil das ist Ugly
                                            // ja auch nit einfach die db_r zu nem Blocking machen
always @(posedge clk) begin                 // ändert nix
    if (we == 1 && re == 0 )begin           // kann Taktverzögern das es bei ner negedge zu we = 1 und
        db_r <= host_id;                    // re == 0 wird aber auch ugly
    end else if (re == 1 && we == 0)begin
        fremd <= Databus;
    end
    
end
endmodule

module HOST_B (input wire clk, inout wire [7:0] Databus, output reg [7:0] fremd,
input wire re, input wire we);
reg [7:0] host_id = 8'b01111111;
reg [7:0] db_r = 8'b01111111;
assign Databus = (we && !re) ? db_r : 8'bz;

always @(posedge clk) begin
    if (we == 1 && re == 0 )begin
        db_r <= host_id;
    end else if (re == 1 && we == 0)begin
        fremd <= Databus;
    end
    
end
endmodule

module HOST_C (input wire clk, inout wire [7:0] Databus, output reg [7:0] fremd,
input wire re, input wire we);
reg [7:0] host_id = 8'b10111111;
reg [7:0] db_r = 8'b10111111; 
assign Databus = (we && !re) ? db_r : 8'bz;

always @(posedge clk) begin
    if (we == 1 && re == 0 )begin
        db_r <= host_id;
    end else if (re == 1 && we == 0)begin
        fremd <= Databus;
    end
end  
endmodule