`include "dff.v"

module top_level();
reg D,clk;
always #1 clk = ~clk;
wire Q;

D_FlipFlop flopper (.D(D), .clk(clk), .Q(Q));

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
module FeedbackOszil (input wire clk, output wire x, input wire reset, output wire y, );
    reg rest;
    reg D1,D2;
    
    always @(posedge clk) begin         //Habs mal mit nem Multiplexer versucht;
        case (reset)                    //Der is ja Kombinatorisch
            1'b1: begin                 // wusste aber nicht wie ich
                D1 <= 0;                // Kombinatorisch die Wire zuweise
                D2 <= 1;
            end 
            default: begin
                D1 <= y;
                D2 <= x;
            end
        endcase

    end

    D_FlipFlop flotti  (.D(D1), .clk(clk), .Q(x));
    D_FlipFlop karotti (.D(D2), .clk(clk), .Q(y));

    
endmodule