module top_level(CLOCK_50, key0, led);

  input CLOCK_50, key0;
  output[7:0] led;

  reg[26:0] counter;
  reg[5:0]  PWM_adj;
  reg[6:0]  PWM_width;
  reg[7:0]  led;

  always @(posedge CLOCK_50 or negedge key0) begin
    if (!key0) begin
      counter <= 0;
      led[0]  <= 0;
    end else begin
      counter   <= counter+1;
      PWM_width <= PWM_width[5:0]+ PWM_adj;
      if (counter[26]) begin
        PWM_adj <= counter[25:20];
      end else begin
        PWM_adj <= ~counter[25:20];
      end
      led[0] <= ~PWM_width[6];
      led[1] <= ~PWM_width[6];
      led[2] <= ~PWM_width[6];
      led[3] <= ~PWM_width[6];
      led[4] <=  PWM_width[6];
      led[5] <=  PWM_width[6];
      led[6] <=  PWM_width[6];
      led[7] <=  PWM_width[6];
    end
  end
endmodule
