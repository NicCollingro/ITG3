//`include "symbols.vh"
module decoder(input wire [7:0] instruction, output reg [2:0] iaddr,output reg [2:0] oaddr, output wire[2:0] operand1, output wire[2:0] operand2, output reg[7:0] opcode, output reg[2:0] alu_mode);
    assign operand1 = instruction[5:3];
    assign operand2 = instruction[2:0];

    // Opccode - Decoder
    always @ (*) begin
        casez ( instruction )
            `PATTERN_NOP: opcode <= `OP_NOP;
            `PATTERN_HLT: opcode <= `OP_HLT;
            `PATTERN_CALL:opcode <= `OP_CALL;
            `PATTERN_RET: opcode <= `OP_RET;
            `PATTERN_CMP: opcode <= `OP_CMP;
            `PATTERN_ALU: opcode <= `OP_ALU;
            `PATTERN_LDI: opcode <= `OP_LDI;
            `PATTERN_LDX: opcode <= `OP_LDX;
            `PATTERN_STX: opcode <= `OP_STX;
            `PATTERN_PUSH:opcode <= `OP_PUSH;
            `PATTERN_POP: opcode <= `OP_POP;
            `PATTERN_JMP: opcode <= `OP_JMP;
            `PATTERN_MOV: opcode <= `OP_MOV;
            default : opcode <= instruction;
        endcase
    end
    // ALU - Mode Decoder
    always @ (*) begin
        case ( opcode )
            `OP_ALU : alu_mode <= operand2;
            `OP_CMP : alu_mode <= `ALU_SUB;
        default : alu_mode <= 3'bx;
    endcase
    end
    // iaddr - Decoder
    always @ (*) begin
        case ( opcode )
            `OP_ALU : iaddr <= `REG_A;
            `OP_CALL : iaddr <= `REG_H;
            //`OP_IN : iaddr <= [...]
            `OP_LDX : iaddr <= operand2;
            `OP_LDI : iaddr <= operand2;
            `OP_MOV : iaddr <= operand1;
            `OP_POP : iaddr <= operand2;
        default : iaddr <= 3'bx;
    endcase
    end
    // oaddr - Decoder
    always @ (*) begin
        case (opcode)
            `OP_CALL:  oaddr <= `REG_H;
            `OP_MOV:   oaddr <= operand2;
            `OP_STX:   oaddr <= operand2;
            `OP_PUSH:  oaddr <= operand2;
            //`OP_ROUT:  oaddr <= operand2;
        endcase
    end
endmodule