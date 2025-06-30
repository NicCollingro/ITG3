module top_level(
  input wire CLOCK_50,
  input wire key0, key1,
  output GPIO_000, GPIO_001, GPIO_002, GPIO_003, 
         GPIO_004, GPIO_005, GPIO_006, GPIO_007,
  output wire[7:0] led
);

  // cycle_clk speekd (useful values: 5-11)
  parameter clk_spd = 7;

  // Clock-ratio mode
  wire [31:0] clkbus;
  wire clk;
  myClock clk0(.clkin(CLOCK_50), .clkout(clkbus));
  assign clk = clkbus[24-clk_spd];
  
  // create the computer...  
  computer m5(
    .clk	(clk),
    .reset	(1'b0),	
    .oport	(led[7:0]),
    .iport	({~key0,~key1,GPIO_000,GPIO_001,GPIO_002,GPIO_003})
  );
endmodule
