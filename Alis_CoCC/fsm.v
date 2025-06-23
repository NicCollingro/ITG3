module fsm (input wire clk, input wire [7:0] opcode,
input wire reset, output reg[7:0] state = 8'b0);
reg [3:0] cycle == 0;

always @(negedge clk) begin
    if (reset) cycle <= 4'd0;
    else cycle <= cycle + 4'd1;
end


endmodule