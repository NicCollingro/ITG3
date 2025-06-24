`include "symbols.vh"

module fsm (input wire clk, input wire [7:0] opcode,
input wire reset, output reg[7:0] state = 8'b0);
reg [3:0] cycle == 0;

wire reset_cycle = (state == `STATE_NEXT | reset);
always @(negedge clk) begin
    if (reset_cycle) cycle <= 4'd0;
    else cycle <= cycle + 4'd1;
end


endmodule

always @(posedge clk) begin
    case (cycle)
    4'd0: state <= `STATE_FETCH_PC;   //T0
    4'd1: state <= `STATE_FETCH_INST; //T1
    4'd2: begin                      //T2
        case (opcode)
            `OP_HLT:  state <= `STATE_HALT;
            `OP_NOP:  state <= `STATE_NEXT;
            `OP_MOV:  state <= `STATE_MOV_REG;
            `OP_LDI:  state <= `STATE_FETCH_PC;
            `OP_LDX:  state <= `STATE_FETCH_PC;
            `OP_STX:  state <= `STATE_FETCH_PC;
            `OP_CMP:  state <= `STATE_ALU_EXEC;
            `OP_ALU:  state <= `STATE_ALU_EXEC;
            `OP_PUSH: state <= `STATE_FETCH_SP;
            `OP_POP:  state <= `STATE_INC_SP;
            `OP_JMP:  state <= `STATE_FETCH_PC;
            `OP_CALL: state <= `STATE_FETCH_PC;
            `OP_RET:  state <= `STATE_INC_SP; 
        endcase
    end
    4'd3: begin                      //T3
        case (opcode)
            `OP_MOV:  state <= `STATE_NEXT;
            `OP_LDI:  state <= `STATE_SET_REG;
            `OP_LDX:  state <= `STATE_LOAD_ADDR;
            `OP_STX:  state <= `STATE_LOAD_ADDR;
            `OP_CMP:  state <= `STATE_NEXT;
            `OP_ALU:  state <= `STATE_ALU_OUT;
            `OP_PUSH: state <= `STATE_STACK_REG;
            `OP_POP:  state <= `STATE_FETCH_SP;
            `OP_JMP:  state <= `STATE_JUMP;
            `OP_CALL: state <= `STATE_SET_REG;
            `OP_RET:  state <= `STATE_FETCH_SP;
        endcase
    end
    4'd4: begin                     //T4
        case(opcode)
        `OP_LDI:  state <= `STATE_NEXT;
        `OP_LDX:  state <= `STATE_SET_REG;
        `OP_STX:  state <= `STATE_SET_MEM;
        `OP_ALU:  state <= `STATE_NEXT;
        `OP_PUSH: state <= `STATE_NEXT;
        `OP_POP:  state <= `STATE_SET_REG;
        `OP_JMP:  state <= `STATE_NEXT;
        `OP_CALL: state <= `STATE_FETCH_SP;
        `OP_RET:  state <= `STATE_RET;
        endcase
    end
    4'd5: begin                     //T5
        case(opcode) 
        `OP_LDX:  state <= `STATE_NEXT;
        `OP_STX:  state <= `STATE_NEXT;
        `OP_POP:  state <= `STATE_NEXT;
        `OP_CALL: state <= `STATE_STORE_PC;
        `OP_RET:  state <= `STATE_NEXT;
        endcase
    end
    4'd6: begin                    //T6
        case(opcode) 
        `OP_CALL: state <= `STATE_TMP_JUMP;
        endcase
    end
    4'd7: begin                    //T7
        case(opcode)
        `OP_CALL: state <= `STATE_NEXT;
        endcase
    end
    default: state <= 8'bx; //KEK
    endcase 
end
