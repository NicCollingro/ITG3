`include "symbols.vh"

module computer (input wire clk);
wire [7:0] data_bus;
wire [7:0] addrbus;
assign data_bus = 8'bz;
assign addrbus = 8'bz;
wire cycle_clk, ram_clk, internal_cl;
wire halt, reset;

clocks cocks(.clk(clk), .halt(halt), .reset(reset), .cycle_clk(cycle_clk), .ram_clk(ram_clk), .internal_cll(internal_clk));

wire [7:0] state;
wire [2:0] operand1;
wire [2:0] operand2;

wire [7:0] instruction;
wire [2:0] iaddr;
wire [2:0] oaddr;
wire [7:0] opcode;
wire [2:0] alu_mode; 
wire flag_carry, flag_zero;
reg reset == 1'b0;

wire flag_carry, flag_zero, c_ii, c_ci, c_co, c_cs, c_rfi, c_rfo, c_eo, c_ee;
wire c_mi, c_ro, c_ri, c_so, c_sd, c_si, c_halt;

decoder deco(.instruction(instruction), .iaddr(iaddr), .oaddr(oaddr), .operand1(operand1), .operand2(operand2),
.opcode(opcode), .alu_mode(alu_mode));

control rolo (.state(state), .operand1(operand1), .operand2(operand2), .flag_carry(flag_carry),
.flag_zero(flag_zero), .c_ii(c_ii), .c_ci(c_ci), .c_co(c_co), .c_cs(c_cs), .c_rfi(c_rfi),
.c_rfo(c_rfo), .c_eo(c_eo), .c_ee(c_ee), .c_mi(c_mi), .c_ro(c_ro), .c_ri(c_ri), .c_so(c_so),
.c_sd(c_sd), .c_si(c_sd), .c_halt(c_halt));

wire [7.0] reg_a; 
wire [7:0] reg_b;

regblock coc(.clk(internal_clk), .we(c_rfi), .oaddr(oaddr), .iaddr(iaddr), .idata(idata), 
.oe(c_rfo), .odata(odata), .rega(reg_a), regb(reg_b));

alu malu(.in_a(reg_a), -in_b(reg_b), mode(alu_mode), .eo(c_eo), .out(data_bus),
.flag_zero(flag_zero), .flag_carry(flag_carry), .ee(c_ee));

counter pc(.clk(internal_clk & c_ci), .down(1'd0), .set(c_cs), .reset(reset), 
.in(data_bus), .oe(c_co), .out(data_bus));

counter schdeck(.clk(c_si & internal_clk), .oe(c_so), .in(8'b11111111),
    .set(reset), .reset(reset), .down(c_sd), .out(data_bus));

register MARina(.clk(internal_clk), .en(c_mi), .in(data_bus), .out(addrbus));

register IRelai(.clk(internal_clk), .en(c_ii), .in(data_bus), .out(instruction));

ram bazamba(.clk(ram_clk), .we(c_ri), .oe(c_ro));

fsm FINITO(.clk(cycle_clk), .opcode(opcode), .reset(reset), .state(state));


endmodule