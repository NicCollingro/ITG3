`include "symbols.vh"

module control(input wire[7:0] state, input wire [2:0] operand1, 
input wire [2:0]operand2, input wire flag_carry, input wire flag_zero,
output wire c_ii, output wire c_ci, output wire c_co, output wire c_cs, 
output wire c_rfi, output wire c_rfo, output wire c_eo, output wire c_ee, 
output wire c_mi, output wire c_ro, output wire c_ri, output wire c_so, 
output wire c_sd, output wire c_si, output wire c_halt, output wire c_da);

wire jump_allowed = (operand2 == `JMP_JMP) ||
    ((operand2 == `JMP_JZ)  &&  flag_zero) ||
    ((operand2 == `JMP_JNZ) && ~flag_zero) ||
    ((operand2 == `JMP_JC)  &&  flag_carry) ||
    ((operand2 == `JMP_JNC) && ~flag_carry);

//Decoder 
assign c_da = (state == `STATE_SET_MAR) ? 1 : 0;
//IR
assign c_ii = (state == `STATE_FETCH_INST) ? 1 : 0; 
//PC
assign c_ci = (state == `STATE_FETCH_PC) ? 1 : (state == `STATE_JUMP  & jump_allowed) ? 1 : (state == `STATE_TMP_JUMP) ? 1 : (state == `STATE_RET) ? 1 : 0;
assign c_co = ( state == `STATE_FETCH_PC) ? 1 : (state == `STATE_STORE_PC) ? 1 : 0; 
assign c_cs = (state == `STATE_JUMP & jump_allowed) ? 1 : (state == `STATE_TMP_JUMP) ? 1 : (state == `STATE_RET) ? 1 : 0;
//CPU-REG
assign c_rfi = (state == `STATE_ALU_OUT) ? 1 : (state == `STATE_SET_REG) ? 1 : (state == `STATE_MOV_REG) ? 1 : 0;
assign c_rfo = (state == `STATE_SET_REG) ? 1 : (state == `STATE_MOV_REG) ? 1 : (state == `STATE_STACK_REG) ? 1 : (state == `STATE_TMP_JUMP) ? 1 : 0;
//ALU
assign c_eo = (state == `STATE_ALU_OUT) ? 1 : 0;
assign c_ee = (state == `STATE_ALU_EXEC) ? 1 : 0;
//MAR
assign c_mi = (state == `STATE_FETCH_PC) ? 1 : (state == `STATE_LOAD_ADDR) ? 1 : (state == `STATE_FETCH_SP) ? 1 : 0;
//RAM
assign c_ri = (state == `STATE_STORE_PC) ? 1 : (state == `STATE_SET_MEM) ? 1 : (state == `STATE_STACK_REG) ? 1 : 0;
assign c_ro = (state == `STATE_FETCH_INST) ? 1 : (state == `STATE_LOAD_ADDR) ? 1 : (state == `STATE_SET_REG) ? 1 : 0;
//SP
assign c_si = (state == `STATE_STACK_REG) ? 1 : (state == `STATE_INC_SP) ? 1 : (state == `STATE_TMP_JUMP) ? 1 : 0;
assign c_so = (state == `STATE_FETCH_SP) ? 1 : 0;
assign c_sd = (state == `STATE_STACK_REG) ? 1 : (state == `STATE_TMP_JUMP) ? 1 : 0;
//System 
assign c_halt = (state == `STATE_HALT) ? 1 : 0;

endmodule