module top_level(CLOCK_50, key0, key1, led);
input CLOCK_50, key0,key1;
output[7:0] led;
reg [7:0] led;
reg [26:0 ]clk = 26'd0;
reg clock;
always @(posedge CLOCK_50) begin
    clk <= clk + 26'd1;
    clock <= clk[24];
end
reg [2:0] cnt = 3'd0;
reg knopfdruck = 1;
reg [2:0] check = 3'b000;
always @(negedge key1 or negedge key0) begin
  knopfdruck <= 0;
end
reg knopf = 1;

always @(posedge clock)begin
  cnt <= cnt + 3'd1;
  if (knopf == 0) begin
     led [0] <= 0;
     led [1] <= 0;
     led [2] <= 1;
    check <= check + 3'd1; 
  end else begin
    case (cnt)
      3'b111: begin
       led [0] <= 0;
       led [1] <= 1;
       led [2] <= 1;
      end
      3'd0, 3'd1: begin
         led [0] <= 1;
         led [1] <= 0;
         led [2] <= 0;
      end
      3'd2, 3'd3: begin
         led [0] <= 0;
         led [1] <= 1;
         led [2] <= 0;
      end
      default: begin
         led [0] <= 0;
         led [1] <= 0;
         led [2] <= 1;
      end
    endcase  
  end
  /*
  if (cnt == 3'b111 && knopfdruck == 0) begin
    knopf <= 0;
    check <= 3'b000;
  end
  if (check == 3'b111)begin
    knopf <= 1;
  end
  */
end
endmodule

/*
output[7:0] led;
reg [7:0] led;
reg [26:0 ]clk = 26'd0;
reg clock;
always @(posedge CLOCK_50) begin
    clk <= clk + 26'd1;
    clock <= clk[24];
end
wire [3:0] a;
wire [3:0] b;
wire [3:0] x;






module addierer (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);