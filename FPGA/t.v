module Fpga(CLOCK_50, key0, ,key1, led);
input CLOCK_50, key0,key1;
output[7:0] led;

  reg[26:0] counter;
  reg[5:0]  PWM_adj;
  reg[6:0]  PWM_width;
  reg[7:0]  led;

  always @(negedge key0) begin
    led <= led + 1;
  end
  always @(negedge key1) begin
    led <= led - 1;
  end
endmodule