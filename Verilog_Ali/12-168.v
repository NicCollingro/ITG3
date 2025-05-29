module blocking ( in , clk , q1 , q2 , q3 ) ;
    input in , clk ;
    output q1 , q2 , q3 ;
    reg q1 , q2 , q3 ;
                                    //
    always @ ( posedge clk ) begin  // das setzt alle 3 Outputs direkt auf "in" weil soweit chs verstanden habe die Gleichstellung direkt erfolgt und nicht 
    q1 = in ;                       // danach
    q2 = q1 ;
    q3 = q2 ;
    end
endmodule


module nonblocking ( in , clk , q1 , q2 , q3 ) ;
    input in , clk ;
    output q1 , q2 , q3 ;
    reg q1 , q2 , q3 ;

    always @ ( posedge clk ) begin    //Das hier könnte man als delay benutzen als 3-delay oder maybe als bitshifter nach Links wenn q1 das least significant bit ist und dann,
    q1 <= in ;                        // mit "in" addieren also ich habe 111 in = 1 wird zu 110 + 1  = 111 
    q2 <= q1 ;
    q3 <= q2 ;
    end
endmodule


module top_level ;

    initial begin
        $monitor ( " % t % b % b % b % b % b % b % b % b " ,
        $time , clk , in , b1 , b2 , b3 , n1 , n2 , n3 ) ;
        #0 in = 0; 
        #6 in = 1;
        #6 $finish ;
    end

 // clock signal
    reg clk = 0;
    always #1 clk = ! clk ;

    reg in ;

    wire b1 , b2 , b3 ;
    blocking B ( in , clk , b1 , b2 , b3 ) ;

    wire n1 , n2 , n3 ;
    nonblocking N ( in , clk , n1 , n2 , n3 ) ;

endmodule