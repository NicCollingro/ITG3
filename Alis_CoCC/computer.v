`include "symbols.vh"                          //FRAGE der Stackpointer hab ich jetzt noch nicht so verstanden 
                                               // im skript steht auf 0xFF setzen also ahb ich ihn hier mal auf 8'b11111111 
module computer (input wire clk);              // gesetzt aber was genau macht der und wieso 
wire [7:0] data_bus;                           //also jetzt mal bei ner x86_64 CPU und ist der so ähnlich wie die pointer in C ?
wire [7:0] addrbus;
assign data_bus = 8'bz;

wire cycle_clk, ram_clk, internal_cl;
wire halt;

clocks cocks(.clk(clk), .halt(c_halt), .reset(reset), .cycle_clk(cycle_clk), .ram_clk(ram_clk), .internal_clk(internal_clk));

wire [7:0] state;
wire [2:0] operand1;
wire [2:0] operand2;

wire [7:0] instruction;
wire [2:0] iaddr;
wire [2:0] oaddr;
wire [7:0] opcode;
wire [3:0] alu_mode; 
wire flag_carry, flag_zero;
reg reset = 1'b0;                     //sollens ja ohne Reset machen 

wire c_ii, c_ci, c_co, c_cs, c_rfi, c_rfo, c_eo, c_ee;
wire c_mi, c_ro, c_ri, c_so, c_sd, c_si, c_halt, c_da;

decoder deco(.instruction(instruction), .iaddr(iaddr), .oaddr(oaddr), .operand1(operand1), .operand2(operand2),
.opcode(opcode), .alu_mode(alu_mode), .c_da(c_da));

control rolo (.state(state), .operand1(operand1), .operand2(operand2), .flag_carry(flag_carry),
.flag_zero(flag_zero), .c_ii(c_ii), .c_ci(c_ci), .c_co(c_co), .c_cs(c_cs), .c_rfi(c_rfi),
.c_rfo(c_rfo), .c_eo(c_eo), .c_ee(c_ee), .c_mi(c_mi), .c_ro(c_ro), .c_ri(c_ri), .c_so(c_so),
.c_sd(c_sd), .c_si(c_si), .c_halt(c_halt), .c_da(c_da));

wire [7:0] reg_a; 
wire [7:0] reg_b;

regblock coc(.clk(internal_clk), .we(c_rfi), .oaddr(oaddr), .iaddr(iaddr), .idata(data_bus), 
.oe(c_rfo), .odata(data_bus), .rega(reg_a), .regb(reg_b));

alu malu(.in_a(reg_a), .in_b(reg_b), .mode(alu_mode), .eo(c_eo), .out(data_bus),
.flag_zero(flag_zero), .flag_carry(flag_carry), .ee(c_ee));

wire pcclk;
wire spclk;
assign pcclk = (c_ci & internal_clk);
assign pcclk = (c_si & internal_clk);

counter pc(.clk(pcclk), .down(1'd0), .set(c_cs), .reset(reset), 
.in(data_bus), .oe(c_co), .out(data_bus));

counter schdeck(.clk(internal_clk), .oe(c_so), .in(8'b11111111), 
.set(reset), .reset(reset), .down(c_sd), .out(data_bus));

register MARina(.clk(internal_clk), .en(c_mi), .in(data_bus), .out(addrbus));

register IRelai(.clk(internal_clk), .en(c_ii), .in(data_bus), .out(instruction));

ram bazamba(.clk(ram_clk), .we(c_ri), .oe(c_ro), .addr(addrbus), .bus(data_bus));

fsm FINITO(.clk(cycle_clk), .opcode(opcode), .reset(reset), .state(state));

endmodule