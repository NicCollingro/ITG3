`include "I2C_master.v"

module top_level(input wire CLOCK_50, input wire GPIO_023, input  wire GPIO_033);
    wire sending, datawire, clock, clockline, busywire;
    wire [7:0] data;
    wire [6:0] addr;
    assign data = 8'b10100101;
    assign addr = 7'b0011010;
    wire rw;
    assign rw = 1'b0;
    reg sending_reg = 0;
    assign sending = sending_reg;
    I2C_master MYI2C(.clk(CLOCK_50),.sda(datawire), .scl(clockwire), .send(sending), .busy(busywire), .data(data), .addr(addr), .rw(rw));

    assign GPIO_032 = clockwire;
    assign GPIO_033 = datawire;

    initial begin
        $monitor("%t , sda: %b, scl: %b", $time, datawire, clockwire);
        #10 sending_reg = 1;
        #100 $finish;
    end
endmodule