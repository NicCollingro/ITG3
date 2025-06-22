module top_level ();
    reg clk = 0;
    always #1 clk = ~clk;
    reg sda_r = 0;
    reg oe = 0;
    wire sda;
    assign sda = oe ? 1'bz : sda_r; // rumgedreht hier weil sonst huddel mit volcro
    reg [7:0] wr = 8'b10011101;
    reg dout = 0;

    volcol fokke (.clk(clk), .sda(sda), .oe(oe));

    always @(posedge clk) begin
        dout <= wr[7];
        if (oe == 1'b1) begin 

        end else begin
            sda_r <= wr[7]; 
            wr <= wr << 1;   
        end
    end

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, clk, sda, oe, dout);  
        oe = 0;
        #17 
        #2 oe = 1'bz;// Hier weil sonst beim oe wechsel ein Takt übersprungen
        oe = 1;      // wo das am code liegt ist mir unklar mein guess sind die non-blocking
        #16$finish;  // Finde aber den Fehler nicht also keine Ahnung   
    end              // NEUER GUESS wechsel sind ja nicht instantan also im Default oder 1'd1 case
endmodule           


module volcol (input wire clk, inout wire sda, input wire oe);
reg sda_r = 0;
assign sda = oe ? sda_r : 1'bz;
reg [7:0] Din = 8'd0;

always @(posedge clk) begin
    case (oe)
        1'd1: begin
            sda_r <= Din[0];
            Din <= Din >> 1'b1;
        end
        1'd0: begin
            Din <= {Din[6:0], sda}; 
        end

        default: sda_r <= 1'bz;
        endcase
    end
    
endmodule