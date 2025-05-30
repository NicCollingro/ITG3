/*module tipp1();

    always #1 $display("%3t %d %d", $time, sum1, sum2);

    reg [7:0] sum1=0, sum2=0;

    integer j;
    always @(clk) begin
        for (j=0; j<N; j=j+1)
            sum1 = sum1 + 2;
    end

    always @(clk) begin
        for (j=0; j<N; j=j+1)
            sum2 <= sum2 + 2;
    end

    initial begin
        #1;
        #5;
        #5 $finish;
    end
    
    reg clk = 0;

    always #1 clk = !clk;

    input [7:0] N; // Immer in der Funktion angeben wie viele Bit das Register haben soll, sonst wird automatisch 1 bit
endmodule */

// Da man beim Compilen noch nicht weiß wie viele Register man braucht, kann die forschleife nicht unrolled werden => geht auf runtime nicht compile time

module tipp2();

    reg[3:0] in = 'b0;
    wire out [0:3];
    
    generate
        genvar j;
        for (j=0; j<4; j=j+1)
            inv inv0(.out(out[j]), .in(in[j])); //.out sagt nur, dass was in der klammer ist dem out im inv module ist "anschließen", so könnte man in der klammer auch .in, .out übergeben
    endgenerate

    initial begin
        #0 $display("   in  |   out \n -----+-----");
        #16 $finish;
    end

    always begin
        #1 $display("%b |   %b%b%b%b", in, out[3], out[2], out[1], out[0]);
        in = in + 4'b1;
    end    
endmodule

module inv(output out, input in);
    not not0(out,in);
endmodule
