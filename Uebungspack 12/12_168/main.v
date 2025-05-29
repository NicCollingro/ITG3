module top_level;
    
    initial begin
        $monitor("%t  %b  %b   %b %b %b  %b %b %b",
              $time, clk, in, b1, b2, b3, n1, n2, n3); //printe in jedem durchlauf den durchlauf , den wert der clock, des inputs und der kabel b1 b2 b3 n1 n2 n3
        #0  in = 0; //setze im 0. durchlauf in auf 0
        #6  in = 1; //setze nach 6 durchläufen in auf 1
        #6  $finish; //beende programm nach weiteren 6 durchläufen
    end

    //clock signal
    reg clk = 0;    //starte mit clock = 0
    always #1 clk = !clk; //setze jeden durchlauf die clock auf den jeweils anderen wert

    reg in; //erstellung des inputs im register

    wire b1, b2, b3;    //erstellung der wire
    blocking B(in, clk, b1, b2, b3); //Funktionenaufruf

    wire n1, n2, n3;    //analog
    nonblocking N(in, clk, n1, n2, n3);
endmodule

module blocking(in, clk, q1, q2, q3); //Definiert modul und gibt "verbundene" wire an
    input in, clk; //definiert Inputs
    output q1, q2, q3; // definiert Outputs
    reg q1, q2, q3; //Ähnlich zu unserem python programm Register funktion

    always @(posedge clk) begin //funktion immer dann wenn clk positive Flanke hat
        q1 = in; //setze q1 = dem wert der durch in anliegt
        q2 = q1; //setze q2 = q1
        q3 = q2; //setze q3 = q2 ; damit setzt man direkt q3 = in
    end
endmodule

module nonblocking(in, clk, q1, q2, q3); //Analog zu blocking modul
    input in, clk;
    output q1, q2, q3;
    reg q1, q2, q3;

    always @(posedge clk) begin
        q1 <= in; // <= schreibt den wert in die variable aber erst nachdem die funktion beendet wurde, somit schreibt man nicht direkt in in q3 sondern erst nach dem 3. durchlauf
        q2 <= q1;
        q3 <= q2;
    end
endmodule

//blocking entspricht einem DE-Flipflop und nonblocking einer verkettung von DE-Flipflops bzw einem 3-Delay-Filter