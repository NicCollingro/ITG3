`include "symbols.vh"
module control(input wire [7:0] state , input wire [2:0] operand2, input wire flag_zero, input wire flag_carry, output wire c_ii, c_ci, c_co, c_cs, c_rfi, c_rfo, c_eo, c_ee, c_mi, c_ro, c_ri, c_so, c_sd, c_si, c_halt);
    //&ja eval
    reg jaeval;
    always @(operand2) begin
        case(operand2)
            `JMP_JMP: jaeval = 1;
            `JMP_JZ: jaeval = flag_zero ? 0:1;
            `JMP_JNZ: jaeval = flag_zero ? 1:0;
            `JMP_JC: jaeval = flag_carry ? 0:1;
            `JMP_JNC: jaeval = flag_carry ? 1:0;
        endcase
    end
    
    //IR
    assign c_ii = (state == `STATE_FETCH_INST) ? 1 : 0;
    
    //PC
    assign c_ci = (state == `STATE_FETCH_PC | state == `STATE_TMP_JUMP | state == `STATE_RET | ((state == `STATE_JUMP) & jaeval)) ? 1:0;
    assign c_co = (state == `STATE_FETCH_PC | state == `STATE_STORE_PC) ? 1:0;
    assign c_cs = (state == `STATE_TMP_JUMP | state == `STATE_RET |((state == `STATE_JUMP) & jaeval)) ? 1:0;

    //CPU-REG
    assign c_rfi = (state == `STATE_ALU_OUT | state == `STATE_SET_REG | state == `STATE_MOV_REG) ? 1:0;
    assign c_rfo = (state == `STATE_SET_MEM | state == `STATE_MOV_REG | state == `STATE_STACK_REG | state == `STATE_TMP_JUMP) ?  1:0;
    assign c_eo = (state == `STATE_ALU_OUT) ? 1:0;
    assign c_ee = (state == `STATE_ALU_EXEC) ? 1:0;
    assign c_mi = (state == `STATE_FETCH_PC | state == `STATE_LOAD_ADDR | state == `STATE_FETCH_PC) ? 1:0;
    assign c_ri = (state == `STATE_STORE_PC | state == `STATE_SET_MEM | state == `STATE_STACK_REG) ? 1:0;
    assign c_ro = (state == `STATE_FETCH_INST | state == `STATE_LOAD_ADDR | state == `STATE_SET_REG | state == `STATE_RET |((state == `STATE_JUMP) & jaeval)) ? 1:0;
    assign c_si = (state == `STATE_STACK_REG | state == `STATE_INC_SP | state == `STATE_TMP_JUMP) ? 1:0;
    assign c_so = (state == `STATE_FETCH_SP) ? 1:0;
    assign c_sd = (state == `STATE_STACK_REG | state == `STATE_TMP_JUMP) ? 1:0;
    assign c_halt = (state == `STATE_HALT) ? 1:0;
endmodule