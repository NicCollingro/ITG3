`include "keypad.v"

module top_level(input wire CLOCK_50, input wire key0, key1, input wire GPIO_023, GPIO_021, GPIO_019, GPIO_017, output reg GPIO_015,GPIO_013,GPIO_011,GPIO_009, output wire [7:0] led);
    wire [7:0] keycode;

    keycode KBD(.CLOCK_50(CLOCK_50), .cols({GPIO_023, GPIO_021, GPIO_019, GPIO_017}), .rows({GPIO_015,GPIO_013,GPIO_011,GPIO_009}), .keycode(keycode));

    assign led = keycode;
endmodule