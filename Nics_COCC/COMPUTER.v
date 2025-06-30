`include "./symbols.vh"
`include "./CLOCKS.v"
`include "./ALU.v"
`include "./DECODER.v"
`include "./FSM.v"
`include "./RAM.v"
`include "./SC.v"                     
`include "./modules.v"
                                              
module computer (input wire clk);              
wire [7:0] data_bus;                           
wire [7:0] addrbus;
assign data_bus = 8'bz;

wire cycle_clk, ram_clk, internal_cl;
wire halt;

clocks clks(.clk(clk), .halt(halt), .reset(reset), .cycle_clk(cycle_clk), .ram_clk(ram_clk), .internal_clk(internal_clk));

wire [7:0] state;
wire [2:0] operand1;
wire [2:0] operand2;

wire [7:0] instruction;
wire [2:0] iaddr;
wire [2:0] oaddr;
wire [7:0] opcode;
wire [3:0] alu_mode; 
wire flag_carry, flag_zero;
reg reset = 1'b0;               

wire c_ii, c_ci, c_co, c_cs, c_rfi, c_rfo, c_eo, c_ee;
wire c_mi, c_ro, c_ri, c_so, c_sd, c_si, c_halt;

decoder DECODR(.instruction(instruction), .iaddr(iaddr), .oaddr(oaddr), .operand1(operand1), .operand2(operand2),
.opcode(opcode), .alu_mode(alu_mode));

control SC(.state(state), .operand1(operand1), .operand2(operand2), .flag_carry(flag_carry),
.flag_zero(flag_zero), .c_ii(c_ii), .c_ci(c_ci), .c_co(c_co), .c_cs(c_cs), .c_rfi(c_rfi),
.c_rfo(c_rfo), .c_eo(c_eo), .c_ee(c_ee), .c_mi(c_mi), .c_ro(c_ro), .c_ri(c_ri), .c_so(c_so),
.c_sd(c_sd), .c_si(c_si), .c_halt(c_halt));

wire [7:0] reg_a; 
wire [7:0] reg_b;

regblock REGS(.clk(internal_clk), .we(c_rfi), .oaddr(oaddr), .iaddr(iaddr), .idata(data_bus), 
.oe(c_rfo), .odata(data_bus), .rega(reg_a), .regb(reg_b));

alu ALU(.in_a(reg_a), .in_b(reg_b), .mode(alu_mode), .eo(c_eo), .out(data_bus),
.flag_zero(flag_zero), .flag_carry(flag_carry), .ee(c_ee));

counter PC(.clk(internal_clk ), .down(1'd0), .set(c_cs), .reset(reset), 
.in(data_bus), .oe(c_co), .out(data_bus));

counter SP(.clk(internal_clk), .oe(c_so), .in(8'b11111111), 
.set(reset), .reset(reset), .down(c_sd), .out(data_bus));

register MAR(.clk(internal_clk), .en(c_mi), .in(data_bus), .out(addrbus));

register IR(.clk(internal_clk), .en(c_ii), .in(data_bus), .out(instruction));

ram RAM(.clk(ram_clk), .we(c_ri), .oe(c_ro), .addr(addrbus), .data_bus(data_bus));

fsm STATEMACHINE(.clk(cycle_clk), .opcode(opcode), .reset(reset), .state(state));

initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, computer); 
end

endmodule