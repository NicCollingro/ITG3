`include "symbols.vh"

module computer (input wire clk);
wire  [7:0] data_bus;
assign data_bus = 8'bz;
wire cycle_clk, ram_clk, internal_cl;
wire halt, reset;

clocks cocks(.clk(clk), .halt(halt), .reset(reset), .cycle_clk(cycle_clk), .ram_clk(ram_clk), .internal_cll(internal_clk));

wire [7:0] state;
wire [2:0] operand1;
wire [2:0] operand2;
wire flag_carry, flag_zero, c_ii, c_ci, c_co, c_cs, c_rfi, c_rfo, c_eo, c_ee;
wire c_mi, c_ro, c_ri, c_so, c_sd, c_si, c_halt;

control rolo (.state(state), .operand1(operand1), .operand2(operand2), .flag_carry(flag_carry),
.flag_zero(flag_zero), .c_ii(c_ii), .c_ci(c_ci), .c_co(c_co), .c_cs(c_cs), .c_rfi(c_rfi),
.c_rfo(c_rfo), .c_eo(c_eo), .c_ee(c_ee), .c_mi(c_mi), .c_ro(c_ro), .c_ri(c_ri), .c_so(c_so),
.c_sd(c_sd), .c_si(c_sd), .c_halt(c_halt));

wire [7:0] instruction;
wire [2:0] iaddr;
wire [2:0] oaddr;
wire [2:0] operand1;
wire [2:0] operand2;
wire [7:0] opcode;
wire [2:0] alu_mode; 
decoder deco(.instruction(instruction), .iaddr(iaddr), .oaddr(oaddr), .operand1(operand1), .operand2(operand2),
.opcode(opcode), .alu_mode(alu_mode));

endmodule