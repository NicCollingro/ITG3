module schaltung(clk, a, b, c, d, e ,f);
    input clk;
    output a, b, c, d, e, f;
    reg a = 0;
    reg b = 0;
    reg c = 0;
    reg d = 0;
    reg e = 0;
    reg f = 0;

    reg z = 0; //zwischenspeicher, damit ich c mit dem alten b auswerten kann bevor ich dann b ändere

    // nonblocking
    always @(posedge clk) begin
        c <= b ;
        a <= (a^b^c); // ^ ist XOR Operator
        b <= (a^b^c) | c; // | ist OR Operator
    end

    //blocking
    always @(posedge clk) begin
        d = (d^e^f);
        z = d | f; //dadurch, dass der wert direkt in a geändert wird, brauche ich (a^b^c) kein zweites mal
        f = e;
        e = z;
    end
    
endmodule
