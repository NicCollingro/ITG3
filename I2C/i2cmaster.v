module I2C_master (imput wire CLOCK_50, inout wire sda, output wire scl, input wire send, output wire busy,
input wire [6:0] addr, input wire [7:0] data , input wire rw);
reg sda_oe, sda_r, clk;
reg [20:0] help;
assign sad = sda_oe ? sda_r : 1'bz;
always @(posedge CLOCK_50); begin
    help <= help + 1;
    clk <= help[18];
end



endmodule