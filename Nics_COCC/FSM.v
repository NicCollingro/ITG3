`include "symbols.vh"
module fsm(input [7:0] opcode, input clk, input reset, output reg [7:0] state = 8'b0);
    reg [3:0] cycle;

    always @(negedge clk) begin
        cycle = cycle + 1;
        if(reset | reset_cycle) begin
            cycle = 0;
        end
    end

    assign reset_cycle = (state == `STATE_NEXT | state == `STATE_HLT);

    always @(posedge clk) begin
        case(cycle)
            `T0: state <= `STATE_FETCH_PC;
            `T1: state <= `STATE_FETCH_INST;
            
            `T2: case(opcode)
                `OP_HLT: state <= `STATE_HLT;
                `OP_NOP: state <= `STATE_NEXT;
                `OP_MOV: state <= `STATE_MOV_REG;
                `OP_LDI: state <= `STATE_FETCH_PC;
                `OP_LDX: state <= `STATE_FETCH_PC;
                `OP_STX: state <= `STATE_FETCH_PC;
                `OP_CMP: state <= `STAET_ALU_EXEC;
                `OP_PUSH: state <= `STATE_FETCH_SP;
                `OP_POP: state <= `STATE_INC_SP;
                `OP_JMP: state <= `STATE_FETCH_PC;
                `OP_CALL: state <= `STATE_FETCH_PC;
                `OP_RET: state <= `STATE_INC_SP;
            endcase
            
            `T3: case(opcode)
                `OP_MOV: state <= `STATE_NEXT;
                `OP_LDI: state <= `STATE_SET_REG;
                `OP_LDX: state <= `STATE_LOAD_ADDR;
                `OP_STX: state <= `STATE_LOAD_ADDR;
                `OP_CMP: state <= `STATE_NEXT;
                `OP_ALU: state <= `STATE_ALU_OUT;
                `OP_PUSH: state <= `STATE_STACK_REG;
                `OP_POP: state <= `STATE_FETCH_SP;
                `OP_JMP: state <= `STATE_JUMP;
                `OP_CALL: state <= `STATE_SET_REG;
                `OP_RET: state <= `STATE_FETCH_SP;
            endcase

            `T4: case(opcode)
                `OP_LDI: state <= `STATE_NEXT;
                `OP_LDX: state <= `STATE_SET_REG;
                `OP_STX: state <= `STATE_SET_MEM;
                `OP_ALU: state <= `STATE_NEXT;
                `OP_PUSH: state <= `STATE_NEXT;
                `OP_POP: state <= `STATE_SET_REG;
                `OP_JMP: state <= `STATE_NEXT;
                `OP_CALL: state <= `STATE_FETCH_SP;
                `OP_RET: state <= `State_RET;
            endcase

            `T5: case(opcode)
                `OP_LDX: state <= `STATE_NEXT;
                `OP_STX: state <= `STATE_NEXT;
                `OP_POP: state <= `STATE_NEXT;
                `OP_CALL: state <= `STATE_STORE_PC;
                `OP_RET: state <= `STATE_NEXT;
            endcase

            `T6: state <= `STATE_TMP_JUMP;
            `T7: state <= `STATE_NEXT;
    end

endmodule