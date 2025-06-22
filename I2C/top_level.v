`include "i2cmaster.v"

module top_level ();

reg clk = 0; 
always #1 clk <= ~clk;
wire G32, G33;

top_level1 topper(.CLOCK_50(clk), .GPIO_032(G32), .GPIO_033(G33));

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0,clk,G32,G33);
    # 100 $finish;
end
    
endmodule

module top_level1(
    input wire CLOCK_50,
    inout wire GPIO_032,
    output wire GPIO_033
);

reg rw = 0;
reg send = 0;
reg [6:0] addr = 7'b0111011;
reg [7:0] data = 8'b01111101;
wire busy;

always @(posedge CLOCK_50) begin
        if (busy) begin
            send <= 0;
    end else send <= 1'd1;
    
end

I2C_master masti (.CLOCK_50(CLOCK_50), .sda(GPIO_032), .scl(GPIO_033),
    .send(send), .busy(busy), .addr(addr), .data(data), .rw(rw));
    
endmodule