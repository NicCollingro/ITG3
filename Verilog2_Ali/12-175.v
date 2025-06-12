module top_level (
input clk ,
input rst ,
input ix ,
output z1 , z2 , z3 , z4 , z5 , z6 , z7 , z8
);
// Schaltung 1
reg z1 ;
always @ (*)
z1 <= rst ? 0 : ix ;
// Schaltung 2
assign z2 = rst ? 0 : ix ;
// Schaltung 3
reg z3 ;
always @ ( posedge clk )
z3 <= rst ? 0 : ix ;
// Schaltung 4
reg z4 ;
always @ ( posedge clk or posedge rst )
z4 <= rst ? 0 : ix ;
// Schaltung 5
reg z5 ;
always @ ( posedge ( clk | rst ) )
z5 <= rst ? 0 : ix ;
// Schaltung 6
reg z6 ;
always @ ( posedge clk )
z6 <= ix ;
always @ ( posedge rst )
z6 <= 0;
// Schaltung 7
reg z7 ;
always @ ( clk ^ rst )
z7 <= rst ? 0 : ix ;
// Schaltung 8
myDFF DFF0 ( clk | rst , ix &(~ rst ) , z8 ) ;
endmodule