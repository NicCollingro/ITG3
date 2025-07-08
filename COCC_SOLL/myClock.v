module myClock(clkin, clkout);
  input wire clkin;
  output reg[31:0] clkout;

  always @(posedge clkin) begin
    clkout <= clkout + 1'b1;
  end
endmodule

